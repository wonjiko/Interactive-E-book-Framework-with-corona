-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- 배경화면을 로드한다."
local backgroundImage = display.newImage("res/background.png");
backgroundImage.y = display.contentHeight / 2 + display.statusBarHeight;

-- xml 파일 로드하여, 그에 맞는 컨텐츠를 보여주어야 한다. 보여주어야 할 것은 head, body, foot 로 나뉘어진다.
-- head 부분에서는 장(chapter)와 절(verse)를 나타낸다.
-- body에서는 이미지, 비디오, 오디오, 텍스트 정보를 보여준다. 이때 보여주는 내용은 xml에 기술되어 있다.
-- footer에서는 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다.
-- #programmer Cheechyo, LnS in JejuUniv.

-- 페이지에 사용될 변수/상수들을 정의하고 초기화한다.
local currentChapterIntex = -1;
local maxChapterIndex = -1;
local minChapterIndex = -1;
local currentVerseIndex = -1;
local maxVerseIndex = -1;
local minVerseIndex = -1;
local currentPageIndex = -1;
local minPageIndex = -1;
local maxPageIndex = -1;

local isXmlLoad = false;
-- TODO xml 파일을 로드한다.

-- head 설정.
-- TODO head에는 장(chapter)과 절(verse)을 보여주고, 현재 선택된 장(chapter)과 절(verse)이 어떤것인지 색깔로 표현한다.
local headViewGroup = display.newGroup();
local pageIndexViewGroup = display.newGroup();

---[[ testCase : maxPageIndex 5 일때
maxChapterIndex = 4; 
minChapterIndex = 0;
--]]

-- chapter를 나타내는 버튼을 만든다.
--local rect = display.newRect(20,display.statusBarHeight+10,280,24);
--rect.fillColor = {110, 30, 25};
local chapterIndexViewGroup = display.newGroup();
local chapterMargin = 40;
local chapterIndexWidth = 48;
local chapterPadding;
if maxChapterIndex % 2 == 0 then
	-- 장수가 홀수일때 (index는 짝수)
	chapterPadding = 0;
	if maxChapterIndex == 0 then
 		chapterPadding = chapterPadding + chapterIndexWidth * 2;
	elseif maxChapterIndex == 2 then
 		chapterPadding = chapterPadding + chapterIndexWidth;
	elseif maxChapterIndex == 4 then
		chapterPadding = chapterPadding + 0;
	end

else
	-- 장수가 짝수일때 (index는 홀수)
	chapterPadding = 24;
	if maxChapterIndex == 1 then
		chapterPadding = chapterPadding + 48;
	else
		chapterPadding = chapterPadding;
	end
end
-- 장 인덱스를 그리는 부분
for i = 0, maxChapterIndex, 1 do
	local aChapterIndexView = display.newText((i+1).."장", chapterMargin + chapterPadding + i * chapterIndexWidth + 6, display.statusBarHeight+13, null, 20);
	function aChapterIndexView:tap(event)
		print("Tapped index : " .. i);
		gotoChapter(i);
	end
	aChapterIndexView:addEventListener("tap", aChapterIndexView);
	chapterIndexViewGroup:insert(aChapterIndexView);
	headViewGroup:insert(aChapterIndexView);
	-- 모서리가 각진 네모
	--local aRect = display.newRect(chapterMargin + chapterPadding + i * chapterIndexWidth, display.statusBarHeight+10, 42, 30)
	-- 모서리가 둥근 네모
	local aRect = display.newRoundedRect(chapterMargin + chapterPadding + i * chapterIndexWidth, display.statusBarHeight+10, 42, 30, 5)
	aRect.strokeWidth = 3;
	aRect:setFillColor(0, 0, 0, 0);
	aRect:setStrokeColor(255, 255, 255);
	chapterIndexViewGroup:insert(aRect);
	headViewGroup:insert(aRect);
end

--[[
local aChapterIndexView = display.newText("-장", display.contentWidth / 2 - 16, display.statusBarHeight+10, null, 20);
local aPageIndexView = display.newText("-절", display.contentWidth / 2 - 14, display.statusBarHeight+40, null, 18);
--]]
-- TODO body 설정
local bodyViewGroup = display.newGroup();

-- foot 설정.
-- 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다
local footViewGroup = display.newGroup();
-- 왼쪽 화살표 설정
local larrow = display.newImage("res/larrow.png");
footViewGroup:insert(larrow);
larrow.width = 30;
larrow.height = 30;
larrow.x = display.contentWidth * 1 / 6;
larrow.y = display.contentHeight - 25;
-- 이전 버튼 생성
local privPageBtn = display.newText("이전", display.contentWidth * 2 / 6 - 22, display.contentHeight - 45, null, 24);
footViewGroup:insert(privPageBtn);
function privPageBtn:tap(event)
	gotoPrivPage(event);
end
privPageBtn:addEventListener("tap", gotoPrivPage);
-- 종료 버튼 생성
local exitPageBtn = display.newText("종료", display.contentWidth * 3 / 6 - 22, display.contentHeight - 45, null, 24);
footViewGroup:insert(exitPageBtn);
function exitPageBtn:tap(event)
	exitPage(event);
end
exitPageBtn:addEventListener("tap", exitPage);
-- 다음 버튼 생성
local nextPageBtn = display.newText("다음", display.contentWidth * 4 / 6 - 22, display.contentHeight - 45, null, 24);
footViewGroup:insert(nextPageBtn);
function nextPageBtn:tap(event)
	gotoNextPage(event);
end
nextPageBtn:addEventListener("tap", gotoNextPage);
-- 오른쪽 화살표 설정
local rarrow = display.newImage("res/rarrow.png");
footViewGroup:insert(rarrow);
rarrow.width = 30;
rarrow.height = 30;
rarrow.x = display.contentWidth * 5 / 6;
rarrow.y = display.contentHeight - 25;

-- 화면을 다루는 함수들의 목록
function gotoChapter(index)
	print("Goto Chapter : " .. currentChapterIntex .. " to " .. index);
	currentChapterIntex = index
end
-- 다음 페이지로 이동하는 함수
function gotoNextPage(event)
	print("Moving page : ".. currentPageIndex .." to "..currentPageIndex+1);
	currentPageIndex = currentPageIndex + 1;
end
-- 이전 페이지로 이동하는 함수
function gotoPrivPage(event)
	print("Moving page : ".. currentPageIndex .." to "..currentPageIndex-1);
	currentPageIndex = currentPageIndex - 1;
end
-- 종료를 수행하는 함수
function exitPage(event)
	--[[
	currentPageIndex = 0;q
	currentVerseIndex = 0;
	currentChapterIntex = 0;
	--]]
	-- 무엇을 해야 하는지 아직 정해지지 않음
	print("Exit.");
end
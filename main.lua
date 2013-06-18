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
local currentChapterIntex = 0;
local maxChapterIndex = 0;
local minChapterIndex = 0;
local currentVerseIndex = 0;
local maxVerseIndex = 0;
local minVerseIndex = 0;
local currentPageIndex = 0;
local minPageIndex = 0;
local maxPageIndex = 0;

local isXmlLoad = false;
-- TODO xml 파일을 로드한다.

-- head 설정.
-- TODO head에는 장(chapter)과 절(verse)을 보여주고, 현재 선택된 장(chapter)과 절(verse)이 어떤것인지 색깔로 표현한다.
local headViewGroup = display.newGroup();

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
-- 다음 페이지로 이동하는 함수
function gotoNextPage(event)
	print("Moving page : ".. currentPageIndex .." to "..currentPageIndex+1);
	currentPageIndex = currentPageIndex + 1;
end
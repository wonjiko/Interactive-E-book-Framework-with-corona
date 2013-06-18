-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- 배경화면을 로드한다."
local backgroundImage = display.newImage("res/background.png");
backgroundImage.y = display.contentHeight/2+ display.statusBarHeight;

-- xml 파일 로드하여, 그에 맞는 컨텐츠를 보여주어야 한다. 보여주어야 할 것은 head, body, foot 로 나뉘어진다.
-- head 부분에서는 장(chapter)와 절(verse)를 나타낸다.
-- body에서는 이미지, 비디오, 오디오, 텍스트 정보를 보여준다. 이때 보여준ㄴ 내용은 xml에 기술되어 있다.
-- footer에서는 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다.
-- #programmer Cheechyo
local currentChapterIntex = 0;
local currentVerseIndex = 0;
local currentPageIndex = 0;

-- footer 설정. 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다
-- 왼쪽 화살표 설정
local larrow = display.newImage("res/larrow.png");
larrow.width = 30;
larrow.height = 30;
larrow.x = display.contentWidth * 1 / 6;
larrow.y = display.contentHeight - 25;

-- 이전 버튼 생성
local privPageBtn = display.newText("이전", display.contentWidth * 2 / 6 - 22, display.contentHeight - 45, null, 24);
function privPageBtn:tap(event)
	gotoPrivPage(event);
end
privPageBtn:addEventListener("tap", gotoPrivPage);

-- 종료 버튼 생성
local exitPageBtn = display.newText("종료", display.contentWidth * 3 / 6 - 22, display.contentHeight - 45, null, 24);
function exitPageBtn:tap(event)
	exitPage(event);
end
exitPageBtn:addEventListener("tap", exitPage);

-- 다음 버튼 생성
local nextPageBtn = display.newText("다음", display.contentWidth * 4 / 6 - 22, display.contentHeight - 45, null, 24);
function nextPageBtn:tap(event)
	gotoNextPage(event);
end
nextPageBtn:addEventListener("tap", gotoNextPage);

-- 오른쪽 화살표 설정
local rarrow = display.newImage("res/rarrow.png");
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
	currentPageIndex = 0;
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
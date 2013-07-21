-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local DEBUG = true

-- 배경화면을 로드한다."
local backgroundImage = display.newImage("res/background.png");
backgroundImage.y = display.contentHeight / 2 + display.statusBarHeight;

-- xml 파일 로드하여, 그에 맞는 컨텐츠를 보여주어야 한다. 보여주어야 할 것은 head, body, foot 로 나뉘어진다.
-- head 부분에서는 장(chapter)와 절(verse)를 나타낸다.
-- body에서는 이미지, 비디오, 오디오, 텍스트 정보를 보여준다. 이때 보여주는 내용은 xml에 기술되어 있다.
-- footer에서는 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다.
-- #programmer Cheechyo, LnS in JejuUniv.

local body = nil
-- 파일을 로드하여, 장과 절의 갯수를 계
local lfs = require "lfs"
local chapterNum = 0;
local doc_path = system.pathForFile( "", system.DocumentsDirectory )
print("path : " .. doc_path)
for afile in lfs.dir(doc_path) do
	if DEBUG then
		print( "Found file or directory : " .. afile )
	end

	if afile == "Chapter1" then
		chapterNum = 1
	elseif afile == "Chapter2"  then
		chapterNum = 2
	elseif afile == "Chapter3" then
		chapterNum = 3
	elseif afile == "Chapter4" then
		chapterNum = 4
	elseif afile == "Chapter5" then
		chapterNum = 5
	end
end

local head = require("headindex").makeHeadIndex(chapterNum)
-- 각 장을 선택했을때 그에 맞는 절이 나오도록 하고, 각 문서 경로르 지정
for i = 0, chapterNum-1, 1 do
	local aView = head.chapterViewArr[i]
	aView.index = i
	function aView:tap(event)
		local verseNum = 0;
		local doc_path = system.pathForFile("Chapter"..(i+1), system.DocumentsDirectory )

		for afile in lfs.dir(doc_path) do
			if DEBUG then
				print( "Found file or directory : " .. afile )
			end

			if afile == "verse"..string.format("%d",1)..".xml" then
				verseNum = 1
			elseif afile == "verse"..string.format("%d",2)..".xml"  then
				verseNum = 2
			elseif afile == "verse"..string.format("%d",3)..".xml" then
				verseNum = 3
			elseif afile == "verse"..string.format("%d",4)..".xml" then
				verseNum = 4
			elseif afile == "verse"..string.format("%d",5)..".xml" then
				verseNum = 5
			end
		end
		if DEBUG then
			print("verseNum : ".. verseNum)
		end
		head:makeVerseIndexChooser(verseNum)

		for i = 0, verseNum-1, 1 do
			local aVerseView = head.verseViewArr[i]
			-- 각 절이 선택되었을때 문서 path 지정
			function aVerseView:tap(event)
				-- 인앱 디렉토리를 찾아서 저장. -> 시뮬레이터시 버그
				--local docPath = system.pathForFile( "", system.DocumentsDirectory ).."/Chapter".. (aView.index+1).."/verse"..(i+1)..".xml"

				-- 시뮬레이터용 디렉토리설정
				local docPath = "doc".."/Chapter".. (aView.index+1).."/verse"..(i+1)..".xml"
				if DEBUG then
					print("doc : " .. docPath)
				end
				if body ~= nil then
					body:clearPage()
				end
				loadDocument(docPath)
			end
			aVerseView:addEventListener("tap", aVerseView);
		end
	end
	aView:addEventListener("tap", aView);
end

-- TODO body 설정
function loadDocument(path)
	body = require("body").makeBodyContents(path)
end 

-- Foot 설정.
local foot = require("foot").makeFootController()

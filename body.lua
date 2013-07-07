module(..., package.seeall)
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- 가로 320 세로 325의 부분을 내용들로 채우는 부분
-----------------------------------------------------------------------------------------

function makeBodyContents( ... )
	Body = {}
	--[[ body부분을 하얗게 칠함
	local bodybg = display.newRect(0, display.statusBarHeight+10+80, display.contentWidth, 325) 
	--]]
	local contents = display.newGroup()
	contents.x = 9
	contents.y = display.statusBarHeight+10+80

	function countTextLine(textString)
		local num = 0
		local obj = display.newText(textString, 0, 0, null, 16);
		num = math.floor(obj.width / 302)
		obj.isVisible = false;
		return num+1
	end

	--[[ 이미지 요소 삽입 테스트
	--local obj = display.newImage("res/larrow.png");
	--contents:insert(obj)
	--]]

	--[[ 텍스트 요소 삽입 테스트
	local text = "a2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789b"
	local line = 3
	local obj = display.newText(text, 0, 0, display.contentWidth - 18, (16 + 3) * line, null, 16);
	contents:insert(obj)
	--]]

	--[[ 텍스트 요소 삽입 테스트
	local text = "가나다라2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789ba2345678901234567890123456789b"
	local line = 17
	local obj = display.newText(text, 0, 0, display.contentWidth - 18, (16 + 3) * line, null, 16);
	contents:insert(obj)
	--]]

	--[[xml 로드 테스트
	local xml = require( "xml" ).newParser()
	local contents = xml:loadFile( "sample.xml" )
	local message = {}
	-- for each "child" in the contents table...
	for i=1,#contents.child do
		message[i] = contents.child[i]
		print("name : " .. message[i].name);
		print("value : " .. message[i].value);
	end
	--]]

	--[[ XML 로드하여 페이지를 나눈다.
	local xml = require( "xml" ).newParser()
	local tree = xml:loadFile( "sample.xml" )
	local message = {}
	-- for each "child" in the contents table...
	local line = 0
	for i=1,#tree.child do
		message[i] = tree.child[i]
		print("name : " .. message[i].name);
		print("value : " .. message[i].value);
		-- if message[i].name == "text" then
		local alinenum = countTextLine(message[i].value)
		local obj = display.newText(message[i].value, 0, line*25, 304, alinenum*25 +15, null, 16);
		contents:insert(obj)
		line = line + alinenum
		-- end
	end
	--]]
	
	return Body
end
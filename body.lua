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
	local MAX_LINE_NUM = 13
	local contents = display.newGroup()
	contents.x = 9
	contents.y = display.statusBarHeight+10+80
	function countTextLine( textString )
		local num = 0
		local obj = display.newText(textString, 0, 0, null, 16);
		num = math.floor(obj.width / 302)
		obj.isVisible = false;
		obj:removeSelf()
		return num + 1
	end

	-- xml파일의 전체 라인수를 구한다.
	function countXMLLine( xmlTree )
		local line = 0
		local message = {}
		for i=1,#xmlTree.child do
			message[i] = xmlTree.child[i]
			local alinenum = countTextLine(message[i].value)
			line = line + alinenum
			-- end
		end
		return line
	end

	function countXMLPage( xmlTree )
		return math.floor( countXMLLine( xmlTree ) / MAX_LINE_NUM ) + 1
	end

	---[[ XML 로드하여 페이지를 나눈다.
	local xml = require( "xml" ).newParser()
	local tree = xml:loadFile( "document.xml" )
	local numOfLineforXml = countXMLPage(tree)
	print(numOfLineforXml)
	
	
	local message = {}
	-- for each "child" in the contents table...
	local line = 0
	for i=1,#tree.child do
		message[i] = tree.child[i]
		--[[
		print("name : " .. message[i].name);
		print("value : " .. message[i].value);
		--]]
		if message[i].name == "text" then
			local alinenum = countTextLine(message[i].value)
			-- 페이지 한도가 넘어가면 그만 그리기
			if ( line + alinenum > 13 ) then
				break
			end
			local obj = display.newText(message[i].value, 0, line*25, 304, alinenum*25, null, 16);
			contents:insert(obj)
			line = line + alinenum
		elseif message[i].name == "image" then
			local alinenum = 1
			-- 페이지 한도가 넘어가면 그만 그리기
			if ( line + alinenum > 13 ) then
				break
			end
			local path = message[i].value:gsub("^%s*(.-)%s*$", "%1")
			local obj = display.newImage( path )
			obj.width = obj.height / obj.width * 40
			obj.height = 40
			obj.x = display.contentWidth/2
			obj.y = line*25+20
			local imgmod = require("imagemodule").ImageModule( path )

			-- 터치했을때 확대, 축소
			function obj:tap( event )
				imgmod:fitToScreen()
			end
			obj:addEventListener("tap",obj)
			contents:insert(obj)
			line = line + alinenum
		else
			local alinenum = countTextLine(message[i].value)
			-- 페이지 한도가 넘어가면 그만 그리기
			if ( line + alinenum > 13 ) then
				break
			end
			local obj = display.newText(message[i].value, 0, line*25, 304, alinenum*25, null, 16);
			contents:insert(obj)
			line = line + alinenum
		end
	end
	
	
	return Body
end
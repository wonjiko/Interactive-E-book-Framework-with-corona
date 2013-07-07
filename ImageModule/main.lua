-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

print("hello")
local image = display.newImage("larrow.png");
image.x = display.contentWidth/2;
image.y = display.contentHeight/2
image.width = 100;
image.height = 100;

local scale_factor = nil
function fitToScreen(image)
	-- 가로확대인지 세로확대인지 결정해야함
	if image.width / image.height > display.contentWidth / display.contentHeight then
		-- 가로를 전체크기에 맞추게끔 확대해야 한다.
		scale_factor = display.contentWidth / image.width;
		image:scale(scale_factor,scale_factor)
	else
		-- 세로를 전체크기에 맞추게끔 확대해야 한다.
		scale_factor = display.contentHeight / image.height;
		image:scale(scale_factor,scale_factor)
	end
end

function restoreImage(image)
	image:scale(1/scale_factor,1/scale_factor)
end

fitToScreen(image)
--print(image.width)
restoreImage(image)
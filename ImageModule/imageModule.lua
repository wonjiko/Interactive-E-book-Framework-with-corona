module(..., package.seeall)

-----------------------------------------------------------------
-- 이미지를 확대 축소할 수 있는 함수를 가진 클래
-----------------------------------------------------------------

function ImageModule( aimage )
	local Module = {}
	Module.image = aimage

	local scale_factor = nil
	-- 화면에 맞게 확대해주는 함수
	function Module:fitToScreen()
		-- 가로확대인지 세로확대인지 결정해야함
		if Module.image.width / Module.image.height > display.contentWidth / display.contentHeight then
			-- 가로를 전체크기에 맞추게끔 확대해야 한다.
			scale_factor = display.contentWidth / Module.image.width;
			Module.image:scale(scale_factor,scale_factor)
		else
			-- 세로를 전체크기에 맞추게끔 확대해야 한다.
			scale_factor = display.contentHeight / Module.image.height;
			Module.image:scale(scale_factor,scale_factor)
		end
	end

	-- 다시 돌아가게끔 축소해주는 함수
	function Module:restoreImage()
		Module.image:scale(1/scale_factor,1/scale_factor)
	end

	return Module
end
module(..., package.seeall)

-----------------------------------------------------------------
-- 이미지를 확대 축소할 수 있는 함수를 가진 클래
-----------------------------------------------------------------

function ImageModule( imageString )
	local Module = {}
	Module.image = aimage

	local scale_factor = nil
	function Module:setImage( aImage )
		Module.image = aImage
	end

	-- 화면에 맞게 확대해주는 함수
	function Module:fitToScreen()
		local bodybg = nil
		local image = nil
		function close( ... )
			bodybg.isVisible = false
			image.isVisible = false
		end
		if bodybg == nil then
			bodybg = display.newRect(0, display.statusBarHeight, display.contentWidth, 480) 
			bodybg:setFillColor(140, 140, 140)
			function bodybg:tap( event )
				close()
			end
			bodybg:addEventListener("tap",bodybg)
			image = display.newImage(imageString)
			image.x = display.contentWidth/2
			image.y = display.contentHeight/2
			image.height = image.height / image.width * display.contentWidth
			image.width = display.contentWidth
			function image:tap( event )
				close()
			end
			image:addEventListener("tap",image)
		else
			bodybg.isVisible = true
			image.isVisible = true
		end	
	end

	return Module
end
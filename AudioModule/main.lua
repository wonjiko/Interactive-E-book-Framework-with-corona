function main( )
	loadAudioPlayer(70,100,"b1a4.mp3")
end

function loadAudioPlayer(xPoint, yPoint, soundPath)

	-- Sound File
	local sound = audio.loadSound(soundPath)

	-- Sprite : 스프라이트를 이용하여 재생버튼->일시정지버튼으로 이미지 체인지
	local sprite = require("sprite")
	local sheet1 = sprite.newSpriteSheet("buttonSprite.png",100,100)
	local spriteSet1 = sprite.newSpriteSet(sheet1,1,2)

	-- Timer Progress 변수 선언
	local progress = {}
	local aTimer

	-- 화면 : Sprite, StopButton 이미지 추가
	sprite.add(spriteSet1,"playImage",1,1,1000,0)
	sprite.add(spriteSet1,"pauseImage",2,1,1000,0)

	spriteButton = sprite.newSprite(spriteSet1)
	spriteButton:prepare("playImage")
		spriteButton:play()
	spriteButton.x = xPoint
	spriteButton.y = yPoint
	spriteButton:scale(1/4,1/4)

	local stopButton 
	stopButton = display.newImage("stopImage.png",55,245)
	stopButton:scale(1/4,1/4)

	-- 화면 : 초기 Progress Bar 추가
	local progressBar = display.newImage('progressBar.png', xPoint+56, yPoint)
	local curProgress = display.newRoundedRect(0, 0, 100, 10, 3)
	curProgress:setFillColor(244, 204, 106)
	curProgress:setReferencePoint(display.TopLeftReferencePoint)
	curProgress.x = xPoint+56
	curProgress.y = yPoint
	curProgress.isVisible = false

	-- 화면 : 숫자로 된 초기 Timer 추가
	local current = display.newText('00:00', xPoint+165, yPoint-7, native.systemFont, 9)
	current:setTextColor(246, 237, 240)

	local total = display.newText('/00:00', xPoint+189, yPoint-7, native.systemFont, 9)
	total:setTextColor(191, 182, 183)
	total.min = math.floor(audio.getDuration(sound) / 1000 / 60)
	total.sec = math.floor(audio.getDuration(sound) / 1000 % 60)
	total.text = '/' .. total.min .. ':' .. total.sec
	total:setReferencePoint(display.topLeftReferencePoint)
	total.x = xPoint+205

	progress.sec = 0
	progress.min = 0

	-- Function1 : Play, Pause (Sprite이용) 버튼 클릭 시
	function buttontap(event)
		--print(" progress : " .. progress.min .. ":" .. progress.sec .. " / " .. audio.getDuration(sound)/1000)
		
		-- Play : 처음재생 
		if audioPlayChannel == nil then
			audioPlayChannel = audio.play(sound)

			spriteButton:prepare("pauseImage")
			spriteButton:play()

			aTimer = timer.performWithDelay(1000, progress, 0)

		-- Pause : 일시정지(PlayButton으로 이미지 체인지)
		elseif audio.isChannelPlaying( audioPlayChannel ) then
			audio.pause(1)

			spriteButton:prepare("playImage")
			spriteButton:play()
			timer.pause(aTimer)

		-- Play : 일시정지후 재생
		else
			audio.resume(audioPlayChannel)
			audio.dispose(event.handle)
			event.handle = nil

			spriteButton:prepare("pauseImage")
			spriteButton:play()

			timer.resume(aTimer)
		end
	end

	-- Function2 : Stop 버튼 클릭 시
	function stopButton:tap(event)
		spriteButton:prepare("playImage")
		spriteButton:play()
		audio.stop()
		audioPlayChannel = nil
		timer.cancel(aTimer)

		-- ProgressBar와 Timer초기화
		progress.sec = 0
		progress.min = 0
		current:removeSelf()
		current = display.newText('00:00', xPoint+165, yPoint-7, native.systemFont, 9)
		curProgress.xScale = 0
		curProgress.isVisible = false

	end

	-- Function3 : Timer, ProgressBar 를 '현재'재생시간으로 셋팅 
	function progress:timer(e)
		progress.sec = progress.sec + 1

		if(progress.sec == 60) then
			progress.sec = 0
			progress.min = progress.min + 1
		end

		-- 초,분을 두자리 수로 표시
		local secS = tostring(progress.sec)
		local minS = tostring(progress.min)

		if(#secS < 2) then
			progress.sec = '0' .. progress.sec
		end

		if(#minS < 2) then
			progress.min = '0' .. progress.min
		end

		--	Timer : 화면에 현재시간 표시
		current.text = progress.min .. ':' .. progress.sec
		current:setReferencePoint(display.topLeftReferencePoint)
		current.x = xPoint+180

		-- Progress Bar : 화면에 현재상태바 표시
		local position = progress.min .. progress.sec
		position = position * 1000
		
		local duration = audio.getDuration(sound)
		local percent = (position / duration)
		print(position/1000 .. "초/ " .. "percent:" .. percent .. " / 총" .. duration/1000 .. "초")
		
		curProgress.isVisible = true
		curProgress.xScale = percent
	end

	-- Event
	spriteButton:addEventListener("tap",buttontap)
	stopButton:addEventListener("tap",stopButton)

end

main()
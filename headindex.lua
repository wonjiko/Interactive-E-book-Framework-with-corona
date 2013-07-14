module(..., package.seeall)

------------------------------------------------------------------------------------------
-- head 부분에서는 장(chapter)와 절(verse)를 나타낸다.
-- body에서는 이미지, 비디오, 오디오, 텍스트 정보를 보여준다. 이때 보여주는 내용은 xml에 기술되어 있다.
-- footer에서는 절(verse)과 페이지(page)간 이동을 할 수 있는 컨트롤러를 보여준다.
-- #programmer Cheechyo, LnS in JejuUniv.
------------------------------------------------------------------------------------------

function makeHeadIndex(nChapther, nVerse)
	local Head = {}

	-- 페이지에 사용될 변수/상수들을 정의하고 초기화한다.
	local _currentChapterIntex = -1;
	local _maxChapterIndex = -1;
	local _minChapterIndex = -1;
	local _currentVerseIndex = -1;
	local _maxVerseIndex = -1;
	local _minVerseIndex = -1;
	local _currentPageIndex = -1;
	local _minPageIndex = -1;
	local _maxPageIndex = -1;

	-- head 설정.
	-- TODO head에는 장(chapter)과 절(verse)을 보여주고, 현재 선택된 장(chapter)과 절(verse)이 어떤것인지 색깔로 표현한다.
	local headViewGroup = display.newGroup();

	-- chapter를 나타내는 버튼을 만든다.
	-- @param 
	--  numOfChapter : 장의 전체 갯수를 입력한다. 현재 0 ~ 5 까지 지원한다.
	function Head:makeChapterIndexChooser(numOfChapter)
		if numOfChapter < 0 or 5 < numOfChapter then
			print("function makeChapterIndexChooser : Out Of num - numOfChapter is 0 ~ 5");
			return;
		end
		_maxChapterIndex = numOfChapter -1;
		_minChapterIndex = 0;
		local chapterIndexViewGroup = display.newGroup();
		local chapterMargin = 40;
		local chapterIndexWidth = 48;
		local chapterPadding;
		if _maxChapterIndex % 2 == 0 then
			-- 장수가 홀수일때 (index는 짝수)
			chapterPadding = 0;
			if _maxChapterIndex == 0 then
		 		chapterPadding = chapterPadding + chapterIndexWidth * 2;
			elseif _maxChapterIndex == 2 then
		 		chapterPadding = chapterPadding + chapterIndexWidth;
			elseif _maxChapterIndex == 4 then
				chapterPadding = chapterPadding + 0;
			end

		else
			-- 장수가 짝수일때 (index는 홀수)
			chapterPadding = 24;
			if _maxChapterIndex == 1 then
				chapterPadding = chapterPadding + 48;
			else
				chapterPadding = chapterPadding;
			end
		end
		-- 장 인덱스를 그리는 부분
		for i = 0, _maxChapterIndex, 1 do
		local aVerseIndexView = display.newText((i+1).."장", chapterMargin + chapterPadding + i * chapterIndexWidth + 6, display.statusBarHeight+13, null, 20);
			function aVerseIndexView:tap(event)
				print("Tapped index : " .. i);
				gotoChapter(i);
			end
			aVerseIndexView:addEventListener("tap", aVerseIndexView);
				chapterIndexViewGroup:insert(aVerseIndexView);
			headViewGroup:insert(aVerseIndexView);
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
	end

	function Head:makeVerseIndexChooser(numOfVerse)
		if numOfVerse < 0 or 5 < numOfVerse then
			print("function makeChapterIndexChooser : Out Of num - numOfVerse is 0 ~ 5 ..." .. numOfVerse);
			return;
		end
		_maxVerseIndex = numOfVerse -1;
		_minVerseIndex = 0;
		local verseIndexViewGroup = display.newGroup();
		-- 전체적인 아이콘들의 x위치
		local verseMargin = 60;
		local verseIndexWidth = 40;
		local versePadding = 0;

		if _maxVerseIndex % 2 == 0 then
			-- 장수가 홀수일때 (index는 짝수)
			versePadding = versePadding + 0;
			if _maxVerseIndex == 0 then
		 		versePadding = versePadding + verseIndexWidth * 2;
			elseif _maxVerseIndex == 2 then
		 		versePadding = versePadding + verseIndexWidth;
			elseif _maxVerseIndex == 4 then
				versePadding = versePadding + 0;
			end

		else
			-- 장수가 짝수일때 (index는 홀수)
			versePadding = versePadding + 24;
			if _maxVerseIndex == 1 then
				versePadding = versePadding + 38;
			else
				versePadding = versePadding;
			end
		end
		-- 장 인덱스를 그리는 부분
		for i = 0, _maxVerseIndex, 1 do
			local aVerseIndexView = display.newText((i+1).."절", verseMargin + versePadding + i * verseIndexWidth + 6, display.statusBarHeight+53, null, 16);
			function aVerseIndexView:tap(event)
				print("Tapped index : " .. i);
				gotoChapter(i);
			end
			aVerseIndexView:addEventListener("tap", aVerseIndexView);
				verseIndexViewGroup:insert(aVerseIndexView);
			headViewGroup:insert(aVerseIndexView);
			-- 모서리가 각진 네모
			--local aRect = display.newRect(verseMargin + versePadding + i * verseIndexWidth, display.statusBarHeight+10, 42, 30)
			-- 모서리가 둥근 네모
			local aRect = display.newRoundedRect(verseMargin + versePadding + i * verseIndexWidth, display.statusBarHeight+50, verseIndexWidth - 6, 26, 5)
			aRect.strokeWidth = 3;
			aRect:setFillColor(0, 0, 0, 0);
			aRect:setStrokeColor(255, 255, 255);
			verseIndexViewGroup:insert(aRect);
			headViewGroup:insert(aRect);
		end
	end

	Head.headViewGroup = headViewGroup
	Head:makeChapterIndexChooser(nChapther)
	Head:makeVerseIndexChooser(nVerse)
	return Head
end





module(..., package.seeall)

function makeFootController(  )
	local instance
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
		
	end
	privPageBtn:addEventListener("tap", gotoPrivPage);
	-- 종료 버튼 생성
	local exitPageBtn = display.newText("종료", display.contentWidth * 3 / 6 - 22, display.contentHeight - 45, null, 24);
	footViewGroup:insert(exitPageBtn);
	function exitPageBtn:tap(event)

	end
	exitPageBtn:addEventListener("tap", exitPage);
	-- 다음 버튼 생성
	local nextPageBtn = display.newText("다음", display.contentWidth * 4 / 6 - 22, display.contentHeight - 45, null, 24);
	footViewGroup:insert(nextPageBtn);
	function nextPageBtn:tap(event)
		
	end
	nextPageBtn:addEventListener("tap", gotoNextPage);
	-- 오른쪽 화살표 설정
	local rarrow = display.newImage("res/rarrow.png");
	footViewGroup:insert(rarrow);
	rarrow.width = 30;
	rarrow.height = 30;
	rarrow.x = display.contentWidth * 5 / 6;
	rarrow.y = display.contentHeight - 25;
	return instance
end
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

</div>
	<footer>
		<nav class="navbar navbar-default navbar-static-bottom">
			<div class="outer">
				<div class="inner">
					<p>Copyright © inCORONA. All Rights Reserved.</p>
				</div>
			</div>
		</nav>
	</footer>
</body>

<script>
	function navSizeCheck(){
		//navbar 높이에 맞게 body padding 수정
		var nav_height = $('.navbar-default').height()+15;
		$('body').css("padding-top",nav_height);
		return nav_height;
	}
	
	function sizeCheck(){
		//window 사이즈에 맞게 contents 사이즈 조정
		var nav_height = navSizeCheck();
		
		var doc_height = $(document).height();
		var win_height = $(window).height();
		
		var ftnav_height = $('footer').height();
		var height = win_height;
		
		var sec_height = $('section').height();
		
		if(sec_height <  win_height){
			//윈도우 창이 컨텐츠보다 더 클때 -> 높이 확장
			height = doc_height - nav_height - ftnav_height;
			$('section').css('height', height);
			$('section').css('padding-bottom','');
		}else {
			//윈도우 창이 컨텐츠보다 더 작을 때 -> padding 더함
			$('section').css('height', '');
			$('section').css('padding-bottom',ftnav_height);
		}
	} 
	
 	sizeCheck();
	$(window).resize(sizeCheck);
</script>

</html>
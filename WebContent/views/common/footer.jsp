<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

</div><!-- #basicContainer -->
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
	
 	navSizeCheck();
	$(window).resize(navSizeCheck);
	
</script>

</html>
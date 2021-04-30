<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>

<link rel="stylesheet" href="${root}/resource/css/mypage.css">

<section class="container-fluid">
<div class="row" id="mypage">
  	<div class="col-md-3 sidebar navbar-static-top hidden-xs">
		<h2 id="sidebar-title">마이페이지</h2>
		<ul class="nav nav-pills nav-stacked">
			<li class="sidebar-item" id="post-list"><a href="${root}/mypage/mypost/list">내 글</a></li>
			<li class="sidebar-item" id="reply-list"><a href="${root}/mypage/myreply/list">내 댓글</a></li>
			<li class="sidebar-item" id="update-info"><a href="${root}/mypage/checkpw" >개인정보 수정</a></li>
		</ul>
	</div>  
	
	<div class="navbar navbar-static-top" id="mypage-sm-navbar" style="display:none">
		<ul class="nav nav-tabs nav-justified">
			<li class="mypage-navbar-item" id="post-list"><a href="${root}/mypage/mypost/list">내 글</a></li>
			<li class="mypage-navbar-item" id="reply-list"><a href="${root}/mypage/myreply/list">내 댓글</a></li>
			<li class="mypage-navbar-item" id="update-info"><a href="${root}/mypage/checkpw" >개인정보 수정</a></li>
		</ul>
	</div>
	<script>
		toggleSidebar();
	
		function toggleSidebar(){
			var currentUrl = window.location.href;
			
			var targetId = "post-list";
			
			if(currentUrl.includes("checkpw") || currentUrl.includes("update")){
				targetId = "update-info";
			}
			else if(currentUrl.includes("myreply")) {
				targetId = "reply-list";
			}
			
			document.getElementById(targetId).classList.toggle("active");
		}
	</script>
	<script>
		function toggleMypageNavbar(){
			if($(window).width()<=1000){
				$('.sidebar').css('display', 'none');
			}
			
			if($('.sidebar').is(":hidden")){
				$('#mypage-sm-navbar').css('display', '');
			}else {
				$('#mypage-sm-navbar').css('display', 'none');
			}
		}
	
		window.onload = function(){
			toggleMypageNavbar();
	    	window.addEventListener('resize',function(){
	    		toggleMypageNavbar();
	    	});
	    };
	</script>
	
	<div class="col mypage-content">
	

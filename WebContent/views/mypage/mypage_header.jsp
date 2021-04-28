<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>

<link rel="stylesheet" href="${root}/resource/css/mypage.css">

<section>
<div class="row" id="mypage">
	<div class="col-md-3 sidebar navbar-static-top">
		<h2 id="sidebar-title">마이페이지</h2>
		<ul class="nav nav-pills nav-stacked">
			<li class="sidebar-item" id="post-list"><a href="${root}/mypage/mypost/list">내 글</a></li>
			<li class="sidebar-item" id="reply-list"><a href="${root}/mypage/myreply/list">내 댓글</a></li>
			<li class="sidebar-item" id="update-info"><a href="${root}/mypage/update" >개인정보 수정</a></li>
		</ul>
	</div>
	<!-- onclick="changeMypageLink(this,'${root}/mypage/mypost/list');return false;" -->
	<script>
		toggleSidebar();
	
		function toggleSidebar(){
			var currentUrl = window.location.href;
			
			var targetId = "post-list";
			
			if(currentUrl.includes("update")){
				targetId = "update-info";
			}
			else if(currentUrl.includes("myreply")) {
				targetId = "reply-list";
			}
			
			document.getElementById(targetId).classList.toggle("active");
		}
		//alert(window.location.href);
		function changeMypageLink(aTag,link){
			//var itemID = "";
			var parentTag = aTag.parents("li");
			alert(parentTag.classList);
			//var sidebar = document.getElementById("post-list");
			parentTag.classList.toggle("active");
			document.location.href=link;
		}
		
	</script>
	
	<div class="col-md-8 mypage-content">
	

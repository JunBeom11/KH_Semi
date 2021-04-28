<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>

<link rel="stylesheet" href="${root}/resource/css/mypage.css">

<!--<section>
 <div class="row" id="mypage">
	<div class="col-md- sidebar navbar-static-top">
	  <h2 id="sidebar-title">마이페이지</h2>
	  <ul class="nav nav-pills nav-stacked">
	    <li class="sidebar-item active"><a href="#" >개인정보 수정</a></li>
	    <li class="sidebar-item"><a href="#">내 글</a></li>
	    <li class="sidebar-item"><a href="#">내 댓글</a></li>
	  </ul>
	</div>
</div> -->
<section>
<div class="row">
	<div class="col-md-3 sidebar navbar-static-top">
		<h2 id="sidebar-title">마이페이지</h2>
		<ul class="nav nav-pills nav-stacked">
			<li class="sidebar-item active"><a href="<%= request.getContextPath() %>/mypage/update" >개인정보 수정</a></li>
			<li class="sidebar-item"><a href="<%= request.getContextPath() %>/mypage/mypost/list">내 글</a></li>
			<li class="sidebar-item"><a href="<%= request.getContextPath() %>/mypage/myreply/list">내 댓글</a></li>
		</ul>
	</div>
	<div class="col-md-8">
	

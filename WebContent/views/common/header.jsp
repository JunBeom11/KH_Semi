<%@ page import="com.mvc.member.model.vo.Member" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="resource/css/bootstrap.min.css" rel="stylesheet">
    
	<title>inCORONA</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/resource/css/main.css">
	
    <script src="resource/js/jquery-3.6.0.min.js"></script>
    <script src="resource/js/bootstrap.min.js"></script>
	
</head>
<body class="container">
	<header>
		<nav class="navbar navbar-default navbar-static-top navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" href="">inCORONA</a>
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#member-collapse">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
					</button>
				</div>
				<div class="navbar-collapse collapse" id="member-collapse" >
					<div class="row">
						<ul class="nav navbar-nav navbar-right navbar-upper">
							<% if(loginMember==null){ %>
								<li><a href="member/login">로그인</a></li>
								<li><a href="member/enroll">회원가입</a></li>
							<% } else { %>
								<li><a href="member/logout">로그아웃</a></li>
								<li><a href="mypage">마이페이지</a></li>
							<% } %>
						</ul>
					</div>
					<div class="row">
						<ul class="nav navbar-nav navbar-right navbar-lower">
							<li><button type="button" class="btn btn-default btn-primary navbar-btn" onclick="location.href='board/news'">뉴스</button></li>
							<li><button type="button" class="btn btn-default btn-primary navbar-btn" onclick="location.href='hospital'">주변 병원/선별진료소</button></li>
							<li><button type="button" class="btn btn-default btn-primary navbar-btn" onclick="location.href='board/community'">정보공유게시판</button></li>
						</ul>					
					</div>
				</div>

			
			</div>
		</nav>
		<script>
			function sizeCheck(){
				//navbar 높이에 맞게 body padding 수정
				var height = $('.navbar-default').height()+15;
				$('body').css("padding-top",height);
			}
			
			sizeCheck();
			
			$(window).resize(sizeCheck);
		</script>
	</header>


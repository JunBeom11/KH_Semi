<%@ page import="com.mvc.member.model.vo.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
<<<<<<< HEAD
<<<<<<< Updated upstream
    <link href="<%= request.getContextPath() %>/resource/css/bootstrap.min.css" rel="stylesheet">
=======
    <c:set var="root" value="<%= request.getContextPath() %>" />
    
    <link href="${root}/resource/css/bootstrap.min.css" rel="stylesheet">
>>>>>>> 8a9afccf21964f30aa729fcb665c77e9fae33bd4
    
	<title>inCORONA</title>
	

	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="${root}/resource/js/jquery-3.6.0.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<<<<<<< HEAD

    <script src="<%= request.getContextPath() %>/resource/js/jquery-3.6.0.min.js"></script>

=======
    <link href="<%= request.getContextPath() %>/resource/css/bootstrap.min.css">

	<title>inCORONA</title>
	
    <script src="<%= request.getContextPath() %>/resource/js/jquery-3.6.0.min.js"></script>
>>>>>>> Stashed changes
    <script src="<%= request.getContextPath() %>/resource/js/bootstrap.min.js"></script>
=======
    <script src="${root}/resource/js/bootstrap.min.js"></script>
>>>>>>> 8a9afccf21964f30aa729fcb665c77e9fae33bd4
	
	<link rel="stylesheet" href="${root}/resource/css/main.css">
	
</head>
<body>
<%@ include file="/views/common/modal.jsp"%>
	<div class="container">
		<header>
			<nav class="navbar navbar-default navbar-static-top navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand" href="/inCorona">inCORONA</a>
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#member-collapse">
					        <span class="sr-only">Toggle navigation</span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
					        <span class="icon-bar"></span>
						</button>
					</div>
					<div class="navbar-collapse collapse" id="member-collapse" >
						<div class="row" id="collapse_row">
							<ul class="nav navbar-nav navbar-right navbar-upper">
								<% if(loginMember==null){ %>
									<li><a href="/inCorona/member/login">로그인</a></li>
									<li><a href="/inCorona/member/agreement">회원가입</a></li>
								<% } else { %>
									<li><a href="/inCorona/member/logout">로그아웃</a></li>
									<li><a href="/inCorona/mypage">마이페이지</a></li>
								<% } %>
							</ul>
						</div>
						<div class="row" id="collapse_row">
							<ul class="nav navbar-nav navbar-right navbar-lower">
								<li><button type="button" class="btn btn-default navbar-btn" onclick="location.href='/inCorona/board/news'">뉴스</button></li>
								<li><button type="button" class="btn btn-default navbar-btn" onclick="location.href='/inCorona/hospital/list'">주변 병원</button></li>
								<li><button type="button" class="btn btn-default navbar-btn" onclick="location.href='/inCorona/clinic/list'">선별진료소</button></li>
								<li><button type="button" class="btn btn-default navbar-btn" onclick="location.href='/inCorona/board/community'">정보공유게시판</button></li>
							</ul>					
						</div>
					</div>
	
				
				</div>
			</nav>
		</header>

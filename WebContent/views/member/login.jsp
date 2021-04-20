<%@page import="com.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveId = null;
	Member loginMember = (Member) session.getAttribute("loginMember");
	Cookie[] cookies = request.getCookies();
	
	// 쿠키값 받아오기
	if(cookies != null) {
		for(Cookie c : cookies) {
			if(c.getName().equals("saveId")) {
				saveId = c.getValue();
				
				break;
			}
		}
	}
%>
<%@ include file="/views/common/header.jsp" %>
<style>
	section #enroll-container {
		text-align:center;
	}
	
	section #enroll-container input {
		margin:3px;
	}
	
	section #enroll-container table {
		margin:0 auto;
	}
	
	section #enroll-container table th {
		padding:0 10px; 
		text-align:right;
	}
	
	section #enroll-container table td {
		padding:0 10px; 
		text-align:left;
	}
	h3{
		text-align:center;
	}
	
</style>

<section id="content">
	<h3>로그인</h2>
	
	<div id="enroll-container">
		<form action="<%=request.getContextPath() %>/member/login" method="POST">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="Member_Id" value="<%= saveId != null ? saveId : "" %>" placeholder="아이디" required/>
					</td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="password" name="Member_Pw" placeholder="비밀번호" required/></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<label><input type="checkbox" name="saveId" <%= saveId != null? "checked" : "" %>/>아이디 저장</label>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" id="enrollSubmit" value="로그인"/>
					</td>	
				</tr>
			</table>
			<h8>아직 회원이 아니신가요?</h8>
			<input type="button" value="회원가입" onclick="location.href='<%= request.getContextPath()%>/member/enroll';"/><br>
			<a href="">아이디 찾기</a>
			<a href="">비밀번호 재설정</a>
			
		</form>
	</div>
</section>
<%@ include file="/views/common/footer.jsp" %>
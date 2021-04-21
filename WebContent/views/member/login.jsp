<%@page import="com.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveId = null;
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
	label{
		float:right;
	}
	#enrollSubmit{
		width: 20%; 
		float:none;
		margin:0 auto;
	}
	
</style>

<section id="content">
	<h3>로그인</h3>
	
	<div id="enroll-container">
		<form action="<%=request.getContextPath() %>/member/login" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group">
						  <span class="input-group-addon" id="basic-addon1">ID</span>
						  <input type="text" class="form-control" name="Member_Id" placeholder="아이디" aria-describedby="basic-addon1" value="<%= saveId != null ? saveId : "" %>" required>
						</div>	
					</td>	
				</tr>
				<tr>
					<td>
						<div class="input-group">
						  <span class="input-group-addon" id="basic-addon1">PW</span>
						  <input type="password" class="form-control" name="Member_Pw" placeholder="비밀번호" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td>
						<label><input type="checkbox" name="saveId" <%= saveId != null? "checked" : "" %>/>아이디 저장</label>
					</td>
				</tr>
			</table>
			<br>
			<input type="submit" class="btn btn-outline-success btn-lg" id="enrollSubmit" value="로그인"/><br>
			<h8>아직 회원이 아니신가요?</h8>
			<input type="button" value="회원가입" id="btnEnroll" class="btn btn-default" onclick="location.href='<%= request.getContextPath()%>/member/agreement'"/><br>
			<a href="">아이디 찾기</a>
			<a href="">비밀번호 재설정</a>
			
		</form>
	</div>
</section>
<%@ include file="/views/common/footer.jsp" %>
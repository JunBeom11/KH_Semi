<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<%
	Member updatePwMember = (Member) session.getAttribute("findIdMember");
%>

<style>
	section #enroll-container 
		text-align:center;
	}
	section #enroll-container input {
		margin:3px;
	}
	
	section #enroll-container table {
		margin:0 auto;
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
	<h3>아이디 찾기</h3>
	<br>
	<br>
	<div id="enroll-container">
		<form name ="memberEnrollFrm" action="<%=request.getContextPath() %>/member/findId" method="POST">
			<table>
				<tr>
					<td>
						<h3 ><span class="label label-default">ID</span>&nbsp;&nbsp;<%=updatePwMember.getMember_Id() %> </h3>
					</td>
				</tr>
				<tr>
					<td><br><br><br><br></td>
				</tr>
				<tr>
					<td>
						<div class="btn-group btn-group-lg" role="group" aria-label="...">
						  <button type="button" class="btn btn-default" onclick="location.href='<%=request.getContextPath() %>/member/login'">로그인</button>
						  <button type="button" class="btn btn-default" onclick="location.href='<%=request.getContextPath() %>/member/confirmUpdatePw'">비밀번호 재설정</button>
						</div>
					</td>
				</tr>
			</table>
			<br>
			<br>
		</form>
	</div>
</section>

<script>

</script>
<%@ include file="/views/common/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mvc.member.model.vo.Member"%>
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
	#passresult{
	
		font-size:8px;
		color : red;
	}
	
	
</style>

<section id="content">
	<h3>비밀번호 수정</h3>
	
	<div id="enroll-container">
		<form name ="updatePwFrm" action="<%=request.getContextPath() %>/member/updatePw" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="password" class="form-control" name="Member_Pw" id="pass1" placeholder="비밀번호" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="password" class="form-control" id="pass2" placeholder="비밀번호 확인" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td id="passresult"></td> <!-- 비민번호 확인 메세지 -->
				</tr>
			</table>
			<br>
			<br>
			<input type="button" class="btn btn-outline-success btn-lg" id="enrollSubmit" value="비밀번호 수정하기" style="width: 30%; float:none; margin:0 auto"/>
			<br>
			<br>
		</form>
	</div>
</section>

<script>
	$(document).ready(() => {
		$("#enrollSubmit").on("click", () => {
			let pass1 = $("#pass1").val();
			let pass2 = $("#pass2").val();
			
			if(pass1.trim() != pass2.trim()){
				$("#passresult").attr('style', "display:'';");
				$("#passresult").html("  비밀번호가 일치하지 않습니다.");
				$("#pass1").val("");
				$("#pass2").val("");
				$("#pass1").focus();
			}else{
				$('#passresult').attr('style', "display:none;");
				document.updatePwFrm.submit();
			}
		});
	});
</script>
<%@ include file="/views/common/footer.jsp" %>

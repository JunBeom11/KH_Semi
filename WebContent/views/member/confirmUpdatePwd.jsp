<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/views/common/header.jsp" %>
<style>
	section #enroll-container {
		text-align:center;
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
	#confirmUpdatePw{
		width: 20%; 
		float:none;
		margin:0 auto;
	}	
	#idresult,#nicknameresult{
	
		font-size:8px;
		color : red;
	}
</style>
 <section id="content">
	<h3>본인확인</h3>
	<br>
	<br>
	<div id="enroll-container">
		<form name ="memberEnrollFrm" action="<%=request.getContextPath() %>/member/confirmUpdatePw" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group" style = "width:100%">
					 	 	<input type="text" class="form-control" name="Member_Id" id="newMemberId" placeholder="아이디" aria-describedby="basic-addon1" required>
						</div>	
					</td>
					
				</tr>
				<tr>
					<td id="idresult"></td> <!-- 아이디 확인 메세지 -->
				</tr>
				<tr height="10"></tr>
				<tr>
					<td>
						<div class="input-group" style = "width:100%">
					 	 	<input type="text" class="form-control" name="Member_NickName" id="newMemberNickName" placeholder="닉네임" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td id="nicknameresult"></td> <!-- 닉네임 확인 메세지 -->
				</tr>
				<tr height="10"></tr>
				<tr>
					<td>
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">생년월일</span>
					 	 	<input type="date" class="form-control" name="Member_Birth"  placeholder="생년월일" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				
			</table>
			<br>
			<br>
			<input type="submit" class="btn btn-outline-success btn-lg" id="confirmUpdatePw" value="본인확인"/>
			<br>
			<br>
		</form>
	</div>
</section>
<script>
	$(document).ready(() => {
		$("#confirmUpdatePw").on("click", () => {
			let id = $("#newMemberId").val().trim();
			let nickName = $("#newMemberNickName").val().trim();
			var checkKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			var checkEnglish =  /[^a-zA-Z]/;
			var checkNumber = /[^0-9]/;
			var checkBlank = /[\s]/;
			var checkNEnglish = /[a-zA-Z]/;
			
			if(id.length < 4 || id.length > 10) {
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 최소 4글자 이상, 10글자 이하로 입력하세요");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(checkKorean.test(id)){
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 한글을 포함할 수 없습니다.");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(!checkEnglish.test(id)||!checkNumber.test(id)){
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 영문과 숫자를 포함해야합니다.");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(checkBlank.test(id)){
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 공백을 포함할 수 없습니다");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}
			else{
				$('#idresult').attr('style', "display:none;");
			}
			
			if(checkBlank.test(nickName)) {
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 공백을 포함할 수 없습니다.");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else if((!checkKorean.test(nickName)) && (!checkNEnglish.test(nickName))){
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 숫자 또는 특수문자로만 구성할 수 없습니다");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else{
				$('#nicknameresult').attr('style', "display:none;");
			}
		});
	
	});
	
</script>
 
 
<%@ include file="/views/common/footer.jsp" %>
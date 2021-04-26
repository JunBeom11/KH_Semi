<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#passresult,#idresult,#nicknameresult{
	
		font-size:8px;
		color : red;
	}
	#confirmFindId{
		width: 20%; 
		float:none;
		margin:0 auto;
	}
	
	
</style>

<section id="content">
	<h3>본인 확인</h3>
	
	<div id="enroll-container">
		<form name ="memberEnrollFrm" action="<%=request.getContextPath() %>/member/confirmFindId" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="text" class="form-control" name="Member_NickName" id="newMemberNickName" placeholder="닉네임" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td id="nicknameresult"></td> <!-- 닉네임 확인 메세지 -->
				</tr>
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
			<input type="submit" class="btn btn-outline-success btn-lg" id="confirmFindId" value="본인확인"/>
			<br>
			<br>
		</form>
	</div>
</section>

<script>
$(document).ready(() => {
	$("#confirmFindId").on("click", () => {
		let nickName = $("#newMemberNickName").val().trim();
		var checkBlank = /[\s]/;
		var checkKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		var checkEnglish =  /[^a-zA-Z]/;
		
		if(checkBlank.test(nickName)) {
			$('#nicknameresult').attr('style', "display:'';");
			$("#nicknameresult").html("닉네임은 공백을 포함할 수 없습니다.");
			$("#newMemberNickName").val("");
			$("#newMemberNickName").focus();
		}else if(checkKorean.test(nickName)==false && checkEnglish.test(nickName)==true){
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
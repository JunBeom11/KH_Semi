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
	
	
</style>

<section id="content">
	<h3>회원가입</h3>
	
	<div id="enroll-container">
		<form name ="memberEnrollFrm" action="<%=request.getContextPath() %>/member/enroll" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="text" class="form-control" name="Member_Id" id="newMemberId" placeholder="아이디" aria-describedby="basic-addon1" required>
					 	 	<span class="input-group-btn">
					 	 		<input type="button" class="btn btn-default" id="checkId" disabled value="증복검사"/>
					 	 	</span>
						</div>	
					</td>
					
				</tr>
				<tr>
					<td id="idresult"></td> <!-- 아이디 확인 메세지 -->
				</tr>
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
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="text" class="form-control" name="Member_NickName" id="newMemberNickName" placeholder="닉네임" aria-describedby="basic-addon1" required>
					 	 	<span class="input-group-btn">
					 	 		<input type="button" class="btn btn-default" id="checkNickname" disabled value="증복검사"/>
					 	 	</span>
						</div>	
					</td>
				</tr>
				<tr>
					<td id="nicknameresult"></td> <!-- 닉네임 확인 메세지 -->
				</tr>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="email" class="form-control" name="Member_Email"  placeholder="이메일 abc@abc.com" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td>
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">생년월일</span>
					 	 	<input type="date" class="form-control" name="Member_Birth"  placeholder="생년월일" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<td>
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">지역</span>
						 	<select name ="Member_LocationNum" class="form-control">
								<option value="Seoul">서울</option>
								<option value="Gyeonggi">경기</option>
								<option value="Daegu">대구</option>
								<option value="Incheon">인천</option>
								<option value="Gwangju">광주</option>
								<option value="Daejeon">대전</option>
								<option value="Ulsan">울산</option>
								<option value="Busan">부산</option>
						  		<option value="Gangwon">강원</option>
				                <optgroup label="충청">
				                    <option value="South_Chungcheong">충청남도</option>
				                    <option value="North_Chungcheong">충청북도</option>   
				                </optgroup>
				                <optgroup label="전라">
				                    <option value="South_Jeolla">전라남도</option>
				                    <option value="North_Jeolla">전라북도</option>   
				                </optgroup>
				                <optgroup label="경상">
				                    <option value="South_Gyeongsang">경상남도</option>
				                    <option value="North_Gyeongsang">경상북도</option>   
				                </optgroup>           
				                <option value="Jeju">제주</option>
				                <option value="Gangwon">세종</option>
				            </select>
				        </div>
			        </td>
			       </tr>
			</table>
			<br>
			<br>
			<input type="submit" class="btn btn-outline-success btn-lg" id="enrollSubmit" value="가입하기" style="width: 30%; float:none; margin:0 auto"/>
			<br>
			<br>
		</form>
		<form name="checkIdForm">
	 		<input type="hidden" name="userId">
	 	</form>
	 	<form name="checkNicknameForm">
	 		<input type="hidden" name="userNickname">
	 	</form>
	 	<form name="checkDuplication">
	 		<input type="hidden" name="checked_id" id="checked_id" value="">
	 	</form>
	</div>
</section>

<script>
	$(document).ready(() => {
		$("#pass2").blur((event) => {
			let pass1 = $("#pass1").val();
			let pass2 = $(event.target).val();
			
			if(pass1.trim() != pass2.trim()){
				$('#passresult').attr('style', "display:'';");
				$("#passresult").html("  비밀번호가 일치하지 않습니다.");
				$("#pass1").val("");
				$(event.target).val("");
				$("#pass1").focus();
			}else{
				$('#passresult').attr('style', "display:none;");
			}
		});
			
		$("#newMemberId").blur((event) => {
			let id = $("#newMemberId").val().trim();
			var checkKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			var checkEnglish =  /[^a-zA-Z]/;
			var checkNumber = /[^0-9]/;
			var checkBlank = /[\s]/;
			
			if(id.length < 4 || id.length > 10) {
				$('#checkId').attr('disabled',true);
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 최소 4글자 이상, 10글자 이하로 입력하세요");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(checkKorean.test(id)){
				$('#checkId').attr('disabled',true);
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 한글을 포함할 수 없습니다.");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(!checkEnglish.test(id)||!checkNumber.test(id)){
				$('#checkId').attr('disabled',true);
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 영문과 숫자를 포함해야합니다.");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else if(checkBlank.test(id)){
				$('#checkId').attr('disabled',true);
				$('#idresult').attr('style', "display:'';");
				$("#idresult").html("아이디는 공백을 포함할 수 없습니다");
				$("#newMemberId").val("");
				$("#newMemberId").focus();
			}else{
				$('#idresult').attr('style', "display:none;");
				$('#checkId').attr('disabled',false);
				$("#checkId").focus();
			}
		});
		
		$("#newMemberNickName").blur((event) => {
			let nickName = $("#newMemberNickName").val().trim();
			var checkBlank = /[\s]/;
			var checkKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			var checkEnglish =  /[^a-zA-Z]/;
			
			if(checkBlank.test(nickName)) {
				$('#checkNickname').attr('disabled',true);
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 공백을 포함할 수 없습니다.");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else if(checkKorean.test(nickName)==false && checkEnglish.test(nickName)==true){
				$('#checkNickname').attr('disabled',true);
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 숫자 또는 특수문자로만 구성할 수 없습니다");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else{
				$('#nicknameresult').attr('style', "display:none;");
				$('#checkNickname').attr('disabled',false);
				$("#checkNickname").focus();
			}
		});
		
		
		$("#checkId").on("click", () => {
		
			let id = $("#newMemberId").val().trim();
			
			const url = "<%= request.getContextPath()%>/member/checkId";
			const title = "duplicate";
			const status = "left=500px,top=100px,width=500px,height=300px";
			
			open("", title, status);
			
			checkIdForm.target = title;
			checkIdForm.action = url;
			checkIdForm.method = "post";
			checkIdForm.userId.value = id;
			
			$("input[name=checked_id]").val('y1'); //중복 체크했는지 확인
			
			checkIdForm.submit();
		});
		
		$("#checkNickname").on("click", () => {
		
			let nickName = $("#newMemberNickName").val().trim();
			
			const url = "<%= request.getContextPath()%>/member/checkNickname";
			const title = "duplicate";
			const status = "left=500px,top=100px,width=500px,height=300px";
			
			open("", title, status);
			
			checkNicknameForm.target = title; 
			checkNicknameForm.action = url;
			checkNicknameForm.method = "post";
			checkNicknameForm.userNickname.value = nickName;
			
			$("input[name=checked_id]").val('y2'); //중복 체크했는지 확인
			
			checkNicknameForm.submit();
		});
		
		$("#enrollSubmit").on("click", () =>{
			
			if($("input[name='checked_id']").val()==''){
			   	alert('아이디 중복 확인을 해주세요.');
			   	$("input[name='checked_id']").eq(0).focus();
			   	return false;
			}else if($("input[name='checked_id']").val()=='y1'){
				alert('닉네임 중복 확인을 해주세요');
				$("input[name='checked_id']").eq(0).focus();
				return false;
			}
		});	
	});
</script>
<%@ include file="/views/common/footer.jsp" %>
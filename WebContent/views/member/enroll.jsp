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
	<h3>회원가입</h2>
	
	<div id="enroll-container">
		<form action="<%=request.getContextPath() %>/member/enroll" method="POST">
			<table>
				<tr>
					<td>
						<div class="input-group">
					 	 	<input type="text" class="form-control" name="Member_Id" id="newMemberId" placeholder="아이디" aria-describedby="basic-addon1" required>
					 	 	<span class="input-group-btn">
					 	 		<input type="button" class="btn btn-default" value="증복검사"/>
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
					 	 		<input type="button" class="btn btn-default" value="증복검사"/>
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
			// 중복확인전에 아이디 값이 4글자 이상인지 확인
			let id = $("#newMemberId").val().trim();
			var checkKorean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			var checkEnglish =  /[^a-zA-Z]/;
			var checkNumber = /[^0-9]/;
			
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
			}else{
				$('#idresult').attr('style', "display:none;");
			}
		});
		
		$("#newMemberNickName").blur((event) => {
			let nickName = $("#newMemberNickName").val().trim();
			var checkBlank = /[\s]/;
			
			if(checkBlank.test(nickName)) {
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 공백을 포함할 수 없습니다.");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else{
				$('#nicknameresult').attr('style', "display:none;");
			}
		});
	});
</script>
<%@ include file="/views/common/footer.jsp" %>
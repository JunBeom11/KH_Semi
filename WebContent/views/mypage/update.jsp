<%@page import="com.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/mypage/mypage_header.jsp"%>

<div id="content">
	<h2 align="center"><strong>개인정보 수정</strong></h2>
	<br><br>
	<div id="mypage-container">
		<form id="memberEnrollFrm" action="/inCorona/mypage/update" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<div class="input-group">
							<input type="text" class="form-control" name="Member_Id" id="newMemberId" value="${ loginMember.member_Id }" aria-describedby="basic-addon1" readonly required> 
						</div>
					</td>

				</tr>
		
				<tr>
					<th>변경 비밀번호</th>
					<td>
						<div class="input-group">
						<input type="password" class="form-control" id="newPassword" name="Member_Pw" placeholder="입력하세요">
					</div>
				</tr>
				<tr>
					<th>변경 비밀번호 확인</th>
					<td>
						<div class="input-group"> <input type="password" class="form-control" id="checkNewPassword" placeholder="입력하세요">
						</div>
					</td>
				</tr>
				<tr>
				    <td></td>
				    <td id="passresult"> <!-- 비민번호 확인 메세지 -->
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<div class="input-group">
							<input type="text" class="form-control" name="Member_NickName"id="newMemberNickName" value="${ loginMember.member_NickName }" aria-describedby="basic-addon1" required> 
							<span class="input-group-btn"> 
								<input type="button" class="btn btn-default" id="checkNickname" disabled value="중복검사" />
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td id="nicknameresult"></td><!-- 닉네임 확인 메세지 -->
				</tr>

				<tr>
					<th>이메일</th>
					<td><input type="email" value="${ loginMember.member_Email }" name="Member_Email" id="email" class="form-control"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="Member_Birth" maxlength="11" value="${ loginMember.member_Birth }"></td>
				</tr>

				<tr>
					<th>지역</th>
					<td>
						<div class="input-group">
							<select name="Member_LocationNum" class="form-control">
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
			<div id="updateBtns">
				<input type="submit" class="btn btn-primary" value="개인정보수정 완료" /> 
				<a href="/inCorona/member/update" class="btn btn-default" role="button" id="deleteMember">탈퇴</a>
			</div>
			
		</form>
		<form name="checkNicknameForm">
			<input type="hidden" name="userNickname" />
		</form>
	</div>
</div>
<script>
	$(document).ready(() => {
		$("#deleteMember").on("click", (e) => {
			if(confirm("정말로 탈퇴하시겠습니까?!")) {
				location.replace('<%=request.getContextPath()%>/mypage/update');
			}
		});
		$("#checkNewPassword").blur((event) => {
			let pass1 = $("#NewPassword").val();
			let pass2 = $(event.target).val();
			
			if(pass1.trim() != pass2.trim()){
				$('#passresult').attr('style', "display:'';");
				$("#passresult").html("  비밀번호가 일치하지 않습니다.");
				$("#NewPassword").val("");
				$(event.target).val("");
				$("#NewPassword").focus();
			}else{
				$('#passresult').attr('style', "display:none;");
			}
		});
		
		$("#newMemberNickName").blur((event) => {
			let nickName = $("#newMemberNickName").val().trim();
			var checkBlank = /[\s]/;
			
			if(checkBlank.test(nickName)) {
				$('#checkNickname').attr('disabled',true);
				$('#nicknameresult').attr('style', "display:'';");
				$("#nicknameresult").html("닉네임은 공백을 포함할 수 없습니다.");
				$("#newMemberNickName").val("");
				$("#newMemberNickName").focus();
			}else{
				$('#nicknameresult').attr('style', "display:none;");
				$('#checkNickname').attr('disabled',false);
			}
		});
		
		
		$("#checkNickname").on("click", () => {
		
			let nickName = $("#newMemberNickName").val().trim();
			
			const url = "<%=request.getContextPath()%>/member/checkNickname";
			const title = "duplicate";
			const status = "left=500px,top=100px,width=500px,height=300px";
			
			open("", title, status);
			
			checkNicknameForm.target = title; 
			checkNicknameForm.action = url;
			checkNicknameForm.method = "post";
			checkNicknameForm.userNickname.value = nickName;
			
			checkNicknameForm.submit();
		});
	});
</script>
<%@ include file="/views/mypage/mypage_footer.jsp"%>

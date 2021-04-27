<%@page import="com.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
    
<style>
	section #view-container {
		text-align:center;
	}
	
	section #view-container input {  
		margin:3px;
	}
	
	section #view-container table {
		margin:0 auto;
	}
	
	section #view-container table th {
		padding:0 10px; 
		text-align:right;
	}
	
	section #view-container table td {
		padding:0 10px; 
		text-align:left;
	}
	#passresult,#idresult,#nicknameresult{
	
		font-size:8px;
		color : red;
	}
</style>
<section id="content">
	<h2 align="center">개인정보 수정</h2>
	<div id="view-container">
		<form id="memberFrm" action="<%= request.getContextPath() %>/mypage/update" method="get">
			<table>
				<tr>
	                <th>아이디</th>
					<td>
						<input type="text" name="userNickname" id="newNicckname" 
							value="<%= loginMember.getMember_Id() %>" required >
						<input type="button" class="btn btn-default" id="checkId" disabled value="증복검사"/>
						<td id="idresult"></td> <!-- 아이디 확인 메세지 -->
					</td> 	
	            </tr>
	            <tr>
	                <th>닉네임</th>
					<td>
						<input type="text" name="userNickname" id="newNicckname" 
							value="<%= loginMember.getMember_NickName() %>" required >
						<input type="button" class="btn btn-default" id="checkId" disabled value="증복검사"/>
					</td> 	
	            </tr>
	             <tr>
	               <th>생년월일</th>
	                <td>
	                    <input type="date" name="Member_Birth" 
	                    	maxlength="11" value="<%= loginMember.getMember_Birth() %>">
	                </tr>
	              <tr>
	                <th>비밀번호</th>
					<td>						                 
    <div class="form-group">
    <label for="exampleInputPassword1">변경할 비밀번호</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="입력하세요">
    </div>
    <div class="form-group">
    <label for="exampleInputPassword1">변경 비밀번호 확인</label>
    <input type="password" class="form-control" id="exampleInputPassword2" placeholder="입력하세요">
    </div>
	                     <button type="submit" class="btn btn-default">완료</button>
	                     <input type="button" value="취소"onclick="self.close();">
		</td> 	
	            </tr>
	            <tr>
	                <th>이메일</th>
					<td>
						<input type="email" placeholder="abc@abc.com" name="email" id="email"
							 value="<%= loginMember.getMember_Email() %>">												
					</td> 	
	            </tr>
	            <tr>
	                <th>지역</th>
						<td>
							<div class="input-group">
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
	        <input type="submit" value="정보수정" />
	        <input type="button" id="deleteMember" value="탈퇴" />
	 	</form>
 	</div>
</section>
<script>
	$(document).ready(() => {
		$("#deleteMember").on("click", (e) => {
			if(confirm("정말로 탈퇴하시겠습니까?!")) {
				location.replace('<%= request.getContextPath() %>/mypage/delete');
			}
		});
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
			}else{
				$('#idresult').attr('style', "display:none;");
				$('#checkId').attr('disabled',false);
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
			
			checkNicknameForm.submit();
		});
	});
</script>
<%@ include file="/views/common/footer.jsp" %>
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
	#passresult{
	
		font-size:5px;
		color : red;
	}
	
	
</style>

<section id="content">
	<h3>회원가입</h2>
	
	<div id="enroll-container">
		<form action="<%=request.getContextPath() %>/member/enroll" method="POST">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="Member_Id" placeholder="4~12자의 영문 대소문자와 숫자로만 입력" required/>
						<input type="button" value="증복검사"/>
					</td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="password" name="Member_Pw" id="pass1" required/></td>
				</tr>
				<tr>
					<th>패스워드 확인</th>
					<td><input type="password" id="pass2"/></td>
				</tr>
				<tr>
					<td></td>
					<td id="passresult"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="Member_NickName" required/>
						<input type="button" value="증복검사"/>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="Member_Birth"><br></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="Member_Email" placeholder="abc@abc.com"/></td>
				</tr>
				<tr>
					<th>지역</th>
					<td> <select name ="Member_LocationNum">
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
			        </td>
				</tr>
			</table>
			<input type="submit" id="enrollSubmit" value="가입"/>
			<input type="reset" value="취소"/>
		</form>
	</div>
</section>

<script>
	$(document).ready(() => {
		$("#pass2").blur((event) => {
			let pass1 = $("#pass1").val();
			let pass2 = $(event.target).val();
			
			if(pass1.trim() != pass2.trim()){
				$("#passresult").html("비밀번호가 일치하지 않습니다.");
				
				$("#pass1").val("");
				$(event.target).val("");
				$("#pass1").focus();
			}
		});
	});
			
	$("#enrollSubmit").on("click", () =>{
		//todo 전송하기 전에 각 영역에 유효성 검사로직을 추가하는 부분!
		//유효성 검사 후 전송하도록 만들기************
		
		//return false;
	});
	
</script>
<%@ include file="/views/common/footer.jsp" %>
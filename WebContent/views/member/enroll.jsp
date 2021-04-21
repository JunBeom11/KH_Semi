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
					<td>
						<div class="input-group">
					 	 	<input type="text" class="form-control" name="Member_Id" placeholder="아이디" aria-describedby="basic-addon1" required>
						</div>	
					</td>
					<td>
						<input type="button" class="btn btn-default" value="증복검사"/>
					</td>
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
					 	 	<input type="text" class="form-control" name="Member_NickName"  placeholder="닉네임" aria-describedby="basic-addon1" required>
						</div>	
					</td>
					<td>
						<input type="button" class="btn btn-default" value="증복검사"/>
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
					 	 	<input type="email" class="form-control" name="Member_Email"  placeholder="이메일 abc@abc.com" aria-describedby="basic-addon1" required>
						</div>	
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td> <select class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3" name ="Member_LocationNum">
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
				$("#passresult").html("  비밀번호가 일치하지 않습니다.");
				
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
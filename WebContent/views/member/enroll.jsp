<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>

<section id="content">
	<h3>회원가입정보</h2>
	
	<div id="enroll-container">
		<form action="<%=request.getContextPath() %>/member/enroll" method="POST">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="userId" placeholder="아이디(4글자 이상)" required/>
						<input type="button" value="증복검사"/>
					</td>
				</tr>
					<th>패스워드</th>
					<td><input type="password" name="userPwd" id="pass1" required/></td>
				<tr>
					<th>패스워드 확인</th>
					<td><input type="password" id="pass2"/></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="userName" required/>
						<input type="button" value="증복검사"/>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="data1"><br></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" placeholder="abc@abc.com"/></td>
				</tr>
				<tr>
					<th>지역</th>
					<td><select name="sel2">
			                <option value="java" selected>서울시</option>
			                <option value="oracle">경기도</option>
			                <option value="HTML">충청도</option>
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
/*
 *	ES6에서 도입된 Arrow Function 
 	1. 기존 function보다 표현이 간단하다.
 		- () =>{...} (function(){...}) //매개 변수가 없을 때
		- x => {...} (function(x){...}) //매개 변수가 하나일 떄 
		- (x,y) => {...}  (function(x,y){...}) //매개 변수가 두개 이상일때
		- return 처리
			-(x,y) => { 
				var result = x + y;
				
				return result;
				})//처리할 라인이 여러 개라면 {}으로 감싸서 처리한다
			-(x, y) => x + y; //처리할 라인이 하나라면 {}, return문 생략 가능
			
	*가존 function과 this가 가르키는 대상이 조금 다름
 */
	$(document).ready(() => {
		$("#pass2").blur((event) => {
			let pass1 = $("#pass1").val();
			let pass2 = $(event.target).val();
			
			if(pass1.trim() != pass2.trim()){
				alert("비밀번호가 일치하지 않습니다.");
				
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
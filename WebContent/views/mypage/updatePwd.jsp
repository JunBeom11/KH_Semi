<%@page import="com.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member member = (Member) request.getAttribute("member");
%>
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
</style>
<section id="content">
	<h2 align="center">개인정보 수정</h2>
	<div id="view-container">
		<form id="memberFrm" action="<%= request.getContextPath() %>/mypage/updatePwd" method="get">
			<table>
				<tr>
	                <th>아이디</th>
					<td>
						<input type="text" name="userId" id="newId" 
							value="<%= member.getMember_Id() %>" readonly required >
					</td> 	
	            </tr>
	            <tr>
	                <th>닉네임</th>
					<td>
						<input type="text" name="userNickname" id="newNicckname" 
							value="<%= member.getMember_NickName() %>" required >
						<input type="button" value="중복 검사"/>
					</td> 	
	            </tr>
	               <th>생년월일</th>
	                <td>
	                    <input type="date" name="Member_Birth" 
	                    	maxlength="11" value="<%= member.getMember_Birth() %>">
	                </td>
	              <tr>
	                <th>비밀번호</th>
					<td>
						<input type="text" name="userpw" id="newpw" 
							value="<%= member.getMember_Pw() %>" readonly required >
	                    <input type="button" id="updatePwd" value="비밀번호변경" />
					</td> 	
	            </tr>
	            </tr>
	            <tr>
	                <th>이메일</th>
					<td>
						<input type="email" placeholder="abc@abc.com" name="email" id="email"
							 value="<%= member.getMember_Email() %>">												
					</td> 	
	            </tr>
	            <tr>
	                <th>지역</th>
						<td>
								<div class="dropdown">
  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">서울</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-2" href="#">경기</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-3" href="#">대구</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-4" href="#">인천</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-5" href="#">광주</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-6" href="#">대전</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-7" href="#">울산</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-8" href="#">부산</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-9" href="#">강원</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-10" href="#">충청남도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-11" href="#">충청북도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-12" href="#">전라남도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-13" href="#">전라북도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-14" href="#">경상남도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-15" href="#">경상북도</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-16" href="#">제주</a></li>
    <li role="presentation"><a role="menuitem" tabindex="-17" href="#">세종</a></li>
  </ul>
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
</script>
<%@ include file="/views/common/footer.jsp" %>
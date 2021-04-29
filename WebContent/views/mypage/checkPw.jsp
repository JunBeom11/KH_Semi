<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/mypage/mypage_header.jsp"%>
<div id="content">
	<h2><strong>비밀번호 재확인</strong></h2>
	<p>안전을 위해 비밀번호를 다시 한 번 입력해주세요.</p>
	
	<div id="checkPw-container">
		<form action="/inCorona/mypage/checkpw" method="POST">
			<table>
				<tr>
					<td><input type="text" class="form-control"  name="Member_Id" id="newMemberId" value="${ loginMember.member_Id }" aria-describedby="basic-addon1" readonly required></td>
				</tr>
				<tr>
					<td><input type="password" class="form-control"  id="checkPw" name="Member_Pw" placeholder="비밀번호"/></td>
				</tr>
				<tr>
					<td><input type="submit" class="btn btn-primary" id="confirmPw" value="확인" /></td>
				</tr>
			</table>
		</form>
	</div>
	
</div>
<%@ include file="/views/mypage/mypage_footer.jsp"%>s
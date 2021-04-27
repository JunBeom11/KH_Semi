<%@page import="com.mvc.board.model.vo.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
<% Post post = (Post)request.getAttribute("post"); %>
<style>
	.writer{border:none;}
</style>
<section>
	<div>
	<h1>&nbsp;정보공유 수정</h1>
<hr>
		<form method="POST" 
					enctype="multipart/form-data">
			<table id='tbl-board'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" value="<%=post.getPost_Title() %>" style = "width:723px"></td>
					<td><select name ="location">
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="충청">충청</option>
							<option value="경상">경상</option>
							<option value="전라">전라</option>
							<option value="강원">강원</option>
							</select></td>
				</tr>
				<tr>
					<td><input type="hidden" name="writer" value="<%= loginMember.getMember_Id() %>" class="writer" readonly></td>
					<td><input type="hidden" name="boardNo" value="<%=post.getPost_Num()%>" readonly>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<th>내용</th>
					<td><textarea style="resize: none;" name="content" cols="100" rows="20" ><%=post.getPost_Content() %></textarea></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="reloadFile">
					<%if(post.getPost_FileName()!=null){%>
										<img src="<%=request.getContextPath()%>/resource/images/file.png" width="20" height="20">
										<%=post.getPost_FileName() %>
					<%} %>
					</td>

				</tr>
				<tr>
					<th colspan="2">
					<div align="right">
						<input type="submit" value="등록" onClick="location.href='<%=request.getContextPath()%>/board/updatecommunity' ">
					</div>
					</th>
				</tr>
				<tr><td>&nbsp;</td></tr>
			</table>
		</form>
	</div>
</section>
<%@ include file="/views/common/footer.jsp" %>
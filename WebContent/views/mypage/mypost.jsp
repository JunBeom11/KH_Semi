<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mvc.board.model.vo.Post"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/mypage/mypage_header.jsp"%>
<%
	List<Post> list = (ArrayList) request.getAttribute("list");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

%>

<style>
	/*페이지바*/
	div#pageBar{margin-top:10px; text-align:center;}
</style>

<section id="content">
	<h2 align="center">내 게시글 </h2>
	<br><br>
	<div id="board-list-container">
		<table id="tbl-board" class = "table">
			<tr>
				<th>번호</th>
				<th>게시글 제목</th>
				<th>닉네임</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
			<% if(list.isEmpty()) {%>
			<tr>
				<td colspan="5">
					조회된 게시글이 없습니다.
				</td>
			</tr>	
		<% } else {
				for(Post post : list) {
		%>
			<tr>
				<td><%= post.getRowNum() %></td>
				<td><%= post.getPost_Title() %></td>
				<td><%= post.getPost_MemberId() %></td>
				<td><%= post.getEnrollTime() %></td>
				<td><input type="checkbox" ></td>
			</tr>
		<% 
				}
			} 
		%>
		</table>
		<div id="pageBar">
			<!-- 맨 처음으로 -->
			<button class="btn btn-primary" onclick="location.href='${root}/mypage/mypost/list?page=1'">&lt;&lt;</button>
			
			<!-- 이전 페이지로 -->
			<button  class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/mypage/mypost/list?page=<%= pageInfo.getPrvePage() %>'">&lt;</button>

			<!--  10개 페이지 목록 -->
			<% for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) { %>
				<% if(p == pageInfo.getCurrentPage()) { %>
					<button disabled><%= p %></button>
				<% } else { %>
					<button class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/mypage/mypost/list?page=<%= p %>'"><%= p %></button>
				<% } %>
			<% } %>
			
			<!-- 다음 페이지로 -->
			<button class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/mypage/mypost/list?page=<%= pageInfo.getNextPage()%>'">&gt;</button>
			
			<!-- 맨 끝으로 -->
			<button class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/mypage/mypost/list?page=<%= pageInfo.getMaxPage() %>'">&gt;&gt;</button>
		</div>
	</div>
</section>
</body>
<%@ include file="/views/mypage/mypage_footer.jsp"%>
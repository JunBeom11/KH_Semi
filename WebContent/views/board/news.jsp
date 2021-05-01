<%@page import="com.mvc.board.model.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<%@ include file="/views/common/header.jsp" %>

<%
	List<Post> list = (List<Post>) request.getAttribute("list");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
%>

<section>
	<h1>&nbsp;뉴스 </h1>
<br>
	<div id="board-list-container">
		<table class = "table">
			<tr>
				<th bgcolor="#E6E6E6">&nbsp;&nbsp;&nbsp;번호</th>
				<th bgcolor="#E6E6E6">제목</th>
				<th bgcolor="#E6E6E6">작성자</th>
				<th bgcolor="#E6E6E6">작성일</th>
				<th bgcolor="#E6E6E6">첨부파일</th>
				<th bgcolor="#E6E6E6">조회수</th>
			</tr>
	<% if(list.isEmpty()){ %>
			<tr>
				<td colspan="6">
					조회된 게시글이 없습니다.
				</td>
			</tr>	
			
	<%} else { 
				for(Post post : list) {
	%>
		<tr>
			<td><%= post.getRowNum() %></td>
			<td>
			<a href = "<%= request.getContextPath()%>/board/newsview?boardNo=<%=post.getPost_Num() %>">
			<%= post.getPost_Title() %></a>
			</td>
			<td><span style="font-weight:bold"><%=post.getPost_MemberNickname()%></span>(<%= post.getPost_MemberId() %>)</td>
			<td><%= post.getEnrollTime() %></td>
			<td>
				<% if(post.getPost_FileName() != null) { %>
					<img src="<%= request.getContextPath() %>/resource/image/file.png" width="20" height="20"/>
				<% } else { %>
					<span> - </span>
				<% } %>
			</td>
			<td><%= post.getPost_Views() %></td>
		</tr>
		<%
				}
			}
		%>
		</table>
		<%if(loginMember.getMember_role().equals("ADMIN")){%>
			<div align="right"><button type = "button" id ="btn-add" onclick="location.href='<%=request.getContextPath()%>/board/newswrite'">글쓰기</button></div>
		<%}%>
		
	</div>
		<div id="pageBar" align="center">
			<!-- 맨 처음으로 -->
			<button onclick = "location.href=' <%=request.getContextPath()%>/board/news?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 -->
			<button onclick = "location.href = ' <%= request.getContextPath()%>/board/news?page=<%=pageInfo.getPrvePage()%>''">&lt;</button>

			<!--  10개 페이지 목록 -->
			
			<% for (int p = pageInfo.getStartPage(); p<=pageInfo.getEndPage() ; p++) {%>
				<%if(p == pageInfo.getCurrentPage()) { %>
					<button disabled><%= p%></button>
				<% } else {%>
						<button onclick="location.href='<%= request.getContextPath() %>/board/news?page=<%=p%>' " ><%=p %></button>
				<% } %>
			<%} %>

			<!-- 다음 페이지로 -->
			<button onClick="location.href=' <%= request.getContextPath()%>/board/news?page=<%=pageInfo.getNextPage()%>'" >&gt;</button>

			<!-- 맨 끝으로 -->
			<button onClick = "location.href=' <%= request.getContextPath() %>/board/news?page=<%=pageInfo.getMaxPage() %>'" >&gt;&gt;</button>
		</div>
</section>
<%@ include file="/views/common/footer.jsp" %>
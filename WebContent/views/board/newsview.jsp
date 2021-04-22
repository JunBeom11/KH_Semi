<%@page import="com.mvc.board.model.vo.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>


<% Post post = (Post)request.getAttribute("post");%>
<section>
	<h1>&nbsp;&nbsp;뉴스 </h1>
	<hr>
	<div style="font-weight: bold; font-size: 16px";><%=post.getPost_Title()%><br></div>
	<%=post.getPost_MemberId() %>&nbsp;&nbsp;&nbsp;<%=post.getEnrollTime()%>&nbsp;&nbsp;&nbsp;조회수 <%=post.getPost_Views()%>
	<br><br>
	<table class="table" height="450px">
	<tr>
		<td><%=post.getPost_Content()%></td>
	</tr>
	</table>
	<hr>	
</section>
<section id="content">   
					<button type="button">수정</button>
					<button type="button">삭제</button>
					<button type="button">목록으로</button>
	    		<form action="" method="">
	    			<input type="hidden" name="boardNo" value="">
	    			<input type="hidden" name="writer" value="">
					<textarea name="content" cols="55" rows="3"></textarea>
					<button type="submit" id="btn-insert">등록</button>	    			
	    		</form>

		<div>
			<% if(post.getPost_FileName() !=null) {%>
			<a href="<%=request.getContextPath()%>/board/fileDown?filename=<%=post.getPost_FileName()%>&rename=<%=post.getPost_FileReName()%>">
			<img src="<%=request.getContextPath()%>/resources/image/file.png" width="20" height="20">
			<%=post.getPost_FileName() %>
			</a>
			<%} else { %>
				<span>-</span>
			<%} %>
		</div>
	    <table id="tbl-comment">
    	   	<tr class="level1">
	    		<td>
	    			<sub class="comment-writer">aa</sub>
	    			<sub class="comment-date">2021.05.07</sub>
	    			<br>
	    			컨텐츠
	    		</td>
	    		<td>
    				<button class="btn-delete">삭제</button>

	    		</td>
	    	</tr>
	    </table>
    </div>
</section>

<br><br><br>




<%@ include file="/views/common/footer.jsp" %>
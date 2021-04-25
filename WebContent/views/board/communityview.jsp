<%@page import="com.mvc.board.model.vo.Reply"%>
<%@page import="com.mvc.board.model.vo.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>


<% Post post = (Post)request.getAttribute("post");%>
<section>
	<h1>&nbsp;정보공유 </h1>&nbsp;&nbsp;&nbsp;
<br>
	<div style="font-weight: bold; font-size: 16px";><%=post.getPost_Title()%><br></div>
	<%=post.getPost_MemberId() %>&nbsp;&nbsp;&nbsp;<%=post.getEnrollTime()%>&nbsp;&nbsp;&nbsp;조회수 <%=post.getPost_Views()%>
	<br>
	<table class="table" height="450px">
	<tr>
		<td><%=post.getPost_Content()%></td>
	</tr>
	</table>	
</section>
<section id="content">   
	    		<form action="<%=request.getContextPath()%>/board/communityreply" method="post">
	    			<input type="hidden" name="post_num" value="<%=post.getPost_Num()%>">
	    			<input type="hidden" name="writer" value="<%=loginMember != null ? loginMember.getMember_Id() : ""%>">
					<input type="text" name="content" style = "width:723px">
					<button type="submit" id="btn-insert">등록</button>	    			
	    		</form>
 
		<div>
			<% if(post.getPost_FileName() !=null) {%>
			
			<a href="javascript:fileDownload('<%=post.getPost_FileName()%>', '<%=post.getPost_FileReName()%>')">
			                            
				<img src="<%=request.getContextPath()%>/resources/image/file.png" width="20" height="20">
				<%=post.getPost_FileName() %>
			</a>
			<script>
				function fileDownload(oriname, rename)
				{
					const url = "<%=request.getContextPath()%>/board/fileDown";
					let oName = encodeURIComponent(oriname);
					let rName = encodeURIComponent(rename);
					
					console.log(oName,rName);
					location.assign(url+"?oriname="+oName + "&rename=" + rName);
				}
				
			</script>
			<%} else { %>
				<span>-</span>
			<%} %>
		</div>
		
	    <table id="tbl-comment">
	    <% for(Reply reply : post.getReplies()) { %>
    	   	<tr class="level1">
	    		<td>
	    			<sub class="comment-writer"><%= reply.getComment_MemberId() %></sub>
	    			<sub class="comment-date"><%=reply.getComment_EnrollTime() %></sub>
	    			<br>
	    			<%=reply.getComment_Contents() %>
	    		</td>
	    	</tr>
	    <%} %>
	    </table>

</section>

<br><br><br>




<%@ include file="/views/common/footer.jsp" %>
<%@page import="com.mvc.board.model.vo.Reply"%>
<%@page import="com.mvc.board.model.vo.Post"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>


<% Post post = (Post)request.getAttribute("post");%>
<div>
	<h1>&nbsp;뉴스 </h1>&nbsp;&nbsp;&nbsp;
	<hr>
	<div style="font-weight: bold; font-size: 16px";><%=post.getPost_Title()%><br></div>
	<span style="font-weight:bold"><%=post.getPost_MemberNickname()%></span>(<%=post.getPost_MemberId() %>)&nbsp;&nbsp;&nbsp;<%=post.getEnrollTime()%>&nbsp;&nbsp;&nbsp;조회수 <%=post.getPost_Views()%>
						<% if(loginMember != null && (loginMember.getMember_Id().equals(post.getPost_MemberId())
							|| loginMember.getMember_Id().equals("admin"))) { %>
					<button type="button" onclick="location.href='<%= request.getContextPath() %>/board/updatenews?boardNo=<%= post.getPost_Num()%>'">수정</button>
					<button type="button" id="btnDelete">삭제</button>
				<% } %>
	<br>
	<hr>
	<% if(post.getPost_FileName() !=null) {%>
		<% 
		int rlen = post.getPost_FileReName().length()-4;
		String form = post.getPost_FileReName().substring(rlen);%>
		<% System.out.println(form); %>
		<%if(form.equals(".jpg")||form.equals(".png")||form.equals("jpeg")||form.equals(".JPG")||form.equals(".JPEG")||form.equals(".PNG")){ %>
			<img src="<%=request.getContextPath()%>/resource/upload/board/<%=post.getPost_FileReName() %>" width="300" height="300"><br>
		<%} %>
	<%} %>
	<table class="table" height="300px">
	<tr>
	<%=post.getPost_Content()%>
	</tr>
	</table>
</div>
<br>

<hr>

<section id="content">   
	    		<form action="<%=request.getContextPath()%>/board/reply" method="post">
	    			<input type="hidden" name="post_num" value="<%=post.getPost_Num()%>">
	    			<input type="hidden" name="writer" value="<%=loginMember != null ? loginMember.getMember_Id() : ""%>">
					<input type="text" name="content" style = "width:723px">
					
					<input type="hidden" name="nickname" value="<%=loginMember != null? loginMember.getMember_NickName():"" %>">
					
					<button type="submit" id="btn-insert">등록</button>	    			
	    		</form>
		<div>
			<% if(post.getPost_FileName() !=null) {%>
			<a href="javascript:fileDownload('<%=post.getPost_FileName()%>', '<%=post.getPost_FileReName()%>')">
			                            
				<img src="<%=request.getContextPath()%>/resource/image/file.png" width="20" height="20">
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
	    			<sub class="comment-writer"><span style="font-weight:bold"><%=reply.getComment_MemberNickname() %></span>(<%= reply.getComment_MemberId() %>)</sub>
	    			<sub class="comment-date"><%=reply.getComment_EnrollTime() %></sub>
	    			<br>
	    			<%=reply.getComment_Contents() %>
	    		</td>
	    	</tr>
	    <%} %>
	    </table>

</section>

<br><br><br>
<script>
	$(document).ready(()=>{
		$("#btnDelete").on("click",(e) =>{
			if(confirm("정말로 게시글을 삭제 하시겠습니까?"))
				{
					location.replace("<%=request.getContextPath()%>/board/erase?boardNo=<%=post.getPost_Num()%>&bNum=<%=post.getBoard_Num()%>")
				}
		});
	});
</script>



<%@ include file="/views/common/footer.jsp" %>
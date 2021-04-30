<%@page import="com.mvc.board.model.vo.Reply"%>
<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mvc.board.model.vo.Post"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/mypage/mypage_header.jsp"%>
<%
	List<Reply> list = (ArrayList) request.getAttribute("list");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

%>

<div id="content">
	<h2 align="center"><strong>내 댓글</strong></h2>
	<br><br>
	<div id="board-list-container">
		<form action="/inCorona/mypage/myreply/delete" method="POST">
		<div id="deleteList">
			<button type="button" class="btn btn-default btn-sm"  onclick="checkAllReply();">전부 선택</button>
			<input type="submit" class="btn btn-default btn-sm" id="ListSubmit" value="선택한 댓글 삭제하기" />
		</div>
		<br><br><br>
		<div class="table-responsive">
		<table id="tbl-board" class = "table tlable-striped">
			<tr>
				<th>번호</th>
				<th>게시글 제목</th>
				<th>댓글내용</th>
				<th>닉네임</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
			
			<c:choose>
				<c:when test="${list eq null || list.isEmpty()}">
					<tr>
						<td colspan="6">조회된 댓글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="reply" items="${list}">
					<tr>
						<td>${ reply.rowNum }</td>
						<td>${ reply.post_Title }</td>
						<td>${ reply.comment_Contents }</td>
						<td>${ reply.comment_MemberNickname }</td>
						<td>${ reply.comment_EnrollTime }</td>
						<td><input type="checkbox" name="checkReply" value="${reply.comment_Num}"></td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
		</form>
		
		<nav>
			<ul class="pagination" id="pageBar">
				<li><a href="${root}/mypage/myreply/list?page=1">&laquo;</a></li>
				<li><a href="${root}/mypage/myreply/list?page=${pageInfo.getPrvePage()}">&lt;</a></li>
				<c:forEach var="p" begin="${pageInfo.getStartPage()}" end="${pageInfo.getEndPage()}">
					<c:choose>
						<c:when test="${p eq pageInfo.getCurrentPage()}">
							<li class="active"><a href="">${p}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${root}/mypage/mypost/list?page=${p}">${p}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<li><a href="${root}/mypage/mmyreply/list?page=${pageInfo.getNextPage()}">&gt;</a></li>
				<li><a href="${root}/mypage/myreply/list?page=${pageInfo.getMaxPage()}">&raquo;</a></li>
			
			</ul>
		</nav>
	</div>
</div>

<script>
	function checkAllReply(){
		var isChecked = $('input[name=checkReply]:checked').length == $('input[name=checkReply]').length;
		$("input[name=checkReply]:checkbox").prop("checked", !isChecked);
	}
</script>
<%@ include file="/views/mypage/mypage_footer.jsp"%>
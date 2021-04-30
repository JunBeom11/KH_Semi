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

<div id="content">
	<h2 align="center"><strong>내 게시글</strong></h2>
	<br><br>
	<div id="board-list-container">
		<form action="/inCorona/mypage/mypost/delete" method="POST">
		<div id="deleteList">
			<button type="button" class="btn btn-default btn-sm"  onclick="checkAllPost();">전부 선택</button>
			<input type="submit" class="btn btn-default btn-sm" id="ListSubmit" value="선택한 글 삭제하기" />
		</div>
		<br><br><br>
		<div class="table-responsive">
		<table id="tbl-board" class ="table table-striped">
			<tr>
				<th>번호</th>
				<th>게시글 제목</th>
				<th>닉네임</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
			<c:choose>
				<c:when test="${list eq null || list.isEmpty()}">
					<tr>
						<td colspan="5">조회된 게시글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="post" items="${list}">
					<tr>
						<td>${ post.rowNum }</td>
						<td><a href="${root}/board/newsview?boardNo=${post.post_Num}">${ post.post_Title }</a></td>
						<td>${ post.post_MemberNickname }</td>
						<td>${ post.getEnrollTime() }</td>
						<td><input type="checkbox" name="checkPost" value="${post.post_Num}"></td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
		</form>
		<nav>
			<ul class="pagination" id="pageBar">
				<li><a href="${root}/mypage/mypost/list?page=1">&laquo;</a></li>
				<li><a href="${root}/mypage/mypost/list?page=${pageInfo.getPrvePage()}">&lt;</a></li>
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
				<li><a href="${root}/mypage/mypost/list?page=${pageInfo.getNextPage()}">&gt;</a></li>
				<li><a href="${root}/mypage/mypost/list?page=${pageInfo.getMaxPage()}">&raquo;</a></li>
			
			</ul>
		</nav>
		
	</div>
</div>

<script>
	function checkAllPost(){
		var isChecked = $('input[name=checkPost]:checked').length == $('input[name=checkPost]').length;
		$("input[name=checkPost]:checkbox").prop("checked", !isChecked);
	}
</script>

<%@ include file="/views/mypage/mypage_footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>

<style>
	.writer{border:none;}
</style>
<section>
	<div>
	<h1>&nbsp;&nbsp;뉴스 작성</h1>
	<hr>
		<form action="<%=request.getContextPath()%>/board/newswrite" method="POST" 
					enctype="multipart/form-data">
			<table id='tbl-board'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" style = "width:723px"></td>
				</tr>
				<tr>
					<td><input type="hidden" name="writer" value="최은교" class="writer" readonly></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<th>내용</th>
					<td><textarea style="resize: none;" name="content" cols="100" rows="20" ></textarea></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="upfile"></td>
				</tr>
				<tr>
					<th colspan="2">
					<div align="right">
						<input type="submit" value="등록">
						<input type="reset" value="취소">
					</div>
					</th>
				</tr>
				<tr><td>&nbsp;</td></tr>
			</table>
		</form>
	</div>
</section>
<%@ include file="/views/common/footer.jsp" %>
<%@page import="com.mvc.hospital.model.vo.Hospital"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>

<%
List<Hospital> list = (ArrayList) request.getAttribute("list");
PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
%>
<Style>
.button {
	border: none;
	color: white;
	padding: 8px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 10px;
	margin: 2px 1px;
	cursor: pointer;
	border-radius: 5px;
}

.button2 {
	background-color: #337ab7;
	border-radius: 5px;
} /* Blue */
.pageBar {
	text-align: center;
}

.bordered {
	*border-collapse: collapse; /* IE7 and lower */
	border-spacing: 0;
	width: 100%;
	border: solid #ccc 1px;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	-webkit-box-shadow: 0 1px 1px #ccc;
	-moz-box-shadow: 0 1px 1px #ccc;
	box-shadow: 0 1px 1px #ccc;
}

.bordered tr:hover {
	background: #fbf8e9;
	-o-transition: all 0.1s ease-in-out;
	-webkit-transition: all 0.1s ease-in-out;
	-moz-transition: all 0.1s ease-in-out;
	-ms-transition: all 0.1s ease-in-out;
	transition: all 0.1s ease-in-out;
}

.bordered td, .bordered th {
	border-left: 1px solid #ccc;
	border-top: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

.bordered th {
	background-color: #dce9f9;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc),
		to(#dce9f9));
	background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
	background-image: -moz-linear-gradient(top, #ebf3fc, #dce9f9);
	background-image: -ms-linear-gradient(top, #ebf3fc, #dce9f9);
	background-image: -o-linear-gradient(top, #ebf3fc, #dce9f9);
	background-image: linear-gradient(top, #ebf3fc, #dce9f9);
	-webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, .8) inset;
	-moz-box-shadow: 0 1px 0 rgba(255, 255, 255, .8) inset;
	box-shadow: 0 1px 0 rgba(255, 255, 255, .8) inset;
	border-top: none;
	text-shadow: 0 1px 0 rgba(255, 255, 255, .5);
}

.bordered td:first-child, .bordered th:first-child {
	border-left: none;
}

.bordered th:first-child {
	-moz-border-radius: 6px 0 0 0;
	-webkit-border-radius: 6px 0 0 0;
	border-radius: 6px 0 0 0;
}

.bordered th:last-child {
	-moz-border-radius: 0 6px 0 0;
	-webkit-border-radius: 0 6px 0 0;
	border-radius: 0 6px 0 0;
}

.bordered th:only-child {
	-moz-border-radius: 6px 6px 0 0;
	-webkit-border-radius: 6px 6px 0 0;
	border-radius: 6px 6px 0 0;
}

.bordered tr:last-child td:first-child {
	-moz-border-radius: 0 0 0 6px;
	-webkit-border-radius: 0 0 0 6px;
	border-radius: 0 0 0 6px;
}

.bordered tr:last-child td:last-child {
	-moz-border-radius: 0 0 6px 0;
	-webkit-border-radius: 0 0 6px 0;
	border-radius: 0 0 6px 0;
}
</Style>

<h2>병원 리스트</h2>

<table class="bordered">
	<tr>
		<th>번호</th>
		<th>병원명</th>
		<th>병원주소</th>
		<th>연락처</th>
		<!-- <th>지역번호</th>-->
	</tr>
	<%
	if (list.isEmpty()) {
	%>
	<tr>
		<td colspan="4">조회된 리스트가 없습니다.</td>
	</tr>
	<%
	} else {
	for (Hospital hospital : list) {
	%>
	<tr>
		<td><%=hospital.getRowNum()%></td>
		<td><%=hospital.getHospital_Name()%></td>
		<td><%=hospital.getHospital_Address()%></td>
		<td><%=hospital.getHospital_Tel()%></td>
		<%--<td><%=hospital.getLocation_Hnum()%></td>--%>
	</tr>
	<%
	}
	}
	%>

</table>
<div class="pageBar">
	<!-- 맨 처음으로 -->
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList?page=1'">&lt;&lt;</button>

	<!-- 이전 페이지로 -->
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList?page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

	<!--  10개 페이지 목록 -->
	<%
	for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
	%>
	<%
	if (p == pageInfo.getCurrentPage()) {
	%>
	<button class="button button2" disabled><%=p%></button>
	<%
	} else {
	%>
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList?page=<%=p%>'"><%=p%></button>
	<%
	}
	%>
	<%
	}
	%>

	<!-- 다음 페이지로 -->
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList?page=<%=pageInfo.getNextPage()%>'">&gt;</button>

	<!-- 맨 끝으로 -->
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList?page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
</div>



<%@ include file="/views/common/footer.jsp"%>
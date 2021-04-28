<%@page import="com.mvc.hospital.model.vo.Hospital"%>
<%@page import="com.mvc.member.model.vo.Location"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/views/common/header.jsp"%>

<%
List<Hospital> list = (ArrayList) request.getAttribute("list");
PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
Hospital hospital= (Hospital) request.getAttribute("hospital");

Object locationNum = request.getAttribute("locationNum");
String location = (String)locationNum;
%>

<style>
.button {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 16px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	transition-duration: 0.4s;
	cursor: pointer;
}

.button1 {
	background-color: white;
	color: black;
	border: 2px solid #4CAF50;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}

.button2 {
	background-color: white;
	color: black;
	border: 2px solid #008CBA;
}

.button2:hover {
	background-color: #008CBA;
	color: white;
}

table {
	width: 55%;
	height: 350px;
}

div #map {
	border: 1px solid;
}
</style>


<div class=hospital-header style="height: 200px">
	    <form  action="<%=request.getContextPath()%>/hospital/list" method="get">
		<h2 align="center" class="locationNow">
			현재 지역 : <select name="locationName" onchange="this.form.submit();">
				<option value="" >지역</option>
				<option value="서울" name="locationName">서울</option>
				<option value="경기" name="locationName">경기</option>
				<option value="대구" name="locationName">대구</option>
				<option value="인천" name="locationName">인천</option>
				<option value="광주" name="locationName">광주</option>
				<option value="대전" name="locationName">대전</option>
				<option value="울산" name="locationName">울산</option>
				<option value="부산" name="locationName">부산</option>
				<option value="강원" name="locationName">강원</option>
				<option value="충남" name="locationName">충남</option>
				<option value="충북" name="locationName">충북</option>
				<option value="전남" name="locationName">전남</option>
				<option value="전북" name="locationName">전북</option>
				<option value="경남" name="locationName">경남</option>
				<option value="경북" name="locationName">경북</option>
				<option value="제주" name="locationName">제주</option>
				<option value="세종" name="locationName">세종</option>
			</select>
		</h2>
	</form>
	
	<br>

	<button class="button button1"
		onclick="location.href='<%=request.getContextPath()%>/hospital/hList'">병원</button>
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/hospital/cList'">선별진료소</button>

</div>
<br>

<div class="row">
	<div class="col-md-5">
		<div id="map" style="width: 100%; height: 400px;"></div>
	</div>
	<div class="col-md-7">
		<div class="row-md-7">
			<table class="list" id="list" style="width: 120%">
				<%
				if (list.isEmpty()) {
				%>
				<tr>
					<td colspan="4">조회된 게시글이 없습니다.</td>
				</tr>
				<%
				} else {
				for (Hospital hospitalL : list) {
				%>
				<tr>
					<td><%=hospitalL.getHospital_Name()%></td>
					<td><%=hospitalL.getHospital_Address()%></td>
					<td><%=hospitalL.getHospital_Tel()%></td>
					<!-- <td><%--<%= hospital.getLocation_Hnum() %></td>--%>-->
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>
		
		<%if(locationNum.equals("0")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("1")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=서울&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=서울&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=서울&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=서울&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=서울&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("2")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=경기&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=경기&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=경기&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=경기&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?locationName=경기&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("3")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대구&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대구&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대구&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대구&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("4")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=인천&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=인천&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=인천&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=인천&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("5")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=광주&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=광주&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=광주&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=광주&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("6")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대전&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대전&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대전&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=대전&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("7")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=울산&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=울산&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=울산&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=울산&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("8")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=부산&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=부산&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=부산&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=부산&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("9")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=강원&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=강원&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=강원&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=강원&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("10")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("11")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=충북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("12")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("13")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=전북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("14")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("15")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=경북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("16")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=제주&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=제주&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=제주&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=제주&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
		<%if(locationNum.equals("17")) { %>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=세종&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=세종&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=세종&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/hospital/list?location=세종&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<% } %>
		
	</div>
</div>



<br><br><br><br><br>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e6cee91ad1dd832e967a065cefaede4">
	
</script>



<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.499007, 127.032887), // 지도의 중심좌표
		// draggable: false, // 지도를 생성할때 지도 이동 및 확대/축소를 막으려면 draggable: false 옵션을 추가하세요
		level : 3
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 마커가 표시될 위치입니다 
	var markerPosition = new kakao.maps.LatLng(37.499007, 127.032887);

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		position : markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);

	// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
	// marker.setMap(null);  

	function resizeMap() {
		var mapContainer = document.getElementById('map');
		mapContainer.style.width = '30%';
		mapContainer.style.height = '350px';
	}

	function relayout() {

		// 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		// 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		// window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		map.relayout();
	}
</script>

<%@ include file="/views/common/footer.jsp"%>



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
Hospital hospital = (Hospital) request.getAttribute("hospital");

Object locationNum = request.getAttribute("locationNum");
String location = (String) locationNum;
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

div #pageBar{
	text-align: center;
}

.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:5px 10px 10px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}


</style>


<div class=hospital-header style="height: 200px">
	<form action="<%=request.getContextPath()%>/clinic/list" method="get">
		<h2 align="center" class="locationNow">
			현재 지역 : <select id="locationName" name="locationName"
				onchange="this.form.submit();">
				<option value="">지역</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="대구">대구</option>
				<option value="인천">인천</option>
				<option value="광주">광주</option>
				<option value="대전">대전</option>
				<option value="울산">울산</option>
				<option value="부산">부산</option>
				<option value="강원">강원</option>
				<option value="충남">충남</option>
				<option value="충북">충북</option>
				<option value="전남">전남</option>
				<option value="전북">전북</option>
				<option value="경남">경남</option>
				<option value="경북">경북</option>
				<option value="제주">제주</option>
				<option value="세종">세종</option>
			</select>
		</h2>
	</form>

	<br>

	<button class="button button1"
		onclick="location.href='<%=request.getContextPath()%>/hospital/list'">병원</button>
	<button class="button button2"
		onclick="location.href='<%=request.getContextPath()%>/clinic/list'">선별진료소</button>

</div>



<div class="row">
	<div class="col-md-12">
		<div class="row-md-7 container">
			<table class="list table table-hover" id="list" style="width: 100%">
			<thead class="thead-light">
				<tr>
					<th>진료소명</th>
					<th>주소</th>
					<th>전화번호</th>
				</tr>
			</thead>
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

					<td><%=hospitalL.getClinic_Name()%></td>
					<td><%=hospitalL.getClinic_Address()%></td>
					<td><%=hospitalL.getClinic_Tel()%></td>
				</tr>
				<%
				}
				}
				%>
			</table>
		</div>

		<%
		if (locationNum.equals("0")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("1")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=서울&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=서울&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=서울&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=서울&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=서울&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("2")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경기&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경기&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경기&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경기&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경기&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("3")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대구&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대구&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대구&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?location=대구&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?location=대구&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("4")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=인천&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=인천&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=인천&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=인천&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=인천&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("5")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=광주&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=광주&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?LocationName=광주&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=광주&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=광주&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("6")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대전&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대전&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대전&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대전&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=대전&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("7")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=울산&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=울산&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=울산&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=울산&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=울산&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("8")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=부산&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=부산&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=부산&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=부산&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=부산&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("9")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=강원&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=강원&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=강원&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=강원&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=강원&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("10")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충남&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("11")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충북&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=충북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("12")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전남&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("13")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전북&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=전북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("14")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경남&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경남&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경남&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경남&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경남&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("15")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경북&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경북&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경북&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경북&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=경북&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("16")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=제주&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=제주&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=제주&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=제주&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=제주&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (locationNum.equals("17")) {
		%>
		<div class="row-md-5">
			<div id="pageBar">
				<!-- 맨 처음으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=세종&page=1'">&lt;&lt;</button>

				<!-- 이전 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=세종&page=<%=pageInfo.getPrvePage()%>'">&lt;</button>

				<!--  10개 페이지 목록 -->
				<%
				for (int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++) {
				%>
				<%
				if (p == pageInfo.getCurrentPage()) {
				%>
				<button disabled><%=p%></button>
				<%
				} else {
				%>
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=세종&page=<%=p%>'"><%=p%></button>
				<%
				}
				%>
				<%
				}
				%>

				<!-- 다음 페이지로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=세종&page=<%=pageInfo.getNextPage()%>'">&gt;</button>

				<!-- 맨 끝으로 -->
				<button
					onclick="location.href='<%=request.getContextPath()%>/clinic/list?locationName=세종&page=<%=pageInfo.getMaxPage()%>'">&gt;&gt;</button>
			</div>
		</div>
		<%
		}
		%>

	</div>
</div>

<br>
<br>
<br>
<div class="map_wrap">
			  <div id="map"
				style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			
			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
						<form onsubmit="searchPlaces(); return false;">
							키워드 : <input type="text" value="강남구보건소" id="keyword" size="15">
							<button type="submit">검색하기</button>
						</form>
					</div>
				</div>
				<hr>
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>



<br>
<br>
<br>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e6cee91ad1dd832e967a065cefaede4&libraries=services">
	
</script>

<script>
	// 마커를 담을 배열입니다
	var markers = [];

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		zIndex : 1
	});

	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

		var keyword = document.getElementById('keyword').value;

		if (!keyword.replace(/^\s+|\s+$/g, '')) {
			alert('키워드를 입력해주세요!');
			return false;
		}

		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		ps.keywordSearch(keyword, placesSearchCB);
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			displayPlaces(data);

			// 페이지 번호를 표출합니다
			displayPagination(pagination);

		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			alert('검색 결과가 존재하지 않습니다.');
			return;

		} else if (status === kakao.maps.services.Status.ERROR) {

			alert('검색 결과 중 오류가 발생했습니다.');
			return;

		}
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

		var listEl = document.getElementById('placesList'), menuEl = document
				.getElementById('menu_wrap'), fragment = document
				.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);

		// 지도에 표시되고 있는 마커를 제거합니다
		removeMarker();

		for (var i = 0; i < places.length; i++) {

			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(
					placePosition, i), itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);

			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function(marker, title) {
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					displayInfowindow(marker, title);
				});

				kakao.maps.event.addListener(marker, 'mouseout', function() {
					infowindow.close();
				});

				itemEl.onmouseover = function() {
					displayInfowindow(marker, title);
				};

				itemEl.onmouseout = function() {
					infowindow.close();
				};
			})(marker, places[i].place_name);

			fragment.appendChild(itemEl);
		}

		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

		var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
				+ (index + 1)
				+ '"></span>'
				+ '<div class="info">'
				+ '   <h5>'
				+ places.place_name + '</h5>';

		if (places.road_address_name) {
			itemStr += '    <span>' + places.road_address_name + '</span>'
					+ '   <span class="jibun gray">' + places.address_name
					+ '</span>';
		} else {
			itemStr += '    <span>' + places.address_name + '</span>';
		}

		itemStr += '  <span class="tel">' + places.phone + '</span>' + '</div>';

		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
		imgOptions = {
			spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset : new kakao.maps.Point(13, 37)
		// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position, // 마커의 위치
			image : markerImage
		});

		marker.setMap(map); // 지도 위에 마커를 표출합니다
		markers.push(marker); // 배열에 생성된 마커를 추가합니다

		return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'), fragment = document
				.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제합니다
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
	
	map.relayout();
</script>


<%@ include file="/views/common/footer.jsp"%>



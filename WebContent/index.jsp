<%@page import="com.mvc.status.model.vo.Status"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/views/common/header.jsp"%>

<section>
	<%
		int resultCode = (int)request.getAttribute("resultCode");			/* 결과코드 */
		String resultMsg = (String)request.getAttribute("resultMsg");		/* 결과메세지 */
		
		Status todayStatus = (Status)request.getAttribute("todayStatus");	/* 오늘 Status 객체 */
		
		int[] decideArr = (int[])request.getAttribute("decideArr");			/* 일일 확진자수 배열 */
		int[] compareArr = (int[])request.getAttribute("compareArr");		/* 전날 비교 배열
																			 - 확진자, 완치자, 격리자, 사망자, 검사수 */
	%>

	<%
		if(resultCode != 0){
	%>
			<script>
				$('#modal').on('shown.bs.modal', function () {
					  $('#modal-title').text('ERROR');
					  $('#modal-body').html('<p><%= resultCode %> : <%= resultMsg %></p><p>정상적으로 코로나 현황 정보를 불러오지 못했습니다.</p>');
					});
				$('#modal').modal('show');
			</script>		
	<%	}
	%>
	
	<div class="row" id="statusContent">
		<div class="col-md-7">
			<div class="row-md-5" id="statusTable">	
				<p id="statusInfo">
				<%
					if(todayStatus != null){
				%>
				<%= todayStatus.getStateDt() %> <%= todayStatus.getStateTime() %> 기준 ('20.01.03. 이후 누계)
				<%
					} else {
				%>
				정상적으로 코로나 현황 정보를 불러오지 못했습니다.
				<%
					}
				%>
				</p>
				<table class="table table-striped table-hover">
					<tr>
						<th id="decideCnt">확진자</th>
						<th id="clearCnt">완치자</th>
						<th id="careCnt">격리자</th>
						<th id="deathCnt">사망자</th>
						<th id="accExamCnt">검사수</th>
					</tr>
					<%
						if(todayStatus != null){
					%>
					<tr>
						<td id="decideCnt"><fmt:formatNumber value="${todayStatus.decideCnt}" pattern="#,###"/><br><p id="compareCnt" >(+ <fmt:formatNumber value="${compareArr[0]}" pattern="#,###"/>)</p></td>
						<td id="clearCnt"><fmt:formatNumber value="${todayStatus.clearCnt}" pattern="#,###"/><br><p id="compareCnt">(+ <fmt:formatNumber value="${compareArr[1]}" pattern="#,###"/>)</p></td>
						<td id="careCnt"><fmt:formatNumber value="${todayStatus.careCnt}" pattern="#,###"/><br><p id="compareCnt">(+ <fmt:formatNumber value="${compareArr[2]}" pattern="#,###"/>)</p></td>
						<td id="deathCnt"><fmt:formatNumber value="${todayStatus.deathCnt}" pattern="#,###"/><br><p id="compareCnt">(+ <fmt:formatNumber value="${compareArr[3]}" pattern="#,###"/>)</p></td>
						<td id="accExamCnt"><fmt:formatNumber value="${todayStatus.accExamCnt}" pattern="#,###"/><br><p id="compareCnt">(+ <fmt:formatNumber value="${compareArr[4]}" pattern="#,###"/>)</p></td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td id="decideCnt">0</td>
						<td id="clearCnt">0</td>
						<td id="careCnt">0</td>
						<td id="deathCnt">0</td>
						<td id="accExamCnt">0</td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
				
			<div class="row-md-6" id="statusChart">
				차트자리
				<%= decideArr[0] %>
				<%= decideArr[1] %>
				<%= decideArr[2] %>
				<%= decideArr[3] %>
				<%= decideArr[4] %>
				<%= decideArr[5] %>
				<%= decideArr[6] %>
			</div>
		</div>
		<div class="col-md-5" id="statusMap">
		지도자리
		</div>
	</div>
	
	<script>
		function test(){
			return "hello";
		}
	</script>
	
</section>

<%@ include file="/views/common/footer.jsp"%>
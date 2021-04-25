<%@ page import="com.mvc.status.model.vo.Status" %>
<%@ page import="com.mvc.status.model.vo.Status.decideStatus" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/views/common/header.jsp"%>

<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

<section>
	<%
		int resultCode = (int)request.getAttribute("resultCode");			/* 결과코드 */
		String resultMsg = (String)request.getAttribute("resultMsg");		/* 결과메세지 */
		
		Status todayStatus = (Status)request.getAttribute("todayStatus");	/* 오늘 Status 객체 */
		
		List<decideStatus> decideList = (ArrayList)request.getAttribute("decideList");			/* 일일 확진자수 배열 */
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
				<fmt:formatDate pattern="yy.MM.dd" value="${todayStatus.decide.stateDt}" /> <%= todayStatus.getStateTime() %> 기준 ('20.01.03. 이후 누계)
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
				<p style="text-align:center;font-weight:bold;">확진자 수 일별 현황</p>
				<div id="statusChartArea"></div>
			</div>
		</div>
		<div class="col-md-5" id="statusMap">
		</div>
	</div>
	
	<script>
  		var cate = [
  			<c:forEach items="${decideList}" var="decide">
				'<fmt:formatDate pattern="yy.MM.dd" value="${decide.stateDt}"/>',
			</c:forEach>
  		].reverse();
		
  		var decideData = [
  			<c:forEach items="${decideList}" var="decide">
  				${decide.decideCnt},
			</c:forEach>
  		].reverse();
  		
		const el = document.getElementById('statusChartArea');
	    const data = {
	      categories: cate,
	      series: {
	    	  column: [
	    		  {
	    	          name: '확진자 수',
	    	          data: decideData
	    	        }
	    	  ],
	    	  line:[
	    		  {
	    			  name:'확진자 수',
	    	          data: decideData
	    	        }
	    	  ]
	      },
	    };
	    const options = {
	      chart: { /* title: {
	    	  			text:'확진자 수',
	    	  			align: 'center'
	      			},  */
	      		width: 600, height: 350 },
	      legend: {
	    	  visible:false
	      },
	      exportMenu : {
	    	  visible:false
	      },
	      tooltip:{
	    	  visible:false
	      }
	    };
	
	    const chart = toastui.Chart.columnLineChart({ el, data, options });
	</script>
	
</section>
	<script>
		function resizeChart(){
			var chart_w = $('#statusChart').width();
			var chart_h = $('#statusChart').height()-20;
			chart.resize({
		        width: chart_w,
		        height: chart_h
			});
		}
		
		resizeChart();
		
		document.body.onresize = function() {
		    resizeChart();
		};
	</script>
<%@ include file="/views/common/footer.jsp"%>
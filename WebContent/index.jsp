<%@ page import="com.mvc.status.model.vo.Status" %>
<%@ page import="com.mvc.status.model.vo.Status.decideStatus" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/views/common/header.jsp"%>

<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

<section id="indexSection" class="container">
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
		<div class="col-md-6" id="statusTableChart">
			<!-- 코로나 현황 정보 테이블 -->
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
			<!-- 코로나 확진자 수 일별 현황 차트 -->
			<div class="row-md-6" id="statusChart">
				<p style="text-align:center;font-weight:bold;">확진자 수 일별 현황</p>
				<div id="statusChartArea"></div>
			</div>
		</div>
		<!-- 코로나 거리두기 단계 지도 -->
		<div class="col-md-5" id="statusMap">
			<p style="text-align:center;font-weight:bold;">지역별 거리두기 단계</p>
			<!-- 단계표시 -->
			<button type="button" data-city="step_map_city1" id="step_map_city1"><span class="name">서울</span><span class="num">2</span></button>
			<button type="button" data-city="step_map_city2" id="step_map_city2"><span class="name">부산</span><span class="num">2</span></button>
			<button type="button" data-city="step_map_city3" id="step_map_city3"><span class="name">대구</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city4" id="step_map_city4"><span class="name">인천</span><span class="num">2</span></button>
			<button type="button" data-city="step_map_city5" id="step_map_city5"><span class="name">광주</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city6" id="step_map_city6"><span class="name">대전</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city7" id="step_map_city7"><span class="name">울산</span><span class="num">2</span></button>
			<button type="button" data-city="step_map_city8" id="step_map_city8"><span class="name">세종</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city9" id="step_map_city9"><span class="name">경기</span><span class="num">2</span></button>
			<button type="button" data-city="step_map_city10" id="step_map_city10"><span class="name">강원</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city11" id="step_map_city11"><span class="name">충북</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city12" id="step_map_city12"><span class="name">충남</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city13" id="step_map_city13"><span class="name">전북</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city14" id="step_map_city14"><span class="name">전남</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city15" id="step_map_city15"><span class="name">경북</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city16" id="step_map_city16"><span class="name">경남</span><span class="num">1.5</span></button>
			<button type="button" data-city="step_map_city17" id="step_map_city17"><span class="name">제주</span><span class="num">1.5</span></button>
			
			
			<!-- 지도 -->
			<object id="statusSvgMap" type="image/svg+xml" data="${ root }/resource/svg/koreaMap.svg">현재 브라우저는 iframe을 지원하지 않습니다.</object>

			<!-- 지도 범례 -->
			<div id="statusMapLegend" class="row-md-1">
				<div class="col-md-1" id="legend"><div id="icon" class="row" style="background-color:#d2f0fb;"><p>1</p></div></div>
				<div class="col-md-1" id="legend"><div id="icon" class="row" style="background-color:#4088da;"><p>1.5</p></div></div>
				<div class="col-md-1" id="legend"><div id="icon" class="row" style="background-color:#ffb911;"><p>2</p></div></div>
				<div class="col-md-1" id="legend"><div id="icon" class="row" style="background-color:#fc7001;"><p>2.5</p></div></div>
				<div class="col-md-1" id="legend"><div id="icon" class="row" style="background-color:#e60000;"><p>3</p></div></div>
			</div>
		</div>
	</div> 
	
	<script>
		function resizeMapCol(){
			var h = $('#statusTableChart').height()-40;
			if($(window).width()>900){
				$('#statusMap').css('height', h);
			}else {
				$('#statusMap').css('height', '');
			}
			
			var gap = ($('#statusMap').height() - $('#statusSvgMap').height())/2-20;
			$('#statusSvgMap').css({'margin-top':gap, 'margin-bottom':gap});
		}
	</script>
	
	<script>
		/* 차트 설정, 그리기 */
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
  		
  		var chart_w = $('#statusChart').width()-30;
		var chart_h = $('#statusChart').height()-50;
    	
    	if($('#statusChart').width() <= 450) {
    		chart_w = 420;
			chart_h = 450;
    	}
  		
		var el = document.getElementById('statusChartArea');
	    var data = {
	      	categories: cate,
		    series: {
		    	  column: [
		    		  {
		    	          name: '확진자 수',
		    	          data: decideData
		    	        }
		    	  ] ,
		    	  line:[
		    		  {
		    			  name:'확진자 수',
		    	          data: decideData
		    	        }
		    	  ] 
		      }
	    };
	    var options = {
	      chart: { /* title: {
	    	  			text:'확진자 수',
	    	  			align: 'center'
	      			},  */
	      		width: chart_w, height: chart_h},
	      legend: {
	    	  visible:false
	      },
	      tooltip:{
	    	  enabled:false
	      },
	      exportMenu : {
	    	  visible:false
	      },
	      series: {
	    	  line:{
	    		dataLabels:{
	 	    		visible:true,
	      			offsetY:-10
	 	    	},
	 	      	showDot:true
	    	  }
	      }
	    };
	
	    var chart = toastui.Chart.columnLineChart({ el, data, options });
	    
	    function resizeChart(){
	    	var chart_w = $('#statusChart').width()-30;
			var chart_h = $('#statusChart').height()-50;
	    	
	    	if($('#statusChart').width() <= 450) {
	    		chart_w = 420;
				chart_h = 450;
	    	}
			
			chart.resize({
		        width: chart_w,
		        height: chart_h
			});
		}
		
	</script>
	
	<script>
		function resizeMapLabel(){
			/* map label 리사이징 */
			
			//SvgMap과 Map div의 갭을 구함
			var gap_top = $('#statusSvgMap').offset().top - $('#statusMap').offset().top;
			var gap_left = $('#statusSvgMap').offset().left - $('#statusMap').offset().left;
			
			var label_top;
			var label_left;
			
			//지역별 left, top 값 넣어놓기
			for(var i=1;i<18;i++){
				var city = "#step_map_city"+i;
				switch(i){
				case 1:/*서울*/
					label_left=134; label_top=70;  break;
				case 2:/*부산*/
					label_left=229; label_top=353;  break;
				case 3:/*대구*/
					label_left=223; label_top=279;  break;
				case 4:/*인천*/
					label_left=36; label_top=64;  break;
				case 5:/*광주*/
					label_left=94; label_top=338;  break;
				case 6:/*대전*/
					label_left=140; label_top=218;  break;
				case 7:/*울산*/
					label_left=283; label_top=307;  break;
				case 8:/*세종*/
					label_left=84; label_top=150;  break;
				case 9:/*경기*/
					label_left=104; label_top=20;  break;
				case 10:/*강원*/
					label_left=226; label_top=44;  break;
				case 11:/*충북*/
					label_left=162; label_top=132;  break;
				case 12:/*충남*/
					label_left=26; label_top=182;  break;
				case 13:/*전북*/
					label_left=100; label_top=252;  break;
				case 14:/*전남*/
					label_left=20; label_top=318;  break;
				case 15:/*경북*/
					label_left=233; label_top=198;  break;
				case 16:/*경남*/
					label_left=160; label_top=308;  break;
				case 17:/*제주*/
					label_left=54; label_top=426;  break;
				}
				
				//값 더하기
				label_left += gap_left;
				label_top += gap_top;
				
				//적용
				$(city).css({left:label_left,top:label_top});
			}
		}
		
	</script>
	
	
	<script>
		/* resize */
		window.onload = function(){
			resizeMapCol();
			resizeMapLabel();
			
	    	window.addEventListener('resize',function(){
	    		resizeChart();
	    		resizeMapCol();
	    		resizeMapLabel();
	    	});
	    };
	</script>
	
</section>
<%@ include file="/views/common/footer.jsp"%>
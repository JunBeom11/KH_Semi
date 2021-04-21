<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.status.model.vo.Status"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<section>
	<%
		List<Status> list = (ArrayList)request.getAttribute("statusList");
	
		int resultCode = (int)request.getAttribute("resultCode");
		String resultMsg = (String)request.getAttribute("resultMsg");
	%>
	
	<p><%= resultCode %></p>
	<p><%= resultMsg %></p>
	<%
		if(resultCode != 0){
	%>
			<script>
				$('#modal').on('shown.bs.modal', function () {
					  //$('#myInput').focus();
					  $('#modal-title').text('ERROR');
					  $('#modal-body').html('<p><%= resultCode %> : <%= resultMsg %></p><p>정상적으로 코로나 현황 정보를 가져오지 못했습니다.</p>');
					});
				$('#modal').modal('show');
			</script>		
	<%	}
		for(Status status:list){
			//if(resultCode != 0) break;
	%>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
		<p><%= status.getStateDt() %> : <%= status.getDecideCnt() %></p>
	<%		
		}
	%>
	
</section>

<%@ include file="/views/common/footer.jsp"%>
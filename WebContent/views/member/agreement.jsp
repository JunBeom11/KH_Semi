<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>

<style>
	h3{
		text-align:center;
	}
	td{
		text-align:left;
	}
	div{
		text-align:center;
	}
	#enrollSubmit{
		width: 30%;
		float:none;
		margin:0 auto;
	}

</style>
<h3>[개인정보 수집·이용 동의]</h3>
<div class="jumbotron">
	<table border = "1" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td>
<pre>
①개인정보의 수집·이용목적<br>
 회원관리 목적, 지역별 코로나 정보 제공 <br>

②수집하려는 개인정보의 항목<br>
 닉네임, 이메일, 생년월일, 지역<br>

③개인정보의 보유 및 이용기간(근거법률)<br>
 1년<br>

④동의를 거부할 수 있으며, 동의 거부시 서비스가 제공되지 않습니다.<br>
<b> ※ 위 개인정보 수집이용에 동의하십니까?</b><br>

</pre>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<form>
	  <input type="radio" id="agreement" name="check" value="agreement">
	  <label for="agreement">동의함</label>&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="radio" id="disagreement" name="check" value="disagreement">
	  <label for="disagreement">동의하지않음</label>
	</form>
</div>
	<input type="submit" class="btn btn-outline-success btn-lg" id="enrollSubmit" value="가입하기" />
	<br>
	<br>
<script>
	$(document).ready(() => {
		$("#enrollSubmit").on("click", () => {
			if($("input[id='agreement']:checked").val() != null){
				$(location).attr('href','<%= request.getContextPath() %>/member/enroll');
			}else{
				alert('회원가입을 위한 개인정보 수집 동의는 필수입니다.');
			}
	    });
	});
</script>

<%@ include file="/views/common/footer.jsp" %>

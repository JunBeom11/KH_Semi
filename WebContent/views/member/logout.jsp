<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="checkLogoutForm" ></form>
	<script type="text/javascript">
			if (confirm("정말 로그아웃 하시겠습니다?") == true){  
				checkLogoutForm.action="<%=request.getContextPath() %>/member/logout";
				checkLogoutForm.method="post";
				checkLogoutForm.submit();
			}else{  
				history.back();
			}
	</script>
</body>
</html>

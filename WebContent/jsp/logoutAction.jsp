<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>실질적으로 로그인 시도를 처리해주는 페이지</title>
</head>
<body>
	<%
		session.invalidate(); // 현재 접속한 회원이 바로 세션을 빼앗기도록 만들어서 로그아웃 시킨 다음 밑에
	%>
	<script type="text/javascript">
		location.href ='main.jsp';  // 로케이션 링크를 걸어서 main.jsp로 이동 할 수 있도록 만듦
	</script>
</body>
</html>
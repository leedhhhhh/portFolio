<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!-- 이렇게되면 이제 이 페이지 안에 넘어온 id와 password가 담기게 됨 usebean의 id와 setProperty의 name은 같다. 매개변수 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>실질적으로 로그인 시도를 처리해주는 페이지</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userID = (String)session.getAttribute("userID");
		}
		String userID1 = null;
		if(request.getParameter("userID")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userID1 = request.getParameter("userID");
		}

		String userPassword = null;
		if(request.getParameter("userPassword")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userPassword = request.getParameter("userPassword");
		}
		String userName = null;
		if(request.getParameter("userName")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userName = request.getParameter("userName");
		}
		String userGender = null;
		if(request.getParameter("userGender")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userGender = request.getParameter("userGender");
		}
		String userEmail = null;
		if(request.getParameter("userEmail")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userEmail = request.getParameter("userEmail");
		}
		String userMap = null;
		if(request.getParameter("map")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userMap = request.getParameter("map");
		}
		String userPhNum = null;
		if(request.getParameter("userPhNum")!=null){ // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userPhNum = request.getParameter("userPhNum");
		}
		if(userID!=null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}
		if(userID1==null||userPassword==null||userName==null||userEmail==null||userPhNum==null||userMap==null||userGender==null){	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(userID1, userPassword, userName, userGender, userEmail, userMap, userPhNum);
			if(result==-1){ // DAO에서 -1일때는 데이터베이스가 오류가 날때인데 이 경우는 이미 아이디가 존재할때밖에 없다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{ // 회원가입이 성공했을경우 main.jsp로 이동하도록 
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href ='main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>
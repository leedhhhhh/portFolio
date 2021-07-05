<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
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

		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}else{
				UserDAO userDAO = new UserDAO();
				int result = userDAO.update(userPassword, userEmail, userMap, userPhNum, userID);
				if (result == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원 수정에 실패하였습니다.')");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원 수정에 성공하였습니다.')");
					session.invalidate();
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
		
	%>
</body>
</html>
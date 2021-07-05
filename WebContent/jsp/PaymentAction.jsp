<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="detail.DetailDAO"%>
<%@ page import="detail.Detail"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="detail" class="detail.Detail" scope="page" />
<jsp:setProperty name="detail" property="productName" />
<jsp:setProperty name="detail" property="productInformation" />
<jsp:setProperty name="detail" property="originalPrice" />
<jsp:setProperty name="detail" property="salePrice" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userID = (String) session.getAttribute("userID");
		}	
		
		String cardPw = null;
		if(request.getParameter("cardPw") != null){
			cardPw = request.getParameter("cardPw");
		}
		String cardNum = null;
		if(request.getParameter("cardNum") != null){
			cardNum = request.getParameter("cardNum");
		}
		String message = null;
		if(request.getParameter("message") != null){
			message = request.getParameter("message");
		}
		String phnum  = null;
		if(request.getParameter("phnum") != null){
			phnum = request.getParameter("phnum");
		}
		String map = null;
		if(request.getParameter("map") != null){
			map = request.getParameter("map");
		}
		String name = null;
		if(request.getParameter("name") != null){
			name = request.getParameter("name");
		}
		
		String[] bank = request.getParameterValues("bank");
			
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 작업입니다.')");
			script.println("location.href = 'loginPage.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
			
		}
		for(int i =0; i<bank.length; i++){
		if(name.equals("")||map.equals("")||phnum.equals("")||message.equals("")||cardNum.equals("")||cardPw.equals("")||bank[i].equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('빈칸을 모두 채워주시고 선택사항을 모두 선택해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else {  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('신용카드결제가 완료되었습니다.')");
			script.println("location.href = 'main.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
			}
		}
	%>
</body>
</html>
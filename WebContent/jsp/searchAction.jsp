<%@page import="detail.Detail"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="detail.DetailDAO"%>
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
<title>실질적으로 상세페이지등록 시도를 처리해주는 페이지</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userID = (String) session.getAttribute("userID");
		}
		String productSearch = null;
		if(request.getParameter("productSearch") != null){
			productSearch = request.getParameter("productSearch");
		}
		
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
 		

		
		if(productSearch.equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
 				script.println("alert('검색어를 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}else {  
					PrintWriter script = response.getWriter();

					script.println("<script>");
					script.println("location.href = 'searchProductPage.jsp?productSearch="+productSearch+"'"); 
					script.println("</script>");
				}


	%>
</body>
</html>
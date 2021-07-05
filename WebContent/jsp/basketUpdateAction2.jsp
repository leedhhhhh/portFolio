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
<title>실질적으로 상세페이지등록 시도를 처리해주는 페이지</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			userID = (String) session.getAttribute("userID");
		}		
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		int basketNum = 0;
		if (request.getParameter("basketNum") != null){
			basketNum = Integer.parseInt(request.getParameter("basketNum"));
		}
		int productCode = 0;
		if (request.getParameter("productCode") != null){
			productCode = Integer.parseInt(request.getParameter("productCode"));
		} 
		int basketCode = 0;
		if (request.getParameter("basketCode") != null){
			basketCode = Integer.parseInt(request.getParameter("basketCode"));
		} 
		int basketCount = 0;
		if (request.getParameter("basketCount") != null){
			basketCount = Integer.parseInt(request.getParameter("basketCount"));
		} 
		
		String productName = null;
		if(session.getAttribute("productName") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			productName = (String) session.getAttribute("productName");
		}
		
		String productInformation = null;
		if(session.getAttribute("productInformation") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			productInformation = (String) session.getAttribute("productInformation");
		}
		
		String salePrice = null;
		if(session.getAttribute("salePrice") != null) { // session.getAttribute() 는 seesion값에 저장되있는 값을 가져오는거
			salePrice = (String) session.getAttribute("salePrice");
		}
		String[] quantity1 = request.getParameterValues("quantity4");
		String[] color1 = request.getParameterValues("color4");
		String[] size1 = request.getParameterValues("size4");
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 작업입니다.')");
			script.println("opener.parent.location.href = 'loginPage.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("window.close()");
			
			script.println("</script>");
		}else{  
			DetailDAO detailDAO = new DetailDAO();
			Detail detail1 = new DetailDAO().getDetail2(basketCode);
			ArrayList<Detail> list1 = detailDAO.getList1(basketNum);
			for(int j = 0; j<quantity1.length; j++){
				for(int i=0; i<color1.length; i++){
					for(int z=0; z<size1.length; z++){
			int result = detailDAO.update(list1.get(i).getBasketCode(),quantity1[j], color1[i],size1[z]);
					}
				}
			}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정되었습니다.')");
			script.println("opener.parent.location.reload()");
			script.println("window.close()");
			script.println("</script>");	
			}
				 
			
	%>
</body>
</html>
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
		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 작업입니다.')");
			script.println("location.href = 'loginPage.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}else{  
			DetailDAO detailDAO = new DetailDAO();
			Detail detail1 = new DetailDAO().getDetail(productCode); //
			String[] color1 = request.getParameterValues("color");
			String[] quantity1 = request.getParameterValues("quantity");
			String[] size1 = request.getParameterValues("size");
			
			for(int i=0; i<color1.length; i++){
				for(int j = 0; j<quantity1.length; j++){
					for(int z =0; z<size1.length; z++){
				if(color1[i].equals("")||quantity1[i].equals("")||size1[z].equals("")){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('선택사항을 모두 선택해주세요.')");
					script.println("location.href = 'DetailPageView.jsp?productCode="+ productCode+"'");
					script.println("</script>");
				}else{
					int result = detailDAO.insert(userID,basketNum, detail1.getProductName(), 
							detail1.getProductInformation(), detail1.getSalePrice(), color1[i],quantity1[j],size1[z],productCode);
						}
					}
				}
			}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='shoppingbasket.jsp?productCode="+productCode+"'");
			script.println("alert('장바구니에 추가되었습니다.')");
			script.println("</script>");	
			}
	%>
</body>
</html>
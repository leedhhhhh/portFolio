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
		
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
 		String realFolder="";
		String saveFolder = "img1";
		String encType = "utf-8";
		int maxSize=5*1024*1024;
		
		ServletContext context = this.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		
		MultipartRequest multi = null;
		
		multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());		
		String fileName = multi.getFilesystemName("fileName");
		
		String productName = multi.getParameter("productName");
		String productInformation = multi.getParameter("productInformation");
		String originalPrice = multi.getParameter("originalPrice");
		String salePrice = multi.getParameter("salePrice");
		
		detail.setProductName(productName);
		detail.setProductInformation(productInformation);
		detail.setOriginalPrice(originalPrice);
		detail.setSalePrice(salePrice);
	
		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 작업입니다.')");
			script.println("location.href = 'loginPage.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}else{
			 if(detail.getProductName() == null || detail.getProductInformation() == null || 
					detail.getOriginalPrice() == null || detail.getSalePrice() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
 				script.println("alert('입력되지않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {  
				DetailDAO detailDAO = new DetailDAO();
				int productCode = detailDAO.write(productName, productInformation, originalPrice, salePrice,boardID);
				if (productCode == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();

					if(fileName != null){
						File oldFile = new File(realFolder+"\\"+fileName);
						File newFile = new File(realFolder+"\\"+(productCode-1)+"상세페이지용사진.jpg");
						oldFile.renameTo(newFile);
					}
					script.println("<script>");
					script.println("alert('성공적으로 등록되었습니다.')");
					script.println("history.back()");
					/* script.println("location.href= \'DetailPageView.jsp?boardID="+boardID+"\'"); */
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
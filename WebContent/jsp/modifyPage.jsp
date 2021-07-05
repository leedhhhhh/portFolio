<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 사용할 수 있게 하는 코드 -->
<%@ page import="detail.Detail" %>
<%@ page import="detail.DetailDAO" %>
<%@ page import="basket.BasketDAO" %>
<%@ page import="basket.Basket" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
<meta name="viewport" content="width=device-width" initial-scale="1"  >
<style type="text/css">
    .navbar {
      margin-top: -30px;
      border-radius: 0;
    }
    
    /* Remove the jumbotron's default bottom margin */ 
     .jumbotron {
      margin-bottom: 0;
      background-color: #364F6B;
    }
    
      .carousel-inner img {
      width: 100%; /* Set width to 100% */
      margin: auto;
      min-height:200px;
  	}
      footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
    
    /* .row.content {height: 1000px} */
    
    /* Set gray background color and 100% height */
    .sidenav {
      background-color: white;
      height: 100%;
    }

    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 500px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height: auto;} 
    }
</style>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/custom.css">
</head>
<body>
	<%
		
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		int productCode = 0;
		if (request.getParameter("productCode") != null){
			productCode = Integer.parseInt(request.getParameter("productCode"));
		}
		
		int basketNum = 0;
		if(request.getParameter("basketNum") != null){
			basketNum = Integer.parseInt(request.getParameter("basketNum"));
		}
		int basketCode = 0;
		if(request.getParameter("basketCode") != null){
			basketCode = Integer.parseInt(request.getParameter("basketCode"));
		}
		int basketCount = 0;
		if (request.getParameter("basketCount") != null){
			basketCount = Integer.parseInt(request.getParameter("basketCount"));
		} 
		 String color[] = request.getParameterValues("color");
/* 		String productName = null;
		if(session.getAttribute("productName") != null){
			productName = (String)session.getAttribute("productName");
		}
		 */
		
/* 		Detail detail1 = new DetailDAO().getDetail1(productName); */
		Detail detail = new DetailDAO().getDetail(productCode);

		String productname = (String)session.getAttribute("productName");
		session.setAttribute("productName", productname);
		/* String productname = request.getParameter("productName");
		session.setAttribute("productName", productname);  */
	
		DecimalFormat formatter = new DecimalFormat("###,###");
	
	%>

	
	<h2>상품수정페이지</h2>
	<%
		DetailDAO detailDAO = new DetailDAO();
		ArrayList<Detail> list1 = detailDAO.getList1(basketNum);
		Detail detail2 = new DetailDAO().getDetail2(basketCode);
	%>
	<form action="basketUpdateAction.jsp?basketCode=<%= basketCode %>" method="post">
	    	<label for="size">Size</label>
				<select id="size4" name="size4" class="form-control">
					<option value="" selected>-- 선택 --</option>
					<option value="S">S</option>
					<option value="M">M</option>
					<option value="L">L</option>
					<option value="XL">XL</option>
				</select>

			<label for="size">Color</label>
				<select id="color4" name="color4" class="form-control">
					<option value='' selected>-- 선택 --</option>
					<option value="Blue">Blue</option>
					<option value="Green">Green</option>
					<option value="Red">Red</option>
				</select>

			<label for="size">Quantity</label>
	        	<select id="quantity4" name="quantity4" class="form-control">
					<option value='' selected>-- 선택 --</option>
					<option value='1'>1</option>
					<option value='2'>2</option>
					<option value='3'>3</option>
					<option value='4'>4</option>
					<option value='5'>5</option>
					<option value='6'>6</option>
					<option value='7'>7</option>
					<option value='8'>8</option>
				</select>

		 	<br><br>
		 <input type="submit" class="btn btn-default btn-pull" value="수정" onclick="return confirm('정말로 수정하시겠습니까?')">
		 </form>
		<br><br>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
			integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" 
			crossorigin="anonymous"></script>  
</body>
</html>
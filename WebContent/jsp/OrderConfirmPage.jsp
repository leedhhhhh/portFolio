<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 사용할 수 있게 하는 코드 -->
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="detail.Detail" %>
<%@ page import="detail.DetailDAO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width" initial-scale="1" >
<title>JSP 게시판 웹사이트</title>
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
		int productCode = 0;
		if (request.getParameter("productCode") != null){
			productCode = Integer.parseInt(request.getParameter("productCode"));
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		int basketNum = 0;
		if(request.getParameter("basketNum") != null){
			basketNum = Integer.parseInt(request.getParameter("basketNum"));
		}
		
		DetailDAO detailDAO = new DetailDAO();
		ArrayList<Detail> list1 = detailDAO.getList1(basketNum);
	%>
	<div class="jumbotron" style="background-color: white;">
	  <div class="container text-center">
		   <h1>Bed Place</h1>      
		    <p>Mission, Vision & Values</p>
	  </div>
	</div>
	<nav class="navbar navbar-inverse" id="navbar" style="background-color: #364F6B; border-radius: 0; border: 0;">
	<div class="container-fluid">
	<a class="navbar-brand" href="main.jsp" style="color: white;">Bed Place</a>
		<ul class="nav navbar-nav" >
	        <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">MENU<span class="caret"></span></a>
	        	<ul class="dropdown-menu">
	        		<li><a href="TopProductPage.jsp">BED</a></li>
	        		<li><a href="newProductPage.jsp">NEW</a></li>
	        		<li><a href="salePage.jsp">SALE</a></li>
	        	</ul>
	        </li>
	         <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">HELP<span class="caret"></span></a>
		        <ul class="dropdown-menu">
		        	<li><a href="bbs.jsp">SERVICE CENTER</a></li>
		        </ul>
	        </li>
      	</ul>
		 <!-- 로그인이 되어있지않은사람은 로그인이나 회원가입을 할 수 있도록 하는 코드 -->
		<%
			if(userID == null){
		%>
			<ul class="nav navbar-nav navbar-right">
		      <li><a href="join.jsp" style="color: white;"><span class="glyphicon glyphicon-user"></span> SIGN UP</a></li>
		      <li><a href="loginPage.jsp" style="color: white;"><span class="glyphicon glyphicon-log-in"></span> LOGIN</a></li>
    		</ul>
		<%
			} else if(userID != null && !userID.equals("admin")) {
		%>
			<ul class="nav navbar-nav navbar-right">
		      <li><a href="../jsp/logoutAction.jsp" style="color: white;"><span class="glyphicon glyphicon-log-out"></span> LOGOUT</a></li>
    		</ul>
			<ul class="nav navbar-nav navbar-right">
		      <li><a href="EditMemberPage.jsp" style="color: white;"><span class="glyphicon glyphicon-user"></span> PROFILE</a></li>
    		</ul>
    		<ul class="nav navbar-nav navbar-right">
		      <li><a href="shoppingbasket.jsp" style="color: white;"><span class="glyphicon glyphicon-shopping-cart"></span> SHOPPING CART</a></li>
    		</ul>
		<%
			} else if(userID.equals("admin")){
		%>
			<ul class="nav navbar-nav navbar-right">
		      <li><a href="../jsp/logoutAction.jsp" style="color: white;"><span class="glyphicon glyphicon-log-out"></span> LOGOUT</a></li>
    		</ul>
			<ul class="nav navbar-nav navbar-right">
		      <li><a href="adminPage.jsp" style="color: white;"><span class="glyphicon glyphicon-user"></span> 관리자화면</a></li>
    		</ul>
		<%		
			}
		%>
	</div>
	</nav>
	
	<ul class="nav nav-tabs">
	  <li><a href="adminPage.jsp" style="color: black">회원조회</a></li>  
	  <li class="active"><a href="OrderConfirmPage.jsp" style="color: black">주문내역확인</a></li>
	  <li><a href="DetailPage_register.jsp" style="color: black">상세페이지등록</a></li>
	</ul>
	<br><br>
	
	<div class="container">
	<br>
	<h3>주문내역</h3>
	  <br>
		  <table class="table">
		    <thead>
		      <tr>
		        <th>ID</th>
		        <th>상품명</th>
		        <th>상품정보</th>
		        <th>수량</th>
		        <th>색상</th>
		        <th>사이즈</th>
		        <th>가격</th>
		        <th>주문날짜</th>
		      </tr>
		    </thead>
		    <tbody>
			    <% 
					for(int i =0; i<list1.size(); i++){
					
	    		%>
		      <tr>
		        <td><%= list1.get(i).getUserID()  %></td>
		        <td><%= list1.get(i).getProductName() %></td>
		        <td><%= list1.get(i).getProductInformation() %></td>
		        <td><%= list1.get(i).getQuantity() %></td>
		        <td><%= list1.get(i).getColor() %></td>
		        <td><%= list1.get(i).getSize() %></td>
		        <td><%= list1.get(i).getSalePrice() %></td>
		        <td><%= list1.get(i).getDate() %></td>
		      </tr>
		      <%
				}
		      %>
		    </tbody>
		  </table>
	</div>
	
	
<br><br>
<footer class="container-fluid text-center">
  <p>Online Store Product Search</p>  
  <form class="form-inline">Product:
    <input type="email" class="form-control" size="50" placeholder="Search">
    <button type="button" class="btn btn-danger">Search</button>
  </form>
</footer>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
			integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" 
			crossorigin="anonymous"></script>  
</body>
</html>
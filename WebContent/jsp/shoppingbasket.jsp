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
			basketNum = Integer.parseInt(request.getParameter("basketCode"));
		}
		 String color[] = request.getParameterValues("color");
		Detail detail = new DetailDAO().getDetail(productCode);

		String productname = (String)session.getAttribute("productName");
		session.setAttribute("productName", productname);
	
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		int sum = 0;
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
		      <li><a href="join.jsp" style="color: white;"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
		      <li><a href="loginPage.jsp" style="color: white;"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
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
	<br><br><br>

	
		
	<ul class="nav nav-tabs">
	  <li><a href="EditMemberPage.jsp" style="color: black">회원정보수정</a></li>  
	  <li><a href="OrderHistoryPage.jsp" style="color: black">주문내역</a></li>
	  <li class="active"><a href="shoppingbasket.jsp" style="color: black">장바구니</a></li>
	</ul>
	<br><br>
	<%
		if(userID == null){
	%>
			x
	<%
		}
	%>
	<%
		for(int i =0; i<list1.size(); i++){
	%>
	<form action="basketDeleteAction.jsp?basketCode=<%= list1.get(i).getBasketCode() %>" method="post">
	<%
		}
	%>

	<div class="container">
    <div class="row">
        <div class="col-sm-12 col-md-10 col-md-offset-1">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th class="text-center">Price</th>
                        <th class="text-center">Total</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
    				<%
    	
    				Detail result = detailDAO.getDetail1(productCode);

					ArrayList<Detail> list2 = detailDAO.getList2(productCode);
		
					for(int i =0; i<list1.size(); i++){
					if(userID.equals(list1.get(i).getUserID())){
    				%>
                    <tr>
                        <td class="col-md-6">
                        <div class="media">
                            <div class="media-body">
                                <h4 class="media-heading"><a href="DetailPageView.jsp?productCode=<%=list1.get(i).getProductCode()%>"><%= list1.get(i).getProductName()%></a></h4>
                                <h5 class="media-heading">color : <%= list1.get(i).getColor() %></h5>
                                <h5 class="media-heading">size : <%= list1.get(i).getSize() %></h5>
                                <span class="text-warning"><strong><%= list1.get(i).getProductInformation() %></strong></span>
                            </div>
                        </div></td>
                        <td class="col-md-1" style="text-align: center">
                        <strong id="saleprice">
                       	<%= list1.get(i).getQuantity() %>
                        </strong>
                        </td>
                        <% int saleprice = Integer.parseInt(list1.get(i).getSalePrice()); %>
                        <td class="col-md-1 text-center">
                        <strong id="saleprice">
                        <fmt:formatNumber value="<%= saleprice %>" pattern="#,###,###"/>
                        </strong></td>
                        <td class="col-md-1 text-center">
                        <strong id="sum">
                        <% sum = (Integer.parseInt(list1.get(i).getSalePrice()) * Integer.parseInt(list1.get(i).getQuantity())) ; %>
                        <fmt:formatNumber value="<%= sum %>" pattern="#,###,###"/>
                        </strong>
                        </td>
                        
                        <td class="col-md-1">
                        <input type="submit" class="btn btn-danger" value="Remove" onclick="return confirm('정말로 삭제하시겠습니까?')">
                        <br>
                        <a href = "javascript:void(0);" onclick="window.open('modifyPage.jsp?basketCode=<%=list1.get(i).getBasketCode() %>', 'pop01', 'top=10, left=10, width=600, height=400');" class="btn btn-default btn-pull">수정</a>
                        </td>
                    </tr>
                    <%
							}
						}
					%>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td><h3>Total</h3></td>
                        <td class="text-right"><h3>
                        <%
                        	int total=0;
                        	for(int i =0; i<list1.size(); i++){
                        		if(userID.equals(list1.get(i).getUserID())){
                        		total += (Integer.parseInt(list1.get(i).getSalePrice()) * Integer.parseInt(list1.get(i).getQuantity())) ;
                        	}
                        	}
                        %>
                        <strong>
                        	<fmt:formatNumber value="<%= total %>" pattern="#,###,###"/>
                        </strong>
                        </h3></td>
                    </tr>

                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td>
                        <a href="TopProductPage.jsp">
                        <button type="button" class="btn btn-default">
                        	<span class="glyphicon glyphicon-shopping-cart"></span> Continue Shopping
                        </button>
                        </a>
                        </td>
                        <td>
                        <a href="PaymentPage.jsp">
                        <button type="button" class="btn btn-success">
                            	주문하기 <span class="glyphicon glyphicon-play"></span>
                        </button>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</form>

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
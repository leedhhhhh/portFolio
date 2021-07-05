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
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
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
<script type="text/javascript">

	function goPopup(){
		var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadFullAddr){
		document.form.map.value = roadFullAddr;
	}
</script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/custom.css">
</head>
<body>
	<%
		
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		
		String userPhNum = null;
		if(session.getAttribute("userID")!=null){
			userPhNum = (String)session.getAttribute("userPhNum");
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
		
		User user = new User();
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
	<form name="form" action="PaymentAction.jsp" method="post">
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
                        <a href = "javascript:void(0);" onclick="window.open('modifyPage.jsp?basketCode=<%=list1.get(i).getBasketCode() %>', 'pop01', 'top=10, left=10, width=600, height=400');" class="btn btn-danger">수정</a>
                        </td>
                    </tr>
                    <%
							}
						}
					%>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
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
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            	  <h3>주문</h3>
				  <br>
				  <fieldset>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">이름</font></font></label>
					    <input type="text" name="name" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="이름">					  
					  </div>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">주소</font></font></label>
					    <input type="text" name="map" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="주소">
					  </div>
					  <input style="width: 150px" type="button" onClick="goPopup();" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value="주소검색"/>
					  <br>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">휴대전화</font></font></label>
					    <input type="text" name="phnum" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="휴대전화">
					     <small id="emailHelp" class="form-text text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">귀하의 정보를 다른 사람과 공유하지 않습니다.</font></font></small>
					  </div>
					   <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">베송메시지</font></font></label>
					    <input type="text" name="message" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="원하시는 배송메시지를 입력해주세요.">
					  </div>
					</fieldset>
					<br><br>
					<ul class="nav nav-tabs">
					  <li class="active"><a href="PaymentPage.jsp" style="color: black">신용카드</a></li>  
					  <li><a href="AccountPage.jsp" style="color: black">무통장입금</a></li>
					</ul>
					<br>
					<div class="form-group">
				      <label for="exampleSelect1" class="form-label mt-4">카드종류</label><br>
				      <select name="bank" class="form-select" id="exampleSelect1">
				        <option value="신한">신한</option>
				        <option value="우리">우리</option>
				        <option value="농협">농협</option>
				        <option value="국민">국민</option>
				        <option value="삼성">삼성</option>
				      </select>
				    </div>
					<div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">카드번호</font></font></label>
					    <input type="text" name="cardNum" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="카드번호">
						<small id="emailHelp" class="form-text text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">-을 제외하고 입력하세요.</font></font></small>
					</div>
					<div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">카드비밀번호</font></font></label>
					    <input type="password" name="cardPw" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="카드비밀번호">
					</div>
					<input type="submit" class="btn btn-danger" value="결제하기">
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
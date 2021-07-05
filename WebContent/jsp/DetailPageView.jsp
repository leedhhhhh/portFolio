<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 사용할 수 있게 하는 코드 -->
<%@ page import="detail.Detail" %>
<%@ page import="detail.DetailDAO" %>
<%@ page import="java.io.File" %>
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
</style>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">

<link rel="stylesheet" href="../css/detail.css">

</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		
		int productCode = 0;
		if(request.getParameter("productCode") != null){
			productCode = Integer.parseInt(request.getParameter("productCode"));
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		Detail detail = new DetailDAO().getDetail(productCode); // 이게 어떤부분인지..

	%>

	
	<div class="pd-wrap">
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
	<br>
	<form name="chk" action="addAction.jsp?productCode=<%= productCode %>" method="post" onsubmit="return chk();">
	<div class="container">
	        <div class="heading-section">
	            <h2>Online Store</h2>
	        </div>
	        <br>
	        <div class="row">
	        	<div class="col-md-6">
					<div class="item">
					<% 	
					String real = "C:\\Users\\leedh\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\LDHPortFolio_Board\\img1";
					File viewFile = new File(real+"\\"+productCode+"상세페이지용사진.jpg");
					if(viewFile.exists()){
					%>
						<img name="image" src = "../img1/<%= productCode %>상세페이지용사진.jpg" style="width: 500px; height: 300px" />
					<%
					}
					%>
					</div>
	        	</div>
	        	<div class="col-md-6">
	        		<div class="product-dtl">
        				<div class="product-info">
		        			<div class="product-name" id="productName">
		        				<%= detail.getProductName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %>
		        			</div>
		        			<div class="product-price-discount" style="color: red;">
		        				<span name="price"><%= detail.getSalePrice().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></span>
		        				<span class="line-through"><%= detail.getOriginalPrice().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></span>
		        			</div>
	        			<p name="information"><%= detail.getProductInformation().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></p>
	        			<div class="row">
	        				<div class="col-md-6">
	        					<label for="size">Size</label>
								<select id="size" name="size" class="form-control">
									<option value="" selected>-- 선택 --</option>
									<option value="S">S</option>
									<option value="M">M</option>
									<option value="L">L</option>
									<option value="XL">XL</option>
								</select>
	        				</div>
	        				<div class="col-md-6">
	        					<label for="color">Color</label>
								<select id="color" name="color" class="form-control">
									<option value='' selected>-- 선택 --</option>
									<option value="Blue">Blue</option>
									<option value="Green">Green</option>
									<option value="Red">Red</option>
								</select>
	        				</div>
	        			</div>
	        			<div class="product-count">
	        				<label for="size">Quantity</label>
	        				<select id="quantity" name="quantity" class="form-control">
							  <option value='' selected>-- 선택 --</option>
							  <option value='1'>1</option>
							  <option value='2'>2</option>
							  <option value='3'>3</option>
							  <option value='4'>4</option>
							  <option value='5'>5</option>
							  <option value='6'>6</option>
							  <option value='7'>7</option>
							  <option value='8'>8</option>
							  <option value='9'>9</option>
							</select>
							<input type="submit" value="Add to Cart" class="round-black-btn">
							<%-- <a href="addAction.jsp?productCode=<%= productCode %>" class="round-black-btn">Add to Cart</a> --%>
							<!-- <a href="shoppingbasket.jsp" class="round-black-btn">Add to Cart</a> -->
	        			</div>
	        		</div>
	        	</div>
	        </div>
	        </form>
	        <br><br>
	        <div class="product-info-tabs">
		        <ul class="nav nav-tabs" id="myTab" role="tablist">
				  	<li class="nav-item">
				    	<a class="nav-link active" id="description-tab" data-toggle="tab" href="#description" role="tab" aria-controls="description" aria-selected="true">Detail</a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">Reviews (0)</a>
				  	</li>
				</ul>
				<div class="tab-content" id="myTabContent">
				  	<div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
				  		여기는 상세페이지
				  	</div>
				  	<div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
				  		<div class="review-heading">REVIEWS</div>
				  		<p class="mb-20">There are no reviews yet.</p>
				  		<form class="review-form">
		        			<div class="form-group">
			        			<label>Your rating</label>
			        			<div class="reviews-counter">
									<div class="rate">
									    <input type="radio" id="star5" name="rate" value="5" />
									    <label for="star5" title="text">5 stars</label>
									    <input type="radio" id="star4" name="rate" value="4" />
									    <label for="star4" title="text">4 stars</label>
									    <input type="radio" id="star3" name="rate" value="3" />
									    <label for="star3" title="text">3 stars</label>
									    <input type="radio" id="star2" name="rate" value="2" />
									    <label for="star2" title="text">2 stars</label>
									    <input type="radio" id="star1" name="rate" value="1" />
									    <label for="star1" title="text">1 star</label>
									</div>
								</div>
							</div>
		        			<div class="form-group">
			        			<label>Your message</label>
			        			<textarea class="form-control" rows="10"></textarea>
			        		</div>
			        		<div class="row">
				        		<div class="col-md-6">
				        			<div class="form-group">
					        			<input type="text" name="" class="form-control" placeholder="Name*">
					        		</div>
					        	</div>
				        		<div class="col-md-6">
				        			<div class="form-group">
					        			<input type="text" name="" class="form-control" placeholder="Email Id*">
					        		</div>
					        	</div>
					        </div>
					        <button class="round-black-btn">Submit Review</button>
			        	</form>
				  	</div>
				</div>
			</div>
		</div>
	</div>
	<br><br><br><hr>

	
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
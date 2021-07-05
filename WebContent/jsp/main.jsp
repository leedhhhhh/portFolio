<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 사용할 수 있게 하는 코드 -->
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
<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();   
});
</script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/custom.css">
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50">
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
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
		      <li><a href="EditMemberPage.jsp" data-toggle="tooltip" data-placement="top" title="<%=userID %>님!" style="color: white;"><span class="glyphicon glyphicon-user"></span> PROFILE</a></li>
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
	
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="margin: 30px;">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item">
      <img src="../image/image8.jpg" alt="...">
      <div class="carousel-caption"></div>
    </div>
    <div class="item">
      <img src="../image/image2.jpg" alt="...">
      <div class="carousel-caption"></div>
    </div>
    <div class="item active">
      <img src="../image/image7.jpg" alt="...">
      <div class="carousel-caption"></div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
	<br><br><br><br><br>
	<div class="container">    
  		<div class="row">
    	<div class="col-sm-4">
      	<div class="panel panel-primary" style="border: 0">
        	<div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        	<div class="panel-body"><img src="../image/image4.jpg" class="img-responsive center-block" style="width:100%" alt="Image"></div>
        	<div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      	</div>
    </div>
   <div class="col-sm-4">
      <div class="panel panel-primary" style="border: 0">
        <div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="../image/image5.jpg" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
       <div class="col-sm-4">
      <div class="panel panel-primary" style="border: 0">
        <div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="../image/image6.jpg" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
  </div>
</div><br>

	<div class="container">    
  	<div class="row">
    <div class="col-sm-4">
      <div class="panel panel-primary" style="border: 0">
        <div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="../image/image4.jpg" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
   <div class="col-sm-4">
      <div class="panel panel-primary" style="border: 0">
        <div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="../image/image5.jpg" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
       <div class="col-sm-4">
      <div class="panel panel-primary" style="border: 0">
        <div class="panel-heading" style="background-color: #364F6B">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="../image/image6.jpg" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer" style="background-color: #FC5185">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
  </div>
</div><br><br>

<footer class="container-fluid text-center">
  <p>Online Store Product Search</p>  
  <form action="searchAction.jsp" method="post" class="form-inline">Product:
    <input type="text" name="productSearch" class="form-control" size="50" placeholder="Search">
    <input type="submit" class="btn btn-danger" value="Search">
  </form>
</footer>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
			integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" 
			crossorigin="anonymous"></script>  
</body>
</html>
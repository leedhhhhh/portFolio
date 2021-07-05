<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
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
<script type="text/javascript">

	function goPopup(){
		var pop = window.open("jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadFullAddr){
		document.form.map.value = roadFullAddr;
	}
</script>
<title>JSP 게시판 웹사이트</title>
<meta name="viewport" content="width=device-width" initial-scale="1"  >
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/custom.css">
</head>
<body>
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
		<ul class="nav navbar-nav navbar-right">
		      <li><a href="join.jsp" style="color: white;"><span class="glyphicon glyphicon-user"></span> SIGN UP</a></li>
		      <li><a href="loginPage.jsp" style="color: white;"><span class="glyphicon glyphicon-log-in"></span> LOGIN</a></li>
    		</ul>
		</div>
	</nav>
	<br><br>
	<div class="container" style="border: 1px solid #E6E6E6; background:#FAFAFA; border-radius: 10px">
    <div class="row">
        <div class="col-sm-12 col-md-10 col-md-offset-1">
        <br>
        <form method="post" action="joinAction.jsp" id="form" name="form">
				<h3>SIGN UP</h3>
				  <br>
				  <fieldset>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">아이디</font></font></label>
					    <input type="text" name="userID" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="아이디">					  
					  </div>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">비밀번호</font></font></label>
					    <input type="password" name="userPassword" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="비밀번호">
					  </div>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">이름</font></font></label>
					    <input type="text" name="userName" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="이름">
					  </div>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">주소</font></font></label>
					    <input type="text" name="map" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="주소">
					  </div>
					  <input style="width: 150px" type="button" onClick="goPopup();" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" value="주소검색"/>
					  <br>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">전화번호</font></font></label>
					    <input type="text" name="userPhNum" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="전화번호">
					  </div>
					  <div class="form-group">
					  	<label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">이메일</font></font></label>
					    <input type="email" name="userEmail" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="이메일">
					  </div>
				      <label for="exampleInputEmail1" class="form-label mt-4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">성별</font></font></label>
				      <div class="form-row">
						<div class="btn-group" data-toggle="buttons">
							<label>
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자 
							</label>
						</div>
					</div>
				    </fieldset>
					<br><br>
					<input type="submit" class="btn btn-default btn-pull" value="회원가입"><br>
					<small id="emailHelp" class="form-text text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">귀하의 정보를 다른 사람과 공유하지 않습니다.</font></font></small>
	        </form>
	        </div>
	    </div>
	    <br><br>
	</div>
	<br><br>
	<!-- <div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 50px; margin-top: 50px;">
				<form method="post" action="joinAction.jsp" id="form" name="form">
					<h3 style="text-align: center;">회 원 가 입 화 면</h3>
					<br>
					<div class="form-group">
						<input type="text" class="form-control" id="userID" name="userID" placeholder="아 이 디" maxlength="20">
					</div>
					<br>
					<div class="form-group">
						<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비 밀 번 호" maxlength="20">
					</div>
					<br> 
					<div class="form-group">
						<input type="text" class="form-control" id="userName" name="userName"
							placeholder="이 름" maxlength="20">
					</div>
					<br>
					<div class="form-row" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자 
							</label>
						</div>
					</div>
					<br>
					<div class="form-group">
						<input type="text" id="userMap" name="map" class="form-control" placeholder="주소"/>
						<input type="button" onClick="goPopup();" value="주소 검색"/>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" id="userID" name="userEmail" placeholder="이 메 일" maxlength="20">
					</div>
					<br>
					<input type="submit" class="btn btn-default btn-pull" value="회원가입">
				</form>
			</div>
		</div>
	</div><br><br> -->
	
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
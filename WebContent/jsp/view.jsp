<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<style type="text/css">
	a, a:hover {
		color: #190707;
		text-decoration : none;	
	}
	
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
<title>JSP 게시판 웹사이트</title>
<meta name="viewport" content="width=device-width" initial-scale="1"  >
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/custom.css">
</head> 
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); // 이게 어떤부분인지..


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
	<br><br><br>
	
	
	<div class="container">
		<div class="col-lg-5">
		<div class="container">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tr>
						<td colspan="6" align="left">&nbsp;&nbsp;제목:&nbsp;&nbsp;<%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>

					<tr>
						<td colspan="3" align="left">&nbsp;&nbsp;<%= bbs.getUserID() %></td>
						<td colspan="3" align="right"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시" +  bbs.getBbsDate().substring(14,16) + "분"  %></td>
					</tr>
					
					<% 	
					String real = "C:\\Users\\leedh\\JSP\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\LDHPortFolio_Board\\img1";
					File viewFile = new File(real+"\\"+bbsID+"사진.jpg");
					if(viewFile.exists()){
					%>
					<tr>
						<td colspan="6"><br><br><img src = "../img1/<%=bbsID %>사진.jpg" border="300px" width="300px" height="300px"><br><br>
					</tr>
					<tr>
						<td colspan="6">
						<%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%><br><br>
						</td>
					<tr>
					<% 
					} else if(!viewFile.exists()) {
					%>
					<tr>
						<td colspan="6"><br><br><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%><br><br></td>
					</tr>
					<%
					}
					%>
					<td colspan="6" align="center">	<a href="bbs.jsp?boardID=<%=boardID %>" class="btn btn-default btn-pull" >목록</a>
					<%
						if(userID != null && userID.equals(bbs.getUserID())){
					%>
							<a href = "update.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID %>" class="btn btn-default btn-pull">수정</a>
							<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "deleteAction.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID %>" class="btn btn-default btn-pull">삭제</a>
					</td>
					</tr>
					<% } %>
			</table>		
		</div>
		</div>
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
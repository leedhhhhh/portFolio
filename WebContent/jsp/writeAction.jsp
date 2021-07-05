<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>실질적으로 글등록 시도를 처리해주는 페이지</title>
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
		String bbsTitle = multi.getParameter("bbsTitle");
		String bbsContent = multi.getParameter("bbsContent");
		bbs.setBbsTitle(bbsTitle);
		bbs.setBbsContent(bbsContent);
	
		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요한 작업입니다.')");
			script.println("location.href = 'loginPage.jsp'"); // 로그인 한 사람이 다시 로그인 하지 못하게
			script.println("</script>");
		}else{
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
 				script.println("alert('입력되지않은 사항이 있습니다.')");
				script.println("alert("+bbs.getBbsTitle()+")");
				script.println("history.back()");
				script.println("</script>");
			}else { 
				BbsDAO bbsDAO = new BbsDAO();
				int bbsID = bbsDAO.write(boardID,bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (bbsID == -1) { 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();

					if(fileName != null){
						File oldFile = new File(realFolder+"\\"+fileName);
						File newFile = new File(realFolder+"\\"+(bbsID-1)+"사진.jpg");
						oldFile.renameTo(newFile);
					}
					script.println("<script>");
					script.println("location.href= \'bbs.jsp?boardID="+boardID+"\'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
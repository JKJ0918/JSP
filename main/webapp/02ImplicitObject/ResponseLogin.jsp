<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>ResponseLogin.jsp : 로그인 정보를 파악</title>
</head>
<body>
<%
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pw");
	if(id.equalsIgnoreCase("kkw") && pw.equalsIgnoreCase("1234")){
		// id와 pw가 맞으면 
		response.sendRedirect("./ResponseWelcome.jsp"); // 성공시 이동하는 페이지
	}else{
		// id와 pw가 다르면
		request.getRequestDispatcher("./ResponseMain.jsp?loginErr=1").forward(request, response);
		// 실패한 메시지를 가지고 돌아가야 함  .forward(request, response);
	}
%>




</body>
</html>
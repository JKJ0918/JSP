<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ConnectionTest.jsp : jdbc연결 테스트용</title>
</head>
<body>

	<h2>jdbc 테스트1 - 생성자편</h2>
	<%
		JDBConnect jdbcConnect = new JDBConnect(); // 1단계, 2단계
		jdbcConnect.close(); // 5단계
	
	
	%>

</body>
</html>
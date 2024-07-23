<%@page import="common.Person"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>ApplicationMain.jsp : 톰캣이 가지고 있는 영역</title>
</head>
<body>
	<h2>Application 영역에 값 저장</h2>
	<%
		Map<String, Person> maps = new HashMap<String, Person>();
		maps.put("stu1", new Person("이현우", 2500));
		maps.put("stu2", new Person("함시은", 2350));
		application.setAttribute("Amaps", maps); // application 영역에 값 저장
		out.print("값 저장 완료");
	%>
</body>
</html>
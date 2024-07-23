<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//page 영역의 pageContext : 현재 페이지의 정보를 저장하고 관리하는 객체
    	pageContext.setAttribute("pageInt", 8282); // 페이지영역에 값 저장(int)
    	pageContext.setAttribute("pageStr", "엠비씨"); // 페이지영역에 값 저장(String)
    	pageContext.setAttribute("PersonDTO", new Person("홍길동", 12));
     %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>PageContextMain.jsp : 자바dto를 이용하여 객체 활용</title>
</head>
<body>
	<H2> pageContext 영역의 속성값 저장 </H2>
	<%
	int pageContextInt = (Integer)pageContext.getAttribute("pageInt");
	String pageContextStr = (String)pageContext.getAttribute("pageStr");
	Person person = (Person)pageContext.getAttribute("PersonDTO");
	/* 위에서 만든 setAttribute를 가져옴 */
	%>
	<hr>
	<h2> PageContext 영역의 속성값 출력</h2>
	<ul>
		<li>정수 객체 출력 : <%=pageContextInt %></li>
		<li>문자열 객체 출력 : <%=pageContextStr %></li>
		<li>DTO 객체 출력 : <%=person.getName() %>, <%=person.getAge() %></li>	
	</ul>
	
	
</body>
</html>
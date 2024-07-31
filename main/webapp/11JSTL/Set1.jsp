<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!-- *JSTL의 코어태그사용 -->
<!-- Core : 변수 선언, 조건문, 반복문, url 처리용으로 활용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- JSTL의 formating 태그 -->
<!-- formatting : 숫자, 날짜, 시간 포멧 지정(다국어) -->
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %><!-- JSTL의 xml 태그를 사용 -->
<!-- xml : 확장자가 xml인 데이터 파싱 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- function : 컬랙션, 문자열 처리 -> el에서 사용할 수 있는 메서드 제공  --> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!-- sql : 데이터베이스 연결 및 쿼리 실행 -> jdbc api를 사용하기 때문에 활용성이 없다. -->
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>JSTL 테스트</title></head>
<body>
	<!-- 변수 선언 -->
	<c:set var="directVar" value="100" />
	<c:set var="elVar" value="${ directVar mod 5 }" />
	<c:set var="expVar" value="<%= new Date() %>" />
	<c:set var="betweenVar"> 변수값 이렇게도 설정가능 </c:set>
	
	<!-- 변수 출력 -->
	<h4> EL을 이용한 출력 테스트 </h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar :  ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul>
	
	<!-- 객체 처리 테스트 : 생성 -->
	<h4>자바 빈즈 생성 - 생성자(Person) '작은 따옴표'</h4>
	<c:set var="personVal1" value='<%= new Person("엠비씨", 12) %>' scope="request" />
	<!-- Person personVal1 = new Person("엠비씨", 12) -->
	<!-- request.setAttribute("personVal1", personVal1)  -->
	
	<h5> 자바 빈즈 출력 - el</h5>
	<ul>
		<li> 이름 : ${ requestScope.personVal1.name }</li>
		<li> 나이 : ${ personVal1.age }</li>
	</ul>
	
	<h4> 자바 빈즈 생성할 때 - target, property 사용 "큰 따옴표"</h4>
	<c:set var="personVal2" value="<%= new Person() %>" scope="request" />
	<c:set target="${ personVal2 }" property="name" value="홍길동" />
	<c:set target="${ personVal2 }" property="age" value="22" />
		<h5> 자바 빈즈 출력 - el</h5>
	<ul>
		<li> 이름 : ${ personVal2.name }</li>
		<li> 나이 : ${ requestScope.personVal2.age }</li>
	</ul>
	
	<h5> 컬렉션(List)을 사용해 생성</h5>
	<%
		ArrayList<Person> pList = new ArrayList<>();
		pList.add(new Person("도날드", 8)); //  [0]
		pList.add(new Person("트럼프", 25)); // [1]
		/* 리스트에 2개의 객체 연결 */
	%>
	<c:set var="personList" value="<%= pList %>" scope="request" />
	<ul>
		<li> 이름 : ${ requestScope.personList[0].name }</li>
		<li> 나이 : ${ personList[1].age }</li>
	</ul>
	
	<h5> 컬렉션(Map)을 사용해 생성</h5>
	<%
		Map<String, Person> pMap = new HashMap<String, Person>();
		pMap.put("person1", new Person("도날드", 8));
		pMap.put("person2", new Person("트럼프", 25));
	%>
		<c:set var="personMap" value="<%= pMap %>" scope="request" />
	<ul>
		<li> 이름 : ${ requestScope.personMap.person2.name }</li>
		<li> 나이 : ${ personMap.person1.age }</li>
	</ul>
	
	<h5> 삭제 테스트 </h5>
	<c:remove var="personVal2" scope="request"/>
	<ul>
		<li> 이름 : ${ personVal2.name }</li>
		<li> 나이 : ${ requestScope.personVal2.age }</li>
	</ul>
	
	
</body>
</html>
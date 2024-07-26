<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("UserId") == null){
		//로그인 안함 - > 로그인 페이지로 넘김
		JSFunction.alertLocation("로그인 후 이용해주세요!!", "../06Session/LoginForm.jsp", out);
		return;
	}
%>		
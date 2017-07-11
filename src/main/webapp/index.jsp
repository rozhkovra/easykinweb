<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.auth.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<html>
<title>EasyKin, <%=DateUtil.formatWeek(new Date())%></title>
<head>
	<link rel="shortcut icon" href="icon/logo.ico" />
</head>
<body>
<jsp:include page="header.jsp"/>
<%
	String username = request.getParameter("username")!=null?String.valueOf(request.getParameter("username")):"";
	String password = request.getParameter("password")!=null?String.valueOf(request.getParameter("password")):"";
	if(!username.isEmpty() && !password.isEmpty())
		AuthManager.instance().signIn(username, password);

	if(!AuthManager.instance().isSignedIn()){
		if(!username.isEmpty() && !password.isEmpty()){
%><span style="color:red;">Не верно указан логин или пароль!</span>
<%
		}
%>
<jsp:include page="login.jsp"/>
<%
	}else{
%>
<jsp:include page="main.jsp"/>
<%
	}
%>
</body>
</html>
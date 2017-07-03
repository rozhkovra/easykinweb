<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.auth.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<html>
<title>EasyKinWeb, <%=DateUtil.formatWeek(new Date())%></title>
<body>
<h1>EasyKinWeb - семейный помошник (web-версия )</h1>
<%
	String username = request.getParameter("username")!=null?String.valueOf(request.getParameter("username")):"";
	String password = request.getParameter("password")!=null?String.valueOf(request.getParameter("password")):"";
	if(!username.isEmpty() && !password.isEmpty())
		AuthManager.instance().signIn(username, password);

	if(!AuthManager.instance().isSignedIn()){
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
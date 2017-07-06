<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%
	String username = request.getParameter("username")!=null?String.valueOf(request.getParameter("username")):"";
%>
<form method="POST" action="index.jsp">
<b>Логин</b> 	<input type="text" name="username" value="<%=username%>"/><br/>
<b>Пароль</b> 	<input type="password" name="password" value=""/><br/>
<input type="submit" value="Войти"/>
</form>

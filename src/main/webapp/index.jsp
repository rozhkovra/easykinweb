<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<html>
<title>EasyKinWeb, <%=DateUtil.formatWeek(new Date())%></title>
<body>
<h1>EasyKinWeb - семейный помошник (web-версия )</h1>
<jsp:include page="status.jsp"/>
<jsp:include page="priorities.jsp"/>
<jsp:include page="categories.jsp"/>
<jsp:include page="tasks.jsp"/>
</body>
</html>
<%@ page import="ru.rrozhkov.easykin.db.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.hsqldb.jdbc.*"%>
<%@ page pageEncoding="utf-8" %>
<html>
<body>
<h2>EasyKinWeb - семейный помошник (web-версия )</h2>
<%
	TaskHandler taskHandler = new TaskHandler();
%><table border="1">
<tr>
<th>№</th>
<th>Описание</th>
<th>Выполнить до</th>
<th>Приоритет</th>
<th>Категория</th>
<th>Дата</th>
</tr>
<%
	try{
		int i = 0;
		for(ITask task : taskHandler.select()){
%><tr>
<td><%=++i%></td>
<td><%=task.getName()%></td>
<td><%=DateUtil.format(task.getPlanDate())%></td>
<td><%=task.getPriority()%></td>
<td><%=task.getCategory().getName()%></td>
<td><%=DateUtil.format(task.getCreateDate())%></td>
</tr><%			
		}
	}catch(SQLException e){
		e.printStackTrace(new java.io.PrintWriter(out));
	}
%>
</table>
</body>
</html>

<%@ page import="ru.rrozhkov.easykin.db.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
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
			String color = "";
			String tdStyle = "height:50px;";
	        if(Status.CLOSE.equals(task.getStatus())){
	        	if(task.getCloseDate().getTime()>task.getPlanDate().getTime())
	        		color = "#7e7e7e";
	        	else
	        		color = "#44e53f";		        
	        }else{
	        	color = "#ffffff";
	        	if(Priority.IMPOTANT_FAST.equals(task.getPriority())
	        			|| Priority.IMPOTANT_NOFAST.equals(task.getPriority())){
	        		color = "#eec95e";
	        	}
	        }
	        if (Priority.IMPOTANT_FAST.equals(task.getPriority())){
	        	tdStyle+="font-size:20px;font-weight:bold;";
		    } else {  
		    	tdStyle+="font-size:15px;font-style:italic;";
		    }

%>
<tr bgcolor="<%=color%>">
<td style="<%=tdStyle%>"><%=++i%></td>
<td style="<%=tdStyle%>"><%=task.getName()%></td>
<td style="<%=tdStyle%>"><%=DateUtil.format(task.getPlanDate())%></td>
<td style="<%=tdStyle%>"><%=task.getPriority()%></td>
<td style="<%=tdStyle%>"><%=task.getCategory().getName()%></td>
<td style="<%=tdStyle%>"><%=DateUtil.format(task.getCreateDate())%></td>
</tr>
<%			
		}
	}catch(SQLException e){
		e.printStackTrace(new java.io.PrintWriter(out));
	}
%>
</table>
</body>
</html>

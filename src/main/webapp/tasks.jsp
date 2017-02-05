<%@ page import="ru.rrozhkov.easykin.db.impl.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="ru.rrozhkov.lib.filter.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.impl.filter.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.hsqldb.jdbc.*"%>
<%@ page pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8");%>
<h2>Задачи </h2>
<table border="1">
<tr>
<th>№</th>
<th>Описание</th>
<th>Выполнить до</th>
<th>Приоритет</th>
<th>Категория</th>
<th>Дата</th>
</tr>
<%
	TaskHandler taskHandler = new TaskHandler();
	try{
		int i = 0;
		Collection<ITask> tasks = taskHandler.select();
		int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
		if(categoryId!=-1 && categoryId!=9){			
			ICategory category = CategoryFactory.create(categoryId, "");
			tasks = FilterUtil.filter(tasks, TaskFilterFactory.createCategoryFilter(category));
		}
		int statusId = request.getParameter("statusId")!=null?Integer.valueOf(request.getParameter("statusId")):-1;
		if(statusId!=-1){			
			Status status = Status.status(statusId);
			tasks = FilterUtil.filter(tasks, TaskFilterFactory.createStatusFilter(status));
		}
		int priorityId = request.getParameter("priorityId")!=null?Integer.valueOf(request.getParameter("priorityId")):-1;
		if(priorityId!=-1){			
			Priority priority = Priority.priority(priorityId);
			tasks = FilterUtil.filter(tasks, TaskFilterFactory.createPriorityFilter(priority));
		}
		for(ITask task : tasks){
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
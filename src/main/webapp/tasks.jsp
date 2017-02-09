<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="ru.rrozhkov.lib.filter.util.*"%>
<%@ page import="ru.rrozhkov.lib.filter.*"%>
<%@ page import="ru.rrozhkov.lib.collection.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.impl.filter.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.hsqldb.jdbc.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
</br>
<table border="0" width="100%">
<tr>
<td style="font-size:30px;font-weight:bold;text-align:left;">Задачи</td>
<td style="font-size:30px;font-weight:bold;text-align:right;"><%=DateUtil.formatWeek(new Date())%></td>
</tr>
</table>
<table border="1" width="100%">
<tr>
<th>№</th>
<th>Описание</th>
<th>Выполнить до</th>
<th>Приоритет</th>
<th>Категория</th>
<th>Дата</th>
</tr>
<%
	EasyKinContext context = (EasyKinContext)session.getAttribute("easyKinContext");

	int i = 0;
	Collection<ITask> tasks = context.tasks();
	Collection<IFilter> filters = CollectionUtil.<IFilter>create();
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
	if(categoryId!=-1 && categoryId!=9){			
		ICategory category = CategoryFactory.create(categoryId, "");
		filters.add(TaskFilterFactory.createCategoryFilter(category));
	}
	int statusId = request.getParameter("statusId")!=null?Integer.valueOf(request.getParameter("statusId")):-1;
	if(statusId!=-1){			
		Status status = Status.status(statusId);
		filters.add(TaskFilterFactory.createStatusFilter(status));
	}
	int priorityId = request.getParameter("priorityId")!=null?Integer.valueOf(request.getParameter("priorityId")):-1;
	if(priorityId!=-1){			
		Priority priority = Priority.priority(priorityId);
		filters.add(TaskFilterFactory.createPriorityFilter(priority));
	}
	tasks = FilterUtil.filter(tasks, filters);
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
        String comments = "";
        for(IComment comment : task.comments()){
        	comments += comment.getText()+"|";
        }
%>
<tr bgcolor="<%=color%>">
<td style="<%=tdStyle%>"><%=++i%></td>
<td style="<%=tdStyle%>"><%=task.getName()%>(<%=task.getId()%>)<br/><span style="font-size:12px;"><%=comments%></span></td>
<td style="<%=tdStyle%>"><%=DateUtil.format(task.getPlanDate())%></td>
<td style="<%=tdStyle%>"><%=task.getPriority()%></td>
<td style="<%=tdStyle%>"><%=task.getCategory().getName()%></td>
<%
	if(new Date().getTime()>task.getPlanDate().getTime())
		tdStyle+="background-color:#7e7e7e;";
%>
<td style="<%=tdStyle%>"><%=DateUtil.format(task.getCreateDate())%></td>
</tr>
<%			
	}
%>
</table>
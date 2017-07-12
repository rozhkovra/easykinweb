<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.impl.filter.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="ru.rrozhkov.lib.filter.util.*"%>
<%@ page import="ru.rrozhkov.lib.filter.*"%>
<%@ page import="ru.rrozhkov.lib.collection.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.hsqldb.jdbc.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<div id="category">
<table border="0">
<%
	MasterDataContext context = (MasterDataContext)session.getAttribute("masterDataContext");

	int statusId = request.getParameter("statusId")!=null?Integer.valueOf(request.getParameter("statusId")):-1;
	int priorityId = request.getParameter("priorityId")!=null?Integer.valueOf(request.getParameter("priorityId")):-1;
	String urlParameters = "session="+session.getId()+"&statusId="+statusId+"&priorityId="+priorityId;
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;

	Collection<ITask> tasks = context.tasks();
	Collection<IFilter> filters = CollectionUtil.<IFilter>create();
    if(statusId!=-1){
    	Status status = Status.status(statusId);
    	filters.add(TaskFilterFactory.status(status));
    }
   	if(priorityId!=-1){
   		Priority priority = Priority.priority(priorityId);
   		filters.add(TaskFilterFactory.priority(priority));
   	}
   	tasks = FilterUtil.filter(tasks, filters);
	String tdStyle ="";
	if(categoryId!=-1){
		tdStyle = "font-size:20px;font-style:italic;";
	}else{
		tdStyle = "font-size:25px;font-weight:bold;";
	}
	%><tr><td style="<%=tdStyle%>"><a href="index.jsp?<%=urlParameters%>">Все</a> <b>(<%=tasks.size()%>)</b></td></tr><%
			

	for(ICategory category : context.categories()){
		int taskCount = 0;
		taskCount = FilterUtil.filter(tasks, TaskFilterFactory.category(category)).size();
        if (category.getId()==categoryId){
        	tdStyle="font-size:25px;font-weight:bold;";
	    } else {  
	    	tdStyle="font-size:20px;font-style:italic;";
	    }
        String urlParameters1=urlParameters+"&categoryId="+category.getId();
		%><tr><td style="<%=tdStyle%>">
		<a href="index.jsp?<%=urlParameters1%>"><%=category.getName()%></a> <b>(<%=taskCount%>)</b>
		</td></tr><%
	}
%>
</table>
</div>
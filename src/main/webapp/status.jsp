<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.easykin.model.task.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<table border="0">
<tr>
<%
	MasterDataContext context = (MasterDataContext)session.getAttribute("masterDataContext");
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
	int priorityId = request.getParameter("priorityId")!=null?Integer.valueOf(request.getParameter("priorityId")):-1;
	String urlParameters = "session="+session.getId()+"&categoryId="+categoryId+"&priorityId="+priorityId;
	int statusId = request.getParameter("statusId")!=null?Integer.valueOf(request.getParameter("statusId")):-1;
	String tdStyle ="";
	if(statusId!=-1){
		tdStyle = "font-size:20px;font-style:italic;";
	}else{
		tdStyle = "font-size:25px;font-weight:bold;";
	}
%><td style="<%=tdStyle%>"><a href="index.jsp?<%=urlParameters%>">Все</a></td><%	

	for(Status status : context.statuses()){
        if (status.equals(Status.status(statusId)) && statusId!=-1){
        	tdStyle="font-size:25px;font-weight:bold;";
	    } else {  
	    	tdStyle="font-size:20px;font-style:italic;";
	    }
        String urlParameters1=urlParameters+"&statusId="+Status.status(status);
%><td style="<%=tdStyle%>"><a href="index.jsp?<%=urlParameters1%>"><%=status%></a></td><%
	}
%>
</tr>
</table>
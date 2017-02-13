<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="ru.rrozhkov.easykin.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.hsqldb.jdbc.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<table border="0">
<tr>
<%
	MasterDataContext context = (MasterDataContext)session.getAttribute("masterDataContext");

	int statusId = request.getParameter("statusId")!=null?Integer.valueOf(request.getParameter("statusId")):-1;
	int priorityId = request.getParameter("priorityId")!=null?Integer.valueOf(request.getParameter("priorityId")):-1;
	String urlParameters = "session="+session.getId()+"&statusId="+statusId+"&priorityId="+priorityId;
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
	String tdStyle ="";
	if(categoryId!=-1){
		tdStyle = "font-size:20px;font-style:italic;";
	}else{
		tdStyle = "font-size:25px;font-weight:bold;";
	}
	%><td style="<%=tdStyle%>"><a href="index.jsp?<%=urlParameters%>">Все</a></td><%
			

	for(ICategory category : context.categories()){
        if (category.getId()==categoryId){
        	tdStyle="font-size:25px;font-weight:bold;";
	    } else {  
	    	tdStyle="font-size:20px;font-style:italic;";
	    }
        String urlParameters1=urlParameters+"&categoryId="+category.getId();
		%><td style="<%=tdStyle%>">
		<a href="index.jsp?<%=urlParameters1%>"><%=category.getName()%></a>
		</td><%
	}
%>
</tr>
</table>
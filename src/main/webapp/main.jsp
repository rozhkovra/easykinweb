<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%
	if(session.getAttribute("masterDataContext")==null){
		MasterDataContext context = new MasterDataContext();
		context.init();
		session.setAttribute("masterDataContext", context);
	}
%>
<jsp:include page="status.jsp"/>
<jsp:include page="priorities.jsp"/>
<jsp:include page="categories.jsp"/>
<%
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
	if (categoryId==5 || categoryId==6){
%><jsp:include page="payments.jsp"/><%
	}else{
%>
<jsp:include page="tasks.jsp"/>
<%}%>

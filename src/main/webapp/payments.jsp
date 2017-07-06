<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.fin.payment.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<table width="100%">
<tr>
<th>№</th>
<th>Категория</th>
<th>Назначение</th>
<th>Сумма</th>
<th>Дата</th>
</tr>
<%
	MasterDataContext context = (MasterDataContext)session.getAttribute("masterDataContext");
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;

	int i = 0;
	Collection<IPayment> payments = context.dataForCategory(categoryId);
	for(IPayment payment : payments){
		String tdStyle = "height:30px;font-size:20px;";
		String color = "";
		if(payment.getStatus().isFact()){
			color = "#44e53f";
		}else{
			color = "#eec95e";
		}
%>
<tr bgcolor="<%=color%>">
<td style="<%=tdStyle%>"><%=++i%></td>
<td style="<%=tdStyle%>"><%=payment.getCategory()%></td>
<td style="<%=tdStyle%>"><%=payment.getComment()%></td>
<td style="<%=tdStyle%>text-align:right;"><%=payment.getAmount()%></td>
<td style="<%=tdStyle%>text-align:center;"><%=DateUtil.format(payment.getDate())%></td>
</tr>
<%			
	}
%>
</table>
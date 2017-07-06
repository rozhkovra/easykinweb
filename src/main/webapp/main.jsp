<%@ page import="ru.rrozhkov.easykin.context.*"%>
<%@ page import="ru.rrozhkov.lib.util.*"%>
<%@ page import="ru.rrozhkov.easykin.model.category.*"%>
<%@ page import="java.util.*"%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
  <style type="text/css">
   .multiselect {
     width: 200px;
   }

   .selectBox {
     position: relative;
   }

   .selectBox select {
     width: 100%;
     font-weight: bold;
   }

   .overSelect {
     position: absolute;
     left: 0;
     right: 0;
     top: 0;
     bottom: 0;
   }

   #checkboxes {
     display: none;
     border: 1px #dadada solid;
   }

   #checkboxes label {
     display: block;
   }

   #checkboxes label:hover {
     background-color: #1e90ff;
   }
  </style>
  <script type="text/javascript">
      var expanded = false;

      function showCheckboxes() {
        var checkboxes = document.getElementById("checkboxes");
        if (!expanded) {
          checkboxes.style.display = "block";
          expanded = true;
        } else {
          checkboxes.style.display = "none";
          expanded = false;
        }
      }
  </script>
<table width="100%">
	<col width="200"/>
	<col width="200"/>
	<col/>
<%
	if(session.getAttribute("masterDataContext")==null){
		session.setAttribute("masterDataContext", new MasterDataContext());
	}
	MasterDataContext context = (MasterDataContext)session.getAttribute("masterDataContext");
    context.init();

%>
<tr height="50px">
<td colspan="2">
<jsp:include page="status.jsp"/>
</td>
<td align="right">
<jsp:include page="priorities_multiselect.jsp"/>
<jsp:include page="priorities.jsp"/>
</td>
</tr>
<tr>
<td valign="top">
<br/><br/>
<jsp:include page="categories.jsp"/>
</td>
<td colspan="2"  valign="top">
<%
	int categoryId = request.getParameter("categoryId")!=null?Integer.valueOf(request.getParameter("categoryId")):-1;
	if (categoryId==5 || categoryId==6){
%><jsp:include page="payments.jsp"/><%
	}else{
%>
<jsp:include page="tasks.jsp"/>
<%}%>
</td>
</tr>
</table>
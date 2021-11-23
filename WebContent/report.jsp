<%@page import="java.sql.ResultSet"%>
<%@page import="com.db.DBClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
DBClass db=new DBClass();
String id="(auto generated)",name="",btntext="Save";

if(request.getParameter("btnsave")!=null)
{
	id=request.getParameter("id");
	name=request.getParameter("name");
	
	
	if(request.getParameter("btnsave").equals("Save"))
	{
		db.execute("Insert into Company (CompanyName) values(?)", name);
		out.println("<script>alert('Product Company is Saved Successfully...');</script>");
	}
	else
	{
		db.execute("Update Company set CompanyName=? where CompanyId=?", name,id);
		out.println("<script>alert('Product Company is Updated Successfully...');</script>");
		id="(auto generated)";name="";
	}
}
else
{
	if(request.getParameter("did")!=null)
	{
		db.execute("delete from Company where CompanyId=?",request.getParameter("did"));
	}
	if(request.getParameter("eid")!=null)
	{
		id=request.getParameter("eid");
		ResultSet rs=db.getRows("select * from Company where CompanyId=?", id);
		if(rs.next())
		{
			name=rs.getString(2);
			btntext="Update";
			
		}
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Page</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
<link href="DataTables/datatables.css" rel="stylesheet"/>
<script src="js/jquery-3.1.1.js"></script>
<script src="DataTables/datatables.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery.validate.js"></script>
<script src="js/additional-methods.js"></script>
<script>
$(function(){
	$("#table1").DataTable();
	$("#form1").validate({
		rules:{
			name:{
				required:true
			}
			
		},
		messages:{
			name:{
				required:"Company Name is Required"
			}
		}
	});
});
</script>
<style>
label.error{
color:red;
font-weight:bold;
}
</style>
</head>
<body>
<div class="container" style="margin-top:50px">
<form name="form1" method="post" id="form1">

<div class="panel panel-primary">
<div class="panel-heading">
<h3 class="panel-title">Company Entry Form</h3>
</div>

<div class="panel-body">
<div class="form-group"> <!--  form row -->
Company ID
<input type="text" name="id" class="form-control" value="<%=id%>" readonly="readonly"/>
</div>

<div class="form-group"> <!--  form row -->
Company Name
<input type="text" name="name" class="form-control" autofocus value="<%=name%>"/>
</div>

<div class="form-group"> <!--  form row -->
<input type="submit" name="btnsave" value="<%=btntext%>" class="btn btn-primary"/>
<a href="#" onclick="window.location='Company.jsp';" class="btn btn-success">Reset</a>
<a href="report.jsp?report=Company" target="_blank"  class="btn btn-success">Print</a>
</div>
</div>

</div>
</form>

<table class="table table-bordered table-hover" id="table1">
<thead>
<tr>
<td>Company ID</td>
<td>Company Name</td>
<td>Actions/Operations</td>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select * from Company");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td>
<a href="?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
<a href="?did=<%=rs.getString(1) %>" onclick="return confirm('Do you want to remove Company?');" class="btn btn-danger">Delete</a>
</td>
</tr>
<%
}
%>
</tbody>

</table>
</div>

</body>
</html>
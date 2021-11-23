<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@ include file="aheader.jsp" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!--  <%
String msg="",id="",name="",category="",photo="",description="",startdt="",enddt="",rollread="",rollfocus="",btntext="Save";




if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

	
	if(mreq.getParameter("btnreset")!=null)
	{
		response.sendRedirect("PostAd.jsp");
	}
	if(mreq.getParameter("btnsave")!=null)
	{		
		id=mreq.getParameter("id");
		name=mreq.getParameter("name");
		category=mreq.getParameter("category");
		photo=mreq.getParameter("photo");
		description=mreq.getParameter("description");
		startdt=mreq.getParameter("startdt");
		enddt=mreq.getParameter("enddt");
		
		UploadFile ufile=(UploadFile) ht.get("file");
		photo=ufile.getFileName();
		Hashtable ht=mreq.getFiles();
		
		UploadBean ub=new UploadBean();
		ub.setFolderstore("/");
		ub.store(mreq,"file");
		
		if(mreq.getParameter("btnsave").equals("Save"))
		{
		db.execute("Insert into postad(name,category,Adimg,Descr,startdt,enddt) values(?,?,?,?,?,?)",name,category,photo,description,startdt,enddt);
		out.println("<script> showMsg('Ad Saved Successfully');</script>");
		}
		else
		{
			if(photo!=null && !photo.equals(""))
				db.execute("Update postad set name=?,category=?,Adimg=?,Descr=?,startdt=?,enddt=? where ADid=?",name,category,photo,description,startdt,enddt,id);
			else
				db.execute("Update postad set name=? where ADId=?",name,id);
			out.println("<script> showMsg('Ad Updated Successfully');</script>");
		}
		
		
	}
	
}
else
{
	if(request.getParameter("eid")!=null)
	{
		ResultSet rs=db.getRows("select * from postad where ADId=?",request.getParameter("eid"));
		if(rs.next())
		{
			id=rs.getString(1);
			name=rs.getString(2);
			category=rs.getString(3);
			photo=rs.getString(4);
			description=rs.getString(5);
			startdt=rs.getString(6);
			enddt=rs.getString(7);
			btntext="Update";
			rollread="readonly";
			rollfocus="";
			
			
		}
		
	}
	if(request.getParameter("did")!=null)
	{
		db.execute("delete from postad where ADId=?",request.getParameter("did"));
		out.println("<script> showMsg('Ad Deleted Successfully');</script>");
	}
}
	
%> -->
<br>
<br>
<br>
<br>
<br>
<br>
<div>
<style>
label.error
{
color:red;
font-weight:bold;
}
</style>

<div class="container">
      <div class="row">
        <div class="span6 offset2">
<h3>Product Form</h3>
<form name="form1" class="form-main" method="post" id="form1">

<div class="form-group">
Advertisement id
<input type="text" name="id" readonly="readonly" placeholder=" Auto " class="form-control" value="<%=id%>" title="Enter Product Code" style="border:1px solid black"   />
</div>

<div class="form-group">
Product Name
<input type="text" name="name" placeholder="Product Name" class="form-control" value="<%=name%>" title="Enter Product Name" style="border:1px solid black" <%=rollread%> <%=rollfocus%>/>
</div>

<div class="form-group">
category
<input type="text" name="category" placeholder="Product category" class="form-control" value="<%=category%>" title="Enter Product Version" style="border:1px solid black"/>
</div>
<div class="form-group">
image
<input type="file" name="photo" placeholder="Product category" class="form-control" value="<%=photo%>" title="Enter Product Version" style="border:1px solid black"/>
</div>
<div class="form-group">
description
<input type="text" name="description" placeholder="Product category" class="form-control" value="<%=description%>" title="Enter Product Version" style="border:1px solid black"/>
</div>
<div class="form-group">
start
<input type="date" name="startdt" placeholder="Product category" class="form-control" value="<%=startdt%>" title="Enter Product Version" style="border:1px solid black"/>
</div>
<div class="form-group">
end
<input type="date" name="enddt" placeholder="Product category" class="form-control" value="<%=enddt%>" title="Enter Product Version" style="border:1px solid black"/>
</div>
<button type="submit" name="btnsave" id="send" value="<%=btn1%>" class="btn btn-success" style="margin-left:5px"><%=btntext%></button>
<button type="submit" name="btnreset" class="btn btn-danger" >Reset</button>
 

<br>
<%

if(!msg.equals(""))
{
%>
<div class="alert alert-success alert-dismissible">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<%=msg%>
</div>
<%
}
%>
</form>
</div>
</div>

<table class="table table-bordered" id="table1">
<thead>
<tr>
<th>Ad ID</th>
<th>AD Name</th>
<th>Category</th>
<th>Image</th>
<th>Description</th>
<th>start date</th>
<th>end date</th>
</tr>
</thead>
<tbody>
<%

ResultSet rs=db.getRows("select * from postad");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getString(5) %></td>
<td><%=rs.getString(6) %></td>
<td><%=rs.getString(7) %></td>

<td>
<a href="?eid=<%=rs.getString(1)%>" class="btn btn-info">Edit</a>
<a href="?did=<%=rs.getString(1)%>" class="btn btn-danger" onclick="return confirm('Do you want to delete selected row?');">Delete</a>
</td>
</tr>
<%
}
%>

</tbody>
</table>
</div>


<%@ include file="afooter.jsp" %>


$(function(){
	$("#table1").DataTable();
	$("#form1").validate({
		rules:{
			code:{
				required:true,
			},
			name:{
				required:true,
				pattern:/^[a-zA-Z ]+$/  
			},
			version:{
				required:true
			}
		},
		messages:{
			code:{
				required:"Product Code is Required"
			},
			name:{
				required:"Name is Required",
				pattern:"Only chars and spaces allowed in name"
			},
			version:{
				required:"Version is Required"				
			}
		}
	});
});
  
</script>

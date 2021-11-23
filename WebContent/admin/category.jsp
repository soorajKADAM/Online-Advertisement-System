<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.db.DBClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
    pageEncoding="ISO-8859-1"%>
    <%@ include file="aheader.jsp" %>
<%
String photo="", btntext="save",id="",name="",price="";
String path=request.getRealPath("/admin/catuploads/");

if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

	if(mreq.getParameter("btn2")!=null)
	{	
		response.sendRedirect("category.jsp");
	}
	if(mreq.getParameter("btn1")!=null)
	{	
		 id=mreq.getParameter("id");
		 name=mreq.getParameter("name");
		 price=mreq.getParameter("price");
		
		
		Hashtable ht=mreq.getFiles();
		UploadFile ufile=(UploadFile) ht.get("photo");
		photo=ufile.getFileName();
		UploadBean ub=new UploadBean();
		ub.setFolderstore(path);
		ub.store(mreq,"photo");
		
if(mreq.getParameter("btn1").equals("save"))
{
	
	
	db.execute("Insert into Category (Cat_name,price,img) values(?,?,?)", name,price,photo);
	out.println("<script>alert('Product Category is Saved Successfully...');</script>");
}
else
{
	 
	
	if(photo!=null && !photo.equals(""))
		db.execute("Update Category set Cat_name=?,price=?,img=? where Cat_id=?",name,price,photo,id);
	else
		db.execute("Update Category set Cat_name=?,price=? where Cat_id=?",name,price,id);
	out.println("<script> showMsg('Category Updated Successfully');</script>");
		

}
	}
}
else
{
	if(request.getParameter("eid")!=null)
	{
		ResultSet rs=db.getRows("select * from Category where Cat_Id=?",request.getParameter("eid"));
		if(rs.next())
		{
		  id=rs.getString(1);
		 name=rs.getString(2);
		 price=rs.getString(3);
			photo=rs.getString(4);
			btntext="Update";
		}
		
	}
	if(request.getParameter("did")!=null)
	{
		db.execute("delete from Category where CategoryId=?",request.getParameter("did"));
		out.println("<script> showMsg('Category Deleted Successfully');</script>");
	}
}
	


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Category Page</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body>
<div class="container" style="margin-top:250px">
<form name="form1" method="post" enctype="multipart/form-data">

<div class="panel panel-primary">
<div class="panel-heading">
<h3 class="panel-title">Category Entry Form</h3>
</div>

<div class="panel-body">
<div class="form-group"> <!--  form row -->
Category ID
<input type="text" name="id" class="form-control rounded" value="<%=id%>" readonly="readonly"/>
</div>

<div class="form-group"> <!--  form row -->
Category Name
<input type="text" name="name" class="form-control rounded" value="<%=name%>" />
</div>
<div class="form-group"> <!--  form row -->
Category Price
<input type="number" name="price" class="form-control rounded" value="<%=price%>" />
</div>
<div class="form-group"> <!--  form row -->
Category Image
<input type="file" name="photo" class="form-control rounded" value="<%=photo%>"/>
</div>

<div>
						   <button type="submit" name="btn1" style="display:inline" class="btn btn-primary" value="<%=btntext %>"><%=btntext %></button>
						   <button type="submit" name="btn2" style="display:inline" value="Reset" formnovalidate>Reset</button>
						   </div>
</div>

</div>
</form>

<table class="table table-bordered table-hover">
<thead>
<tr>
<td>Category ID</td>
<td>Category Name</td>
<td>Category Price</td>
<td>Category Image</td>
<td>Actions/Operations</td>
</tr>
</thead>
<tbody>
<%
ResultSet rs=db.getRows("select * from Category");
while(rs.next())
{
%>
<tr>
<td><%=rs.getString(1) %></td>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><img src="catuploads/<%=rs.getString(4) %>" width="50" height="50" alt="NA" class="img-circle"/></td>
						


<td>
<a href="?eid=<%=rs.getString(1) %>" class="btn btn-info">Edit</a>
<a href="?did=<%=rs.getString(2) %>" class="btn btn-danger">Delete</a>
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
<%@ include file="afooter.jsp" %>
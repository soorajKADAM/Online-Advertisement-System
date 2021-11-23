<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="shophead.jsp" %>
<script>
$(function(){ //or $(document).ready(function(){})
	$("#table1").DataTable();
	
	$("#form1").validate({
		rules:{
			name:{
				required:true
			}
		},
		messages:{
			name:{
				required:"Name is Required"
			}
		}
		
	});
});
</script>
<% 

String catid="",name="",photo="",btntext="Save";

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
		catid=mreq.getParameter("catid");
		name=mreq.getParameter("name");
		Hashtable ht=mreq.getFiles();
		UploadFile ufile=(UploadFile) ht.get("file");
		photo=ufile.getFileName();
		
		UploadBean ub=new UploadBean();
		ub.setFolderstore(path);
		ub.store(mreq,"file");
		
		if(mreq.getParameter("btn1").equals("Save"))
		{
		db.execute("Insert into Category (CategoryName,CategoryImage) values(?,?)", name,photo);
		out.println("<script> showMsg('Category Saved Successfully');</script>");
		}
		else
		{
			if(photo!=null && !photo.equals(""))
				db.execute("Update Category set CategoryName=?,CategoryImage=? where CategoryId=?",name,photo, catid);
			else
				db.execute("Update Category set CategoryName=? where CategoryId=?",name,catid);
			out.println("<script> showMsg('Category Updated Successfully');</script>");
		}
		
		
	}
	
}
else
{
	if(request.getParameter("eid")!=null)
	{
		ResultSet rs=db.getRows("select * from Category where CategoryId=?",request.getParameter("eid"));
		if(rs.next())
		{
			catid=rs.getString(1);
			name=rs.getString(2);
			photo=rs.getString(3);
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

	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-7 col-sm-offset-1">
					<div class="login-form"><!--login form-->
						<h2>Manage Categories</h2>
						<form method="post" name="form1" id="form1" enctype="multipart/form-data">
						   
						   <input type="hidden" name="catid" value="<%=catid%>"/>
						   Category Name							
						   <input type="text" name="name" value="<%=name%>"/><br>
						   Upload Photo &nbsp;
						   <input type="file" name="file"  /><br>
						   <img src="catuploads/<%=photo %>" width="50" height="50" alt="NA" class="img-circle"/>						
						   
						   <div>
						   <button type="submit" name="btn1" style="display:inline" class="btn btn-primary" value="<%=btntext %>"><%=btntext %></button>
						   <button type="submit" name="btn2" style="display:inline" value="Reset" formnovalidate>Reset</button>
						   </div>
						</form>
						<br/>
						<table id="table1" class="table table-bordered">
						<thead>
						<tr>
						<td>CategoryID</td>
						<td>Category Name</td>
						<td>Category Image</td>
						<td>Actions</td>
						</tr>
						</thead>
						<tbody>
						<%
						ResultSet rs1=db.getRows("select * from category");
						while(rs1.next())
						{
						%>
						<tr>
						<td><%=rs1.getString(1) %></td>
						<td><%=rs1.getString(2) %></td>
						<td><img src="catuploads/<%=rs1.getString(3) %>" width="50" height="50" alt="NA" class="img-circle"/></td>
						<td>
						<a href="?eid=<%=rs1.getString(1) %>" class="btn btn-primary">Edit</a>&nbsp;
						<a href="?did=<%=rs1.getString(1) %>" class="btn btn-primary">Delete</a>
						</td>
						</tr>
						
						<%
						}
						%>
						</tbody>
						</table>
					</div><!--/login form-->
				</div>
				
				
			</div>
		</div>
	</section><!--/form-->
	
<%@ include file="shopfoot.jsp" %>	
	
<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="aheader.jsp" %>
<script>
$(function(){ //or $(document).ready(function(){})
	$("#table1").DataTable();
	
	$("#form1").validate({
		rules:{
			name:{
				required:true
			},
			catid:{
				required:true
			}
		},
		
		messages:{
			name:{
				required:"Name is Required"
			},
			catid:{
				required:"Please select Category Name"
			}
		}
		
	});
});
</script>
<%
String prodid="",subcatid="",name="", desc="", price="", brand="", photo="",btntext="Save";

String path=request.getRealPath("/admin/Productuploads/");

if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

	if(mreq.getParameter("btn2")!=null)
	{	
		response.sendRedirect("product.jsp");
	}
	if(mreq.getParameter("btn1")!=null)
	{	
		prodid=mreq.getParameter("prodid");
		name=mreq.getParameter("name");
		subcatid=mreq.getParameter("subcatid");
		desc=mreq.getParameter("desc");
		price=mreq.getParameter("price");
		brand=mreq.getParameter("brand");
		
		Hashtable ht=mreq.getFiles();
		UploadFile ufile=(UploadFile) ht.get("file");
		photo=ufile.getFileName();
		
		UploadBean ub=new UploadBean();
		ub.setFolderstore(path);
		ub.store(mreq,"file");
		
		if(mreq.getParameter("btn1").equals("Save"))
		{
		db.execute("Insert into Product (ProductName,SubCategoryId,ProductDescription,Price,Brand,ProductImage) values(?,?,?,?,?,?)", name,subcatid,desc,price,brand,photo);
		out.println("<script> showMsg('Product Saved Successfully');</script>");
		}
		else
		{
			if(photo!=null && !photo.equals(""))
				db.execute("Update Product set ProductName=?,SubCategoryId=?,ProductDescription=?,Price=?,Brand=?,ProductImage=? where ProductId=?",name,subcatid,desc,price,brand,photo,prodid);
			else
				db.execute("Update Product set ProductName=?,SubCategoryId=?,ProductDescription=?,Price=?,Brand=? where ProductId=?",name,subcatid,desc,price,brand,prodid);
			out.println("<script> showMsg('Product Updated Successfully');</script>");
		}
		
		
	}
	
}
else
{
	if(request.getParameter("eid")!=null)
	{
		ResultSet rs=db.getRows("select * from Product where ProductId=?",request.getParameter("eid"));
		if(rs.next())
		{
			prodid=rs.getString(1);
			name=rs.getString(2);
			subcatid=rs.getString(3);			
			desc=rs.getString(4);
			price=rs.getString(5);
			brand=rs.getString(6);
			photo=rs.getString(7);
			btntext="Update";
		}
		
	}
	if(request.getParameter("did")!=null)
	{
		db.execute("delete from Product where ProductId=?",request.getParameter("did"));
		out.println("<script> showMsg('Product Deleted Successfully');</script>");
	}
}
	

%>	
<br>
<br>
<br>
<br>
<br>
<br>
<br>
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-sm-7 col-sm-offset-1">
					<div class="login-form"><!--login form-->
						<h2>Manage Products</h2>
						<form method="post" name="form1" id="form1" enctype="multipart/form-data">
						   
						   <input type="hidden" name="prodid" value="<%=prodid%>"/>
						   Sub Category							
						   <select name="subcatid">
						   <option value="">-- Select Sub Category --</option>
						   <%
						   ResultSet rs2=db.getRows("select * from Subcategory");
						   while(rs2.next())
						   {
						   %>
						   <option <%=subcatid.equals(rs2.getString(1))?"selected":"" %> value="<%=rs2.getString(1)%>"><%=rs2.getString(2) %></option>
						   <%
						   }
						   %>
						   </select><br>
						   Product Name							
						   <input type="text" name="name" value="<%=name%>"/ autocomplete="off"><br>
						   Product Description							
						   <textarea name="desc" rows="3" cols="50"><%=desc %></textarea>
						   Product price
						   <input type="text" name="price" value="<%=price%>">
						   Brand
						   <input type="text" name="brand" value="<%=brand%>">
						   
						   Upload Product Photo &nbsp;
						   <input type="file" name="file"  /><br>
						   <img src="Productuploads/<%=photo %>" width="50" height="50" alt="NA" class="img-circle"/>						
						   
						   <div>
						   <button type="submit" name="btn1" style="display:inline" class="btn btn-primary" value="<%=btntext %>"><%=btntext %></button>
						   <button type="submit" name="btn2" style="display:inline" value="Reset" formnovalidate>Reset</button>
						   </div>
						</form>
						</div><!--/login form-->
						</div>
						<br/><br/><br>
						<table id="table1" class="table table-bordered">
						<thead>
						<tr>
						<td>Pro Id</td>
						<td>Pro Name</td>
						<td>SubcatName</td>
						<td>CatName</td>
						<td>Pro desc</td>
						<td>Price</td>
						<td>Brand</td>
						<td>ProImage</td>
						<td>Actions</td>
						</tr>
						</thead>
						<tbody>
						<%
						ResultSet rs1=db.getRows("select * from ProductView");
						while(rs1.next())
						{
						%>
						<tr>
						<td><%=rs1.getString(1) %></td>
						<td><%=rs1.getString(2) %></td>
						<td><%=rs1.getString(4) %></td>
						<td><%=rs1.getString(6) %></td>
						<td><%=rs1.getString(7) %></td>
						<td><%=rs1.getString(8) %></td>
						<td><%=rs1.getString(9) %></td>
						<td><img src="Productuploads/<%=rs1.getString(10) %>" width="50" height="50" alt="NA" class="img-circle"/></td>
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
					
				
				
				
			</div>
		</div>
	</section><!--/form-->
	
<%@ include file="afooter.jsp" %>	

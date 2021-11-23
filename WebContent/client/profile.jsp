<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="cheader.jsp" %>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			EmailId:{
				required:true,
				email:true,
				remote:"validuser.jsp"
				},
				PAddress:{
				required:true
				},
				SAddress:{
				required:true
				},
				PAddress:{
				required:true
				},
				Gender:{
					required:true
			   },
			   Birthdate:{
					required:true
				},
				 Hobbies:{
					required:true
				},
				Photo:{
					required:true
				}
				},
	
		messages:{
			EmailId:{
				required:"please Enter valid emailId ",
				pattern:"Name allows only chars and spaces"
				},
				PAddress:{
				required:"Required permanent Address",
				},
				SAddress:{
				required:"Required shipping Address",
				},
				Password:{
				required:"please Enter password",
				},
				Gender:{
					required:"Select Gender",
			   },
			   Birthdate:{
					required:"Enter your birthDate",
				},
				 Hobbies:{
					required:"Select hobbies",
				}
		}	
	});
});

</script>
<%!
//JSP Declaration
String hobbies="";
boolean existsHobbies(String hb)
{
	return hobbies.contains(hb);
}
%>
<%
String paddress="",saddress="",email="",gender="",bdate="",photo="";
email=session.getAttribute("user").toString();
String path=request.getRealPath("/client/uploads/");
if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

if(mreq.getParameter("btn")!=null)
{		
	paddress=mreq.getParameter("paddress");
	saddress=mreq.getParameter("saddress");
	gender=mreq.getParameter("gender");
	bdate=mreq.getParameter("bdate");
	String h[]=mreq.getParameterValues("hobbies");	
	for(String x : h)
	{
		hobbies=hobbies+x+",";
	}
	Hashtable ht=mreq.getFiles();
	UploadFile ufile=(UploadFile) ht.get("file");
	photo=ufile.getFileName();
	
	UploadBean ub=new UploadBean();
	ub.setFolderstore(path);
	ub.store(mreq,"file");
	
	try
	{
		db.execute("Insert into ClientProfile2 values(?,?,?,?,?,?,?)", email,paddress,saddress,gender,bdate,hobbies,photo);
	}
	catch(Exception ex)
	{
		if(photo!=null && !photo.equals(""))
			db.execute("Update ClientProfile2 set PAddress=?,SAddress=?,Gender=?,bdate=?,Hobbies=?,photo=? where EmailID=?",paddress,saddress,gender,bdate,hobbies,photo, email);
		else
			db.execute("Update ClientProfile2 set PAddress=?,SAddress=?,Gender=?,bdate=?,Hobbies=? where EmailID=?",paddress,saddress,gender,bdate,hobbies, email);
	}
	
	
	out.println("<script> showMsg('Profile Updated');</script>");
}
	
}
	ResultSet rs=db.getRows("select * from clientprofile2 where EmailId=?",email);
	if(rs.next())
	{
		paddress=rs.getString(2);
		saddress=rs.getString(3);
		gender=rs.getString(4);
		bdate=rs.getString(5);
		hobbies=rs.getString(6);
		photo=rs.getString(7);
	}

%>	
<br>
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
				<div class="col-sm-4 col-sm-offset-3">
					<div class="login-form"><!--login form-->
						<h2>Manage your Profile</h2>
						<form method="post" name="form1" id="form1" enctype="multipart/form-data">
						   <img src="uploads/<%=photo %>" width="150" height="150" alt="NA" class="img-circle"/><br>
						   Email ID							
							<input type="email" name="email" readonly="readonly"  value="<%=email%>"/>
							Permanenent Address
							<textarea name="paddress" placeholder="Permanent Address" > <%=paddress%></textarea>
							Shipping Address
							<textarea name="saddress" placeholder="Shipping Address" > <%=saddress%></textarea>
							Gender
							<input type="radio" name="gender" value="Male" <%=gender.equals("Male")?"checked":"" %>>Male

							<input type="radio" name="gender" value="Female" <%=gender.equals("Female")?"checked":"" %> style="display:inline">Female
							<br>
							BirthDate
							<input type="date" name="bdate"  value="<%=bdate%>"/>
							Select one or more Hobbies
							<select name="hobbies" size="4" multiple>							
							<option value="Cricket"  <%=existsHobbies("Cricket")?"selected":"" %>>Cricket</option>
							<option value="Reading" <%=existsHobbies("Reading")?"selected":"" %>>Reading</option>
							<option value="Movies" <%=existsHobbies("Movies")?"selected":"" %>>Movies</option>
							<option value="Singing" <%=existsHobbies("Singing")?"selected":"" %>>Singing</option>
							<option value="Other" <%=existsHobbies("Other")?"selected":"" %>>Other</option>
							</select>
							Upload Photo &nbsp;
							<input type="file" name="file"  />							
							<button type="submit" name="btn" class="btn btn-default" value="Submit">Update Profile</button>
						</form>
					</div><!--/login form-->
				</div>
				
				
			</div>
		</div>
	</section><!--/form-->
	
<%@ include file="cfooter.jsp" %>	
	
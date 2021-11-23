<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp" %>
<%!String hobbies="";
boolean existsHobbies(String hb)
{
	return hobbies.contains(hb);
}
%>
<%
String first_name="",last_name="",phone="",mobile="",email="",location="",Password="",
Password2="",DOB="",gender="",photo="";
email=session.getAttribute("user").toString();
String path=request.getRealPath("/client/uploads/");
if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

if(mreq.getParameter("btn")!=null)
{		
	first_name=mreq.getParameter("first_name");
	last_name=mreq.getParameter("last_name");
	gender=mreq.getParameter("gender");
	phone=mreq.getParameter("phone");
	phone=mreq.getParameter("mobile");
	email=mreq.getParameter("email");
	location=mreq.getParameter("location");
	Password=mreq.getParameter("Password");
	Password2=mreq.getParameter("Password2");
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
		db.execute("Insert into ClientProfile values(?,?,?,?,?,?,?,?,?,?)",first_name,last_name,phone,mobile,email,Password,Password2,location,DOB,hobbies,gender,photo);
	}
	catch(Exception ex)
	{
		if(photo!=null && !photo.equals(""))
			db.execute("Update ClientProfile set first_name=?,last_name=?,phone=?,mobile=?,Password=?,Password2=?,location=?,DOB=?,hobbies=?,gender=?,photo=? where email=?",first_name,last_name,phone,mobile,Password,Password2,location,DOB,hobbies,gender,photo,email);
		else
			db.execute("Update ClientProfile set first_name=?,last_name=?,phone=?,mobile=?,Password=?,Password2=?,location=?,DOB=?,hobbies=?,gender=? where email=?",first_name,last_name,phone,mobile,Password,Password2,location,DOB,hobbies,gender,email);
	}
	
	
	out.println("<script> showMsg('Profile Updated');</script>");
}
	
}
	ResultSet rs=db.getRows("select * from clientprofile where email=?",email);
	if(rs.next())
	{
		first_name=rs.getString(1);
		last_name=rs.getString(2);
		gender=rs.getString(3);
		phone=rs.getString(4);
		mobile=rs.getString(5);
		email=rs.getString(6);
		location=rs.getString(7);
		Password=rs.getString(8);
		Password2=rs.getString(9);
		hobbies=rs.getString(10);
		photo=rs.getString(11);
	}

%>	
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>


<hr>
<div class="container bootstrap snippet">
    <div class="row">
  		<div class="col-sm-10"><h1>User name</h1></div>
    	<div class="col-sm-2"><a href="/users" class="pull-right"><img title="profile image" class="img-circle img-responsive" src="http://www.gravatar.com/avatar/28fd20ccec6865e2d5f0e1f4446eb7bf?s=100"></a></div>
    </div>
    <div class="row">
  		<div class="col-sm-3"><!--left col-->
              

      <div class="text-center">
        <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail" alt="avatar">
        <h6>Upload a different photo...</h6>
        <input type="file" name="photo" class="text-center center-block file-upload">
      </div></hr><br>

               
          
        </div><!--/col-3-->
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
                <li><a data-toggle="tab" href="#messages">Change Password</a></li>
                <li><a data-toggle="tab" href="#settings">Personal Info</a></li>
              </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                  <form class="form" method="post" id="registrationForm">
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="first_name"><h4>First name</h4></label>
                              <input type="text" class="form-control" name="first_name" id="first_name" value="<%=first_name%>" placeholder="first name" title="enter your first name if any.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for="last_name"><h4>Last name</h4></label>
                              <input type="text" class="form-control" name="last_name" id="last_name" value="<%=last_name%>" placeholder="last name" title="enter your last name if any.">
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="phone"><h4>Phone</h4></label>
                              <input type="text" class="form-control" name="phone" id="phone" value="<%=phone%>" placeholder="enter phone" title="enter your phone number if any.">
                          </div>
                      </div>
          
                      <div class="form-group">
                          <div class="col-xs-6">
                             <label for="mobile"><h4>Mobile</h4></label>
                              <input type="text" class="form-control" name="mobile" id="mobile" value="<%=mobile%>" placeholder="enter mobile number" title="enter your mobile number if any.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="email"><h4>Email</h4></label>
                              <input type="email" class="form-control" name="email" readonly="readonly"  id="email" value="<%=email%>.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="email"><h4>Location</h4></label>
                              <input type="text" class="form-control" id="location" value="<%=location%>" placeholder="somewhere" title="enter a location">
                          </div>
                      </div>
                     
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-lg btn-success" type="submit" name="next" href="#messages"><i class="glyphicon glyphicon-ok-sign"></i>next</button>
                               	<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat"></i> Reset</button>
                            </div>
                      </div>
              	</form>
              
              <hr>
              
             </div><!--/tab-pane-->
             <div class="tab-pane" id="messages">
               
               <h2></h2>
               
               <hr>
                  <form class="form" action="##" method="post" id="registrationForm">
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="password"><h4>Password</h4></label>
                              <input type="password" class="form-control" name="password" id="password" value="<%=Password%>"placeholder="password" title="enter your password.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for="password2"><h4>Verify</h4></label>
                              <input type="password" class="form-control" name="password2" id="password2" value="<%=Password2%>" placeholder="password2" title="enter your password2.">
                          </div>
                      </div>
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-lg btn-success" type="submit" name="next" href="#messages"><i class="glyphicon glyphicon-ok-sign"></i>next</button>
                               	<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat"></i> Reset</button>
                            </div>
                      </div>
              	</form>
               
             </div><!--/tab-pane-->
             <div class="tab-pane" id="settings">
            		
               	
                  <hr>
                  <form class="form" action="##" method="post" id="registrationForm">
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="first_name"><h4>Date Of Birth</h4></label>
                              <input type="date" class="form-control" name="DOB" id="DOB" value="<%=DOB%>"placeholder="Date of Birth" title="enter your Date Of Birth.">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6"><h4>Select one or more Hobbies</h4></label>
                          
                             
                              
                              <br>
                              
							<select name="hobbies" class="form-control" value="<%=hobbies%>"size="4" multiple><br>							
							<option value="Cricket"  >Cricket</option>
							<option value="Reading" >Reading</option>
							<option value="Movies" >Movies</option>
							<option value="Singing" >Singing</option>
							<option value="Other" >Other</option>
							</select>
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                          <label for="mobile"><h4>Gender</h4></label>
                              <br>
							<input type="radio" name="gender" value="<%=gender%>" >Male

							<input type="radio" name="gender"value="<%=gender%>" >Female
							<br>
                          </div>
                      </div>
          
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-lg btn-success pull-right" type="submit" name="btn"><i class="glyphicon glyphicon-ok-sign"></i> Save</button>
                               	<!--<button class="btn btn-lg" type="reset"><i class="glyphicon glyphicon-repeat"></i> Reset</button>-->
                            </div>
                      </div>
              	</form>
              </div>
               
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
    </div><!--/row-->
                                                      
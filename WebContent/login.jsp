
<%@include file="lheader.jsp" %>
<%@page import="com.db.DBClass"%>

<%@page import="java.sql.ResultSet"%>
     <script>
function showMsg(msg){
	bootbox.alert(msg);
}
$(document).ready(function(){
	
});
</script>
    
<script>
$(document).ready(function(){
	$("#form2").validate({
		rules:{
			name:{
				required:true,
				pattern:/^[a-zA-Z ]+$/
			},
			email:{
				required:true,
				email:true
				//remote:"validuser.jsp"
			},
			mobile:{
				required:true,
				pattern:/^\d{10}$/
			},
			pass:{
				required:true
			},
			cpass:{
				required:true,
				equalTo:"#pass"
			},
			secq:{
				required:true
			},
			seca:{
				required:true
			}
		},
		messages:{
			name:{
				required:"<b>name is required</b>",
				pattern:"<b>Name allows only chars and spaces</b>"
			},
			email:{
				required:"<b>UserName/EmailID is Required</b>",
				email:"<b>Please enter valid email id</b>",
				remote:"<b>Email ID is already exists in Database. try new email id</b>"
			},
			mobile:{
				required:"<b>Mobile No required</b>",
				pattern:"<b>Mobile no consists 10 digits only</b>"
			},
			pass:{
				required:"<b>Password required</b>"
			},
			cpass:{
				required:"<b>Confirm Password required</b>",
				equalTo:"<b>Password Mismatch</b>"
			},
			secq:{
				required:"<b>Please select security question</b>"
			},
			seca:{
				required:"<b>Enter Security Answer</b>"
			}
		}
	});
	
	$("#form1").validate({
		rules:{
			user:{
				required:true				
			},
			pass:{
				required:true
			}
		},
		messages:{
			name:{
				required:"<b>User Name is required<b>"				
			},
			pass:{
				required:"<b>Password is required<b>"
			}
		}
	});
});

</script>
<%
if(request.getParameter("btn")!=null)
{
	String user=request.getParameter("user");
	String pass=request.getParameter("pass");
	
	ResultSet rs=db.getRows("select * from client where EmailID=? and Password=?", user,pass);
	if(rs.next())
	{
		session.setAttribute("user", user); //name of logged user
		response.sendRedirect("client/client.jsp");
	}
	else
	{
		out.println("<script> showMsg('Sorry Login Failed... try again');</script>");
	}
	
}

if(request.getParameter("btn1")!=null)
{
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile");	
	String pass=request.getParameter("pass");
	String secq=request.getParameter("secq");
	String seca=request.getParameter("seca");
	
	db.execute("Insert into client values(?,?,?,?,?,?)", name,email,mobile,pass,secq,seca);
	out.println("<script> showMsg('You have successfully created your account. Please go for login');</script>");

	
}
%>	

	
	<div class="site-blocks-cover overlay" style="background-image: url(images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
    
      <div class="container">
    
			
         <div class="form-search-wrap" data-aos="fade-up" data-aos-delay="200">
         <div class="col-sm-12">
         <div class="row">
        <div class="col-sm-4 offset-1">
         
          
					<div class="login-form"><!--login form-->
					
						<h2><b>Login to your account</b></h2>
						<form name="form1" method="post" id="form1">
						
							<input type="text" class="form-control rounded" name="user" placeholder="UserName/Email Address" autocomplete="off" />
							<br>
							
							<input type="password" class="form-control rounded" name="pass" placeholder="Password" />
							
							<br>							
							
							<span><a href="forgot.jsp"><b>Forgot password?</b></a></span>
							<button type="submit" name="btn" class="btn btn-primary btn-block rounded" value="Login">Login</button>
						</form>
					</div><!--/login form-->
				</div>
				 
				
			
				 <div class="col-sm-1">
									<h2 class="or"><b>OR</b></h2>
				</div>
				
				<div class="col-sm-5">
					<div class="signup-form"><!--sign up form-->
						<h2><b>New User Signup!</b></h2>
						<form name="form1" method="post" id="form2">
							<input type="text" class="form-control rounded" name="name" placeholder="Name"/>
							<br>
							<input type="text" class="form-control rounded" name="email" placeholder="Email Address" autocomplete="off"/>
							<br>
							<input type="text" class="form-control rounded" name="mobile" placeholder="Mobile No"/>
							<br>
							<input type="password" class="form-control rounded" id="pass" name="pass" placeholder="Password"/>
							<br>
							<input type="password" class="form-control rounded"  name="cpass" placeholder="Confirm Password"/>
							<br>
							<select name="secq">
							<br>
							<option value="">-- Select Security Question --</option>
							<br>
							<option value="What is your pet name?" class="form-control rounded">What is your pet name?</option>
							<option value="What is your birth date?">What is your birth date?</option>
							<option value="What is your birth place?">What is your birth place?</option>
							<option value="What is your favourite food?">What is your favourite food?</option>
							</select>
							<br>
							<br>
							<input type="text" class="form-control rounded" name="seca" placeholder="Security Answer"/>
							 <br>
							<button type="submit" class="btn btn-primary btn-block rounded"  name="btn1"  value="signup">Signup</button>
						</form>
					</div><!--/sign up form-->
				</div>
			</div>
		</div>
		</div>
		</div>
		
		</div>
			
		
				
				
				
					
					
						
<%@ include file="footer.jsp" %>	
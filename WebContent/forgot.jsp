<%@page import="com.db.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp" %>
 <script>
function showMsg(msg){
	bootbox.alert(msg);
}
$(document).ready(function(){
	
});
</script>
    
<%
if(request.getParameter("btn")!=null)
{
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile");	
	String secq=request.getParameter("secq");
	String seca=request.getParameter("seca");
	
	
	ResultSet rs=db.getRows("select * from client where EmailID=? and Mobile=? and SecQ=? and SecA=?", name,mobile,secq,seca);
	if(rs.next())
	{
		SendMail.mail(name, "Your Password Request", "Please note your password: "+rs.getString("Password"));
		out.println("<script> showMsg('Password sent to your mail account');</script>");
	}
	else
	{
		out.println("<script> showMsg('Invalid Information.... try again');</script>");
				System.out.println("invalid Information...try again");
	}
	
}
		
%>	
	
	<div class="site-blocks-cover overlay" style="background-image: url(images/hero_2.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
      <div class="row justify-content-center mb-4"></div>
    
      <div class="container justify-content-center" >
    
			
         <div class="form-search-wrap" data-aos="fade-up" data-aos-delay="200">
         <div class="col-sm-11">
         <div class="row">
        <div class="col-sm-4 offset-1">
         
          
					<div class="login-form"><!--login form-->
					
						<h2><b>Forgot Password</b></h2>
						<form name="form1" method="post" id="form1">
						
			
							<input type="text" name="user" class="form-control rounded" placeholder="UserName/Email Address" />
							<br>
							<input type="text" name="mobile" class="form-control rounded" placeholder="Mobile No"/>							
							
							<br>
							<select name="secq">
							
							<option value="" class="form-control rounded">-- Select Security Question --</option>
							<option value="What is your pet name?">What is your pet name?</option>
							<option value="What is your birth date?">What is your birth date?</option>
							<option value="What is your birth place?">What is your birth place?</option>
							<option value="What is your favourite food?">What is your favourite food?</option>
							</select>
							
							<input type="text" name="seca" class="form-control rounded" placeholder="Security Answer"/>
							<br>
							<button type="submit" name="btn" class="btn btn-primary btn-block rounded" value="login.jsp">Submit</button>
						</form>
					</div><!--/login form-->
				</div>
			</div>
		</div>
		</div>
		</div>
		</div>
		
	</section><!--/form-->
	
	
<%@ include file="footer.jsp" %>	
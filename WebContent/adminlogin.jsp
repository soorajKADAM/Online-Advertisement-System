

<%@page import="com.db.DBClass"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="header.jsp"%>
 <%
if(request.getParameter("btn")!=null)
{
	String user=request.getParameter("user");
	String pass=request.getParameter("pass");
	
	ResultSet rs=db.getRows("select * from adminlogin where user=? and password=?",user,pass);
	if(rs.next())
	{
		session.setAttribute("user", user); //name of logged user
		response.sendRedirect("admin/admin.jsp");
	}
	else
	{
		out.println("<script> showMsg('Sorry Login Failed... try again')</script>");
	}
	
}
%>	
 
 <section id="form">
 <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(images/hero_1.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="co-l-md-10" data-aos="fade-up" data-aos-delay="400">
            
            
            <div class="row justify-content-center mt-5">
              <div class="col-md-8 text-center">
                <h1>Administration Login</h1>
              </div>
            </div>

            
          </div>
        </div>
      </div>
    </div>  

    <div class="site-section bg-light">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-7 mb-5"  data-aos="fade">

            

            <form action="#" class="p-5 bg-white">
             
              <div class="row form-group">
                
                <div class="col-md-12">
                  <label class="text-black" >User</label> 
                  
                  <input type="text" name="user" placeholder="Admin UserName" autocomplete="off" class="form-control" />
                </div>
              </div>

              <div class="row form-group">
                
                <div class="col-md-12">
                  <label class="text-black" >Password</label> 
                  
                  <input type="password" name="pass" placeholder="Admin Password" class="form-control" />
                </div>
              </div>

                        
              <div class="row form-group">
                <div class="col-md-12">
                  <input type="submit" name="btn" value="Sign In" class="btn btn-primary py-2 px-4 text-white">
                </div>
              </div>

  
            </form>
          </div>
          
        </div>
      </div>
    </div>
    
    </section>
     <%@include file="footer.jsp" %>
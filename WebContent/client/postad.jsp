
<%@page import="java.sql.ResultSet"%>
<%@page import="com.db.DBClass"%>
<%@page import="javazoom.upload.UploadBean"%>
<%@page import="javazoom.upload.UploadFile"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javazoom.upload.MultipartFormDataRequest"%>
<%@include file="cheader.jsp" %>
<script>
function showMsg(msg){
	bootbox.alert(msg);
}

</script>
<% 


String Ad_id="",Ad_title="",Ad_category="",start_dt="",end_dt="",Ad_price="",Total_price="",Ad_img="",btntext="Save";

String path=request.getRealPath("/client/postads/");

if(MultipartFormDataRequest.isMultipartFormData(request))
{
	MultipartFormDataRequest mreq=new MultipartFormDataRequest(request);

	if(mreq.getParameter("btn2")!=null)
	{	
		response.sendRedirect(".jsp");
	}
	if(mreq.getParameter("btn1")!=null)
	{		
		Ad_id=mreq.getParameter("Ad_id");
		Ad_title=mreq.getParameter("Ad_title");
		Ad_category=mreq.getParameter("Ad_category");
		start_dt=mreq.getParameter("start_dt");
		end_dt=mreq.getParameter("end_dt");
		Ad_price=mreq.getParameter("Ad_price");
		Total_price=mreq.getParameter("Total_price");
		Ad_img=mreq.getParameter("Ad_img");
		Hashtable ht=mreq.getFiles();
		UploadFile ufile=(UploadFile) ht.get("file");
		Ad_img=ufile.getFileName();
		
		UploadBean ub=new UploadBean();
		ub.setFolderstore(path);
		ub.store(mreq,"file");
		
		if(mreq.getParameter("btn1").equals("Save"))
		{
		db.execute("Insert into clientad (title,Ad_category,start,end,Ad_price,Total_price,Ad_img) values(?,?,?,?,?,?,?)", Ad_title,Ad_category,start_dt,end_dt,Ad_price,Total_price,Ad_img);
		out.println("<script> showMsg(' Saved Successfully');</script>");
		}
		else
		{
			
		}
		
		
	}
	
}

	

%>	

	<body>

  <div class="modal-dialog text-center">
  <div class="col-sm-9 main-section">
  <div class="modal-content">
  <div class="col-12 user-img">
          <img src="img/face.png">
  </div>

  <div class="col-12 form-input">
  <form method="post" enctype="multipart/form-data">
  <div class="form-group">
            
              <input type="text" class="form-control" name="Ad_title" placeholder="Ad Title" value="<%=Ad_title %>">
   </div>
   <div class="form-group">
            <select class="form-control rounded" name="Ad_category"  value="<%=Ad_category %>">
                        <option value="">Ad Category</option>
                        <option value="">Online Ad</option>
                        <option value="">Television Ad</option>
                        <option value="">Social Media Ad</option>
                        <option value="">Radio Ad</option>
                        <option value="">Ad Banner</option>
                      </select>
     </div>
     <div class="form-group">
                     
    <table>
       <tr>
          <td>
          
            <h4 style="color:white">Duration:</h4>   
            
            <td>&nbsp &nbsp &nbsp &nbsp</td> 
         </td>
         <td>
         
         <div class="form-group-date">
         	<input type="date" class="form-control" name="start_dt" placeholder="Ad period" value="<%=start_dt%>" ><td> <h4 style="color:white">To</h4> </td> 
          </div>
         </td> 
         	
         <td>
         <div class="form-group-date">
         	<input type="date" class="form-control" name="end_dt" placeholder="Ad period" value="<%=end_dt%>" >
         	</div>  
         </td>
         	</tr>
         
            
            </tr>
            </table>
        
             </div>
             
            <div class="form-group">
              <input type="text" class="form-control" name="Ad_price" placeholder="Ad Price" value="<%=Ad_price%>">
            </div>
            <div class="form-group">
              <input type="text" class="form-control" name="Total_price" placeholder="Total Price" value="<%=Total_price%>">
            </div>
            <div class="form-group">
              <input type="file" class="form-control" name="file" placeholder="Add Image" value="<%=Ad_img%>">
            </div>
            <button type="submit" class="btn btn-success" name="btn1" value="<%=btntext%>">Proceed to payment</button>
          </form>
        </div>

        <div class="col-12 forgot">
          <a href="postad.jsp">Reset</a>
        </div>

      </div>
    </div>
  </div>


</body>
			
		
			<%@include file="cfooter.jsp" %>	
			
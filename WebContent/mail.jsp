

<%@page import="com.db.SendMail"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
String msg="";
if(request.getParameter("btn")!=null)
{
	String to=request.getParameter("to");
	String subject=request.getParameter("subject");
	String body=request.getParameter("body");
	SendMail.mail(to,subject,body);
	msg="Mail Sent to "+to+" Successfully";
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email Sender::</title>
</head>
<body>
<form name="form1" method="post">
<table>
<tr>
<td colspan="2">Email Sender</td>
</tr>
<tr>
<td>To:</td>
<td><input type="text" name="to"/></td>
</tr>
<tr>
<td>Subject:</td>
<td><input type="text" name="subject"/></td>
</tr>
<tr>
<td>Body:</td>
<td>
<textarea name="body" rows="6" cols="40"></textarea>
</td>
</tr>
<tr>
<td></td>
<td><input type="submit" name="btn" value="Send"/></td>
</tr>

<tr>
<td></td>
<td><h3><%=msg%></h3></td>
</tr>
</table>

</form>

</body>
</html>
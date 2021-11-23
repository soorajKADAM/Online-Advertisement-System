<%
session.setAttribute("user", null);
session.invalidate();
response.sendRedirect("../adminlogin.jsp");
%>
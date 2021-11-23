<%
session.setAttribute("user","");
session.invalidate();
response.sendRedirect("../login.jsp");
%>
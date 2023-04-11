


<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<h1>Display Current Date & Time</h1>
<%
    Date dNow = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
    out.print("<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
%>
<%@page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbshop", "root", "");
        Statement st = con.createStatement();
        String id = request.getParameter("id");
        int num = Integer.parseInt(id);
        String s = "delete from tbl_category where categoryid='" + num + "'";
        st.executeUpdate(s);
%>

<%
        response.sendRedirect("Categoryview.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
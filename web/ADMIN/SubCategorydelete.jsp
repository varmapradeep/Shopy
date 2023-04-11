<%@page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbshop", "root", "");
        Statement st = con.createStatement();
        String id = request.getParameter("subid");
        int num = Integer.parseInt(id);
        String s = "delete from tbl_subcategory where subcategoryid='" + num + "'";
        st.executeUpdate(s);
       response.sendRedirect("Subcategoryview.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
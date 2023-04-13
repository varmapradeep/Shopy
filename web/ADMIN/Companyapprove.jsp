<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("id");

        st.executeUpdate("update tbl_login set status='Confirmed' where loginid='" + id + "'");
%>
<script>
    alert("Company Approved Successfully");
    window.location = "Viewcompany.jsp";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
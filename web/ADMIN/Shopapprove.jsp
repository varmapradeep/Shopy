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
    alert("Shop Approved Successfully");
    window.location = "Viewshop.jsp";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("id");
        st.executeUpdate("update tbl_request set status='Cancelled' where requestid='" + id + "'");
%>
<script>
    alert("Request Cancelled Successfully");
    window.location = "viewpurchase.jsp";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
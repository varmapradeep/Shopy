<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("id");
        out.println( id );
        st.executeUpdate("update tbl_login set status='Rejected' where loginid='" + id + "'");
%>
<script>
    alert("Company Rejected Successfully");
    window.location = "companyrequests.jsp";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
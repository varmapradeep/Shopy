<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("id");
        st.executeUpdate("update tbl_request set status='Accepted' where requestid='" + id + "'");
%>
<script>
    alert("Request Approved Successfully");
    window.location = "viewrequests.jsp";
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
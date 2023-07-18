<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("productid");
        int num = Integer.parseInt(id);
        String s = "delete from tbl_shpproducts where shpproductid='" + num + "'";
        st.executeUpdate(s);

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    
    alert("Deleted Successfully");
    window.location = "productview.jsp";
</script>

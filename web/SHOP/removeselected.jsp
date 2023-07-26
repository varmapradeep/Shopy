<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%> 
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String id = request.getParameter("id");
        int num = Integer.parseInt(id);
        String s = "delete from tbl_selectedproducts where selectid='" + num + "'";
        st.executeUpdate(s);

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    window.location = "selectproductview.jsp";
</script>

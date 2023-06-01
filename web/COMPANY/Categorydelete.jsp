<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<%
    try {
          Connection con = ShopClass.getCon();
        Statement st = con.createStatement();      
        String id = request.getParameter("productid");
        int num = Integer.parseInt(id);
        String s = "delete from tbl_product where cpyproductid='" + num + "'";
        st.executeUpdate(s);
       response.sendRedirect("cpyviewproducts.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String loginid = (String) session.getAttribute("loginid");
        String productid = request.getParameter("productid");
        Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
        String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
        ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
        String shopId = "";
        if (shopIdResultSet.next()) {
            shopId = shopIdResultSet.getString("Shopid");
        } else {
            out.println("No shop ID found for the logged-in user.");
        }
        shopIdResultSet.close();

// 

        st.executeUpdate("insert into tbl_selectedproducts (shopid,productid,qty,status)"
                + " values ('" + shopId + "','" + productid + "','','Selected')");
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());

    }
%>
<script>
    alert("Product Added Sucessfully Successfully");
    window.location = "sales.jsp";
//</script>









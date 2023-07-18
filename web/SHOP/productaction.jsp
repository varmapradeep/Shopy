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

        String Category = request.getParameter("Category");
        String subcate = request.getParameter("subcat");
        String prdname = request.getParameter("prdname");
        String prddesc = request.getParameter("prddesc");
        String prdunit = request.getParameter("prdunit");
        String prdprice = request.getParameter("prdprice");
        String prdstock = request.getParameter("prdstock");
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

        st.executeUpdate("insert into tbl_shpproducts (prdshopid,category,subcategory,prdname,prddesc,prdstock,prdunit,prdprice,prdregdate)"
                + " values ('" + shopId + "','" + Category + "','" + subcate + "','" + prdname + "','" + prddesc + "','" + prdstock + "','" + prdunit + "','" + prdprice + "','" + ft.format(dNow) + "')");
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());

    }
%>
<script>
    alert("Product Added Sucessfully Successfully");
    window.location = "products.jsp";
//</script>









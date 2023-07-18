<%@ page import="java.sql.*" %>
<%@ page import="shoppackages.ShopClass" %>

<%
    try {
        // Retrieve form data
        String category = request.getParameter("Category");
        String subcategory = request.getParameter("Subcategory");
        String productName = request.getParameter("prdname");
        String productDesc = request.getParameter("prddesc");
        String productStock = request.getParameter("prdstock");
        String prdunit = request.getParameter("prdunit");
        String productPrice = request.getParameter("prdprice");
        // Retrieve shop ID from session
        String loginid = (String) session.getAttribute("loginid");
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
        ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
        String shopId = "";
        if (shopIdResultSet.next()) {
            shopId = shopIdResultSet.getString("Shopid");
        } else {
            response.sendRedirect("../GUEST/Guestindex.jsp");

        }
        shopIdResultSet.close();

        // Get product ID
        String pid = request.getParameter("productid");
        int productid = Integer.parseInt(pid);
//        out.println(category);
//        out.println(subcategory);
//        out.println(productName);
//        out.println(productDesc);
//        out.println(productStock);
//        out.println(prdunit);
//        out.println(productPrice);
//        out.println(productid);

//         Update the product in the database
        String updateQuery = "UPDATE tbl_shpproducts SET category='" + category + "', subcategory='" + subcategory + "', prdname='" + productName + "', prddesc='" + productDesc + "', prdstock='" + productStock + "', prdunit='" + prdunit + "', prdprice='" + productPrice + "' WHERE shpproductid='" + productid + "' AND prdshopid='" + shopId + "'";
        st.executeUpdate(updateQuery);
        out.println(updateQuery);
        st.close();
        con.close();

        // Redirect to a success page
        response.sendRedirect("productview.jsp");
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
//
    }
%>
<script>
    alert("Product Updated Successfully");
    window.location = "Shophome.jsp";
</script>

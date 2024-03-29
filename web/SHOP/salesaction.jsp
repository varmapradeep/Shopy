<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%
try {
    Connection con = ShopClass.getCon();
    Statement st = con.createStatement();

    String loginid = (String) session.getAttribute("loginid");
    String totalprice = request.getParameter("subtotalDisplay");
    Date dNow = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
    String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
    ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
    String shopId = "";
    if (shopIdResultSet.next()) {
        shopId = shopIdResultSet.getString("Shopid");
    } else {
        response.sendRedirect("../GUEST/Guestindex.jsp");
    }
    shopIdResultSet.close();

    String[] quantities = request.getParameterValues("quantity[]");
    String[] shpproductIds = request.getParameterValues("shpproductid[]");
    String[] totals = request.getParameterValues("total[]");
    String[] Prdstock = request.getParameterValues("Prdstock[]");

    String updateQuery = "UPDATE tbl_selectedproducts SET qty = ?, prdtotal = ? WHERE productid = ?";
    PreparedStatement updateStmt = con.prepareStatement(updateQuery);
    for (int i = 0; i < quantities.length; i++) {
        String quantity = quantities[i];
        String total = totals[i]; // Get the total for the current product
        String shpproductId = shpproductIds[i];

        updateStmt.setString(1, quantity);
        updateStmt.setString(2, total); // Set the 'prdtotal' value
        updateStmt.setString(3, shpproductId);
        updateStmt.executeUpdate();
    }
    updateStmt.close();

    String salesno = "SELECT IFNULL(MAX(salesid), 1000) + 1 AS max_salesid FROM tbl_sales";
    ResultSet rsSalesid = st.executeQuery(salesno);
    int newsalesNo = 0;
    if (rsSalesid.next()) {
        newsalesNo = rsSalesid.getInt("max_salesid");
    }
    String sql1 = "INSERT INTO tbl_sales (salesid, shopid, totalprice, salesdate, status) "
            + "VALUES ('" + newsalesNo + "', '" + shopId + "', '" + totalprice + "', '" + ft.format(dNow) + "', 'Pending')";
    st.executeUpdate(sql1);
//        out.println(sql1);

    String Query1 = "SELECT * FROM tbl_selectedproducts ts INNER JOIN tbl_shpproducts tsp ON ts.productid=tsp.shpproductid INNER JOIN tbl_unit tuu ON tuu.unitid=tsp.prdunit INNER JOIN tbl_shop tss ON ts.shopid=tss.shopid WHERE ts.shopid='" + shopId + "' AND ts.status='Selected'";
    ResultSet rss = st.executeQuery(Query1);

    String sql2 = "INSERT INTO tbl_salesdetails (salesid, productid, quantitity,prdtotals, unit) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql2);

    ArrayList<String> salesrequestIds = new ArrayList<String>();

    while (rss.next()) {
        String shpProductid = rss.getString("productid");
        String quantity = rss.getString("qty");
        String selectid = rss.getString("selectid");
        String prdtotal = rss.getString("prdtotal");
        String unit = rss.getString("prdunit");

        ps.setInt(1, newsalesNo);
        ps.setString(2, shpProductid);
        ps.setString(3, quantity);
        ps.setString(4, prdtotal);
        ps.setString(5, unit);

        ps.executeUpdate();
        salesrequestIds.add(selectid); // Step 2
    }

    rss.close();
    ps.close();
    for (String selectid : salesrequestIds) {
        st.executeUpdate("UPDATE tbl_selectedproducts SET status = 'sold' WHERE selectid = '" + selectid + "'"); // Step 3
    }

    // Calculate the new stock and update the tbl_shpproducts table
    for (int i = 0; i < shpproductIds.length; i++) {
        String shpproductId = shpproductIds[i];
        String quantity = quantities[i];

        // Get the current stock for the product
        String getProductStockQuery = "SELECT prdstock FROM tbl_shpproducts WHERE shpproductid = ?";
        PreparedStatement getProductStockStmt = con.prepareStatement(getProductStockQuery);
        getProductStockStmt.setString(1, shpproductId);
        ResultSet productStockResult = getProductStockStmt.executeQuery();

        if (productStockResult.next()) {
            int currentStock = productStockResult.getInt("prdstock");
            int soldQuantity = Integer.parseInt(quantity);

            // Calculate the new stock after the sale
            int newStock = currentStock - soldQuantity;

            // Update the tbl_shpproducts table with the new stock value
            String updateStockQuery = "UPDATE tbl_shpproducts SET prdstock = ? WHERE shpproductid = ?";
            PreparedStatement updateStockStmt = con.prepareStatement(updateStockQuery);
            updateStockStmt.setInt(1, newStock);
            updateStockStmt.setString(2, shpproductId);
            updateStockStmt.executeUpdate();
            updateStockStmt.close();
        }

        productStockResult.close();
        getProductStockStmt.close();
    }

    String status = "UPDATE tbl_sales SET status = 'Confirmed' WHERE salesid = '" + newsalesNo + "'";//step 4
    st.executeUpdate(status);
%>

<script>
    alert("Products Sold");
    var salesno = <%=newsalesNo%>;
    var shopid = <%=shopId%>;

    window.location = "shopbillgeneration.jsp?salesno=" + salesno + "&shopid=" + shopid;
</script>

<%    
} catch (Exception e) {
    out.println("Exception occurred: " + e.getMessage());
}
%>

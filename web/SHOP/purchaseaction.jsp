<%@ page import="java.sql.*" %>
<%@ page import="shoppackages.ShopClass" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    Connection con = null;
    Statement st = null;

    try {
        // Establish database connection
        con = ShopClass.getCon();
        st = con.createStatement();

        // Retrieve request parameters
        String billNo = request.getParameter("billno");
        String shopId = request.getParameter("shopid");
        String companyId = request.getParameter("companyid");
        String productId = request.getParameter("productid");
        String previousBalance = request.getParameter("previousBalance");
        String totalAmount = request.getParameter("totalAmount");
        String paidAmount = request.getParameter("paidAmount");
        String balancePayment = request.getParameter("balancePayment");
        Date now = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");

        String purchaseid = "SELECT IFNULL(MAX(purchaseid), 100) + 1 AS max_purchaseid FROM tbl_purchase";
        ResultSet purchase = st.executeQuery(purchaseid);
        int purchaseno = 0;
        if (purchase.next()) {
            purchaseno = purchase.getInt("max_purchaseid");
        }

        String sqlpurchase = "INSERT INTO tbl_purchase (purchaseid, billno, shopid, companyid, previousbalance, total_amount, payedamount, balancePayment, Purchasedate, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Completed')";

        PreparedStatement pstmt = con.prepareStatement(sqlpurchase);
        pstmt.setInt(1, purchaseno);
        pstmt.setString(2, billNo);
        pstmt.setString(3, shopId);
        pstmt.setString(4, companyId);
        pstmt.setString(5, previousBalance);
        pstmt.setString(6, totalAmount);
        pstmt.setString(7, paidAmount);
        pstmt.setString(8, balancePayment);
        pstmt.setString(9, ft.format(now));
        pstmt.executeUpdate();

        // Print the SQL statement
        out.println(sqlpurchase);
        pstmt.close();

        PreparedStatement ps = con.prepareStatement("SELECT * FROM tbl_billmaster tb "
                + "INNER JOIN tbl_shop ts ON tb.shopid = ts.shopid "
                + "INNER JOIN tbl_billdetails tbd ON tb.Billid = tbd.billno "
                + "INNER JOIN tbl_product tp ON tbd.productid = tp.cpyproductid "
                + "INNER JOIN tbl_payment tpp ON tpp.billno = tb.Billid "
                + "INNER JOIN tbl_unit tu ON tp.cpyprdunit = tu.unitid "
                + "INNER JOIN tbl_unit tuu ON tuu.unitid = tp.cpyprdunit "
                + "INNER JOIN tbl_company tc ON tb.companyid = tc.cpyid "
                + "WHERE tb.Billid = ? AND tpp.Shopid = ?");
        ps.setString(1, billNo);
        ps.setString(2, shopId);
        ResultSet rs = ps.executeQuery();
        

        while (rs.next()) {
            // Retrieve the product details from the result set
            String productid = rs.getString("cpyproductid");
            String quantity = rs.getString("quantity");

            String sqlpurchaseaction = "INSERT INTO tbl_purchasedetails (purchaseid, billno, productid, quantity) VALUES (?, ?, ?, ?)";
            PreparedStatement purchaseDetails = con.prepareStatement(sqlpurchaseaction);
            purchaseDetails.setInt(1, purchaseno);
            purchaseDetails.setString(2, billNo);
            purchaseDetails.setString(3, productid);
            purchaseDetails.setString(4, quantity);
            purchaseDetails.executeUpdate();
        }
        
        
        out.println("SQL Query: " + ps.toString());
// Close the ResultSet and PreparedStatement
        rs.close();
        ps.close();

        st.executeUpdate("UPDATE tbl_billmaster SET status='Purchased' WHERE Billid='" + billNo + "'");
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());

    }
%>
<script>
    alert("Purchase Added Successfully!");
    window.location = "purchase.jsp";
    
</script>

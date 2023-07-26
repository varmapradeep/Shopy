<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String billNo = request.getParameter("billNo");
        String totalAmount = request.getParameter("totalAmount");
        String receivedAmount = request.getParameter("receivedAmount");
        String previousDue = request.getParameter("previousDue");

        double grandTotal = Double.parseDouble(totalAmount) + Double.parseDouble(previousDue);
        double balance = grandTotal - Double.parseDouble(receivedAmount);

        Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");

        String shopidQuery = "SELECT Shopid FROM tbl_billmaster WHERE Billid='" + billNo + "'";
        ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
        String shopId = "";
        if (shopIdResultSet.next()) {
            shopId = shopIdResultSet.getString("Shopid");
        }
        

        String insertQuery = "INSERT INTO tbl_payment (billno, Shopid, totalamount, Amountpaid, Balance, Paymentdate, Status) VALUES (?, ?, ?, ?, ?, ?, 'Completed')";
        PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
        preparedStatement.setString(1, billNo);
        preparedStatement.setString(2, shopId);
        preparedStatement.setDouble(3, grandTotal);
        preparedStatement.setDouble(4, Double.parseDouble(receivedAmount));
        preparedStatement.setDouble(5, balance);
        preparedStatement.setString(6, ft.format(dNow));

        preparedStatement.executeUpdate();
        preparedStatement.close();
        
        // Update status in tbl_billmaster
        String updateQuery = "UPDATE tbl_billmaster SET Balance = ?, status = 'Paid' WHERE Billid = ?";
        PreparedStatement updateStatement = con.prepareStatement(updateQuery);
        updateStatement.setDouble(1, balance);
        updateStatement.setString(2, billNo);
        updateStatement.executeUpdate();
        updateStatement.close();
        
//        String updateQuery1 = "UPDATE tbl_request SET status = 'Delivered' WHERE shopid = ? AND regdate=? AND status='Shipped' AND companyid=?";
//        PreparedStatement updateStatement1 = con.prepareStatement(updateQuery1);
//        updateStatement1.setString(1, shopId);
//        updateStatement1.setString(2, billNo);
//        updateStatement1.executeUpdate();
//        updateStatement1.close();

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<script>
    alert("Payment Successfully");
    window.location = "Payment.jsp";
</script>

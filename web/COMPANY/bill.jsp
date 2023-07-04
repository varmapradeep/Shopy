<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String totalprice = request.getParameter("totalprice");
        String loginid = (String) session.getAttribute("loginid");
        String shopid = request.getParameter("shopid");
        String requestedDate = request.getParameter("requestedDate");
        Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");

        String cpyid = "SELECT cpyid FROM tbl_company WHERE loginid = (SELECT loginid FROM tbl_login WHERE loginid = '" + loginid + "')";
        ResultSet companyIdResultSet = st.executeQuery(cpyid);
        int companyId = 0; // Initialize to a default value
        if (companyIdResultSet.next()) {
            companyId = companyIdResultSet.getInt("cpyid"); // Corrected column name
        }
        String billno = "SELECT IFNULL(MAX(Billid), 1000) + 1 AS max_billid FROM tbl_billmaster";
        ResultSet rsBillNo = st.executeQuery(billno);
        int newBillNo = 0;
        if (rsBillNo.next()) {
            newBillNo = rsBillNo.getInt("max_billid");
        }
        // Get the initial balance from tbl_payment
        String sqlBalance = "SELECT balance FROM tbl_payment where Shopid='" + shopid + "'";
        ResultSet rsBalance = st.executeQuery(sqlBalance);
        int initialBalance = 0;
        if (rsBalance.next()) {
            initialBalance = rsBalance.getInt("balance");
        }
        String sql1 = "INSERT INTO tbl_billmaster (Billid, shopid, companyid, totalprice, Balance, confirmeddate, status) "
                + "VALUES ('" + newBillNo + "', '" + shopid + "', '" + companyId + "', '" + totalprice + "', '" + initialBalance + "', '"
                + ft.format(dNow) + "', 'Pending')";
        st.executeUpdate(sql1);

        String Query1 = "SELECT * FROM tbl_request tr INNER JOIN tbl_product tp ON tr.productid = tp.cpyproductid INNER JOIN tbl_shop ts ON tr.shopid=ts.shopid INNER JOIN tbl_district tdd ON tdd.districtid=ts.district INNER JOIN tbl_city tcc ON tcc.cityid=ts.city INNER JOIN tbl_company tc ON tr.companyid=tc.cpyid INNER JOIN tbl_login tl ON tl.loginid=tc.loginid WHERE tl.loginid='" + loginid + "' AND tr.shopid='" + shopid + "' AND tr.regdate='" + requestedDate + "' AND tr.status = 'Accepted';";
        ResultSet rss = st.executeQuery(Query1);

        String sql2 = "INSERT INTO tbl_billdetails (billno, productid, quantity) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql2);

        ArrayList<String> requestIds = new ArrayList<String>(); // Step 1

        while (rss.next()) {
            String cpyProductid = rss.getString("productid");
            String quantity = rss.getString("quantity");
            String requestid = rss.getString("requestid");

            ps.setInt(1, newBillNo);
            ps.setString(2, cpyProductid);
            ps.setString(3, quantity);
            ps.executeUpdate();

            requestIds.add(requestid); // Step 2
        }

        rss.close();
        ps.close();

        for (String requestId : requestIds) {
            st.executeUpdate("UPDATE tbl_request SET status = 'Confirmed' WHERE requestid = '" + requestId + "'"); // Step 3
        }


%>

<script>
//    alert("Bill created successfully!");
    var billId = <%= newBillNo%>;
    var cmpid=<%=companyId%>;
    window.location = "billgeneration.jsp?billId=" + billId + "&cmpid=" + cmpid;
</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

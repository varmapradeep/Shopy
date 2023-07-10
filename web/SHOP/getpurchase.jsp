<%@ page import="shoppackages.ShopClass" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    try {
        String billNo = request.getParameter("id");
        String loginid = (String) session.getAttribute("loginid");
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();

        // Get the shop ID for the current logged-in user
        String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
        ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
        String shopId = "";
        if (shopIdResultSet.next()) {
            shopId = shopIdResultSet.getString("Shopid");
        } else {
//            out.println("No shop ID found for the logged-in user.");
        }
        shopIdResultSet.close();

        // Check if the bill belongs to the current shop
        PreparedStatement ps = con.prepareStatement("SELECT * FROM tbl_billmaster tb "
                + "INNER JOIN tbl_shop ts ON tb.shopid = ts.shopid "
                + "INNER JOIN tbl_billdetails tbd ON tb.Billid = tbd.billno "
                + "INNER JOIN tbl_product tp ON tbd.productid = tp.cpyproductid "
                + "INNER JOIN tbl_payment tpp ON tpp.billno = tb.Billid "
                + "INNER JOIN tbl_unit tu ON tp.cpyprdunit = tu.unitid "
                + "INNER JOIN tbl_unit tuu ON tuu.unitid = tp.cpyprdunit "
                + "INNER JOIN tbl_company tc ON tb.companyid = tc.cpyid "
                + "WHERE tb.Billid = ? AND tpp.Shopid = ? AND tb.status = 'Paid'");
        ps.setString(1, billNo);
        ps.setString(2, shopId);
        ResultSet rs = ps.executeQuery();

        double totalPrice = 0.0;
        int slno = 0;

        if (rs.next()) {
            // Display the bill details
            double totalAmount = rs.getDouble("totalprice");
            double payAmount = rs.getDouble("totalamount");
            double payed = rs.getDouble("Amountpaid");
            double bal = rs.getDouble("Balance");
            int cpyid = (int) rs.getDouble("cpyid");
            int productid = (int) rs.getDouble("cpyproductid");

            String balanceQuery = "SELECT Balance FROM tbl_billmaster WHERE shopid='" + shopId + "' AND Billid < '" + billNo + "' ORDER BY Billid DESC LIMIT 1";
            ResultSet balanceResultSet = st.executeQuery(balanceQuery);
            double previousDue = 0;
            if (balanceResultSet.next()) {
                previousDue = balanceResultSet.getDouble("Balance");
            }
            balanceResultSet.getStatement().close();
%>
<html>
    <head>
        <title>Bill Details</title>
    </head>
    <body>
        <form class="forms-sample" action="purchaseaction.jsp" method="post">
            <div class="col-lg-12 col-md-12">

                <div class="cart-table-wrap">
                    <table class="cart-table">
                        <thead class="cart-table-head">
                            <tr class="table-head-row">
                                <th class="product-image">Index no</th>
                                <th class="product-image">Company</th>
                                <th class="product-name">Product Name</th>
                                <th class="product-desc">Product description</th>
                                <th class="product-price">Price</th>
                                <th class="product-total">Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                do {


                            %>
                            <tr class="table-body-row table-hover">
                                <td><%=++slno%></td>
                                <td class="product-unit"><%=rs.getString("cpyname")%></td>


                                <td class="product-unit">
                                    <img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"><br>
                                    <%=rs.getString("cpyproductname")%>
                                </td>
                                <td class="product-unit"><%=rs.getString("cpyproductdesc")%></td>
                                <td class="product-unit"><%=rs.getString("cpyprdprice")%></td>
                                <td class="product-unit"><%=rs.getString("quantity")%> <%=rs.getString("unitname")%></td>
                        <input type="hidden" name="shopid" value="<%= shopId%>">
                        <input type="hidden" name="billno" value="<%= billNo%>">
                        <input type="hidden" name="companyid" value="<%= cpyid%>">
                        <input type="hidden" name="productid" value="<%= productid%>">



                        </tr>
                        <%
                            } while (rs.next());
                        %>
                        </tbody>
                    </table>
                    <p></p>
                    <p></p>
                    <div class="row justify-content-end">
                        <div class="col-md-6">
                            <table class="cart-table table-active ">
                                <tr>
                                    <td><b>Net Price:</b></td>
                                    <td><%= totalAmount%></td>

                                </tr>
                                <tr>
                                    <td><b>Previous Balance:</b></td>
                                    <td><%= previousDue%></td>
                                </tr>
                                <tr>
                                    <td><b>Total Amount:</b></td>
                                    <td><%= payAmount%></td>
                                </tr>
                                <tr>
                                    <td><b>Paid Amount:</b></td>
                                    <td><%= payed%></td>
                                </tr>
                                <tr>
                                    <td><b>Balance Payment:</b></td>
                                    <td><%= bal%></td>
                                </tr>
                            </table>
                            <br>
                            <div style="text-align: right;">
                                <input type="hidden" name="netPrice" value="<%= totalAmount%>">
                                <input type="hidden" name="previousBalance" value="<%= previousDue%>">
                                <input type="hidden" name="totalAmount" value="<%= payAmount%>">
                                <input type="hidden" name="paidAmount" value="<%= payed%>">
                                <input type="hidden" name="balancePayment" value="<%= bal%>">
                                <button type="submit" class="btn btn-md btn-group-toggle btn-danger">Add Purchase</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
<%
} else {
// Bill number does not belong to the current shop
%>

        <div class="alert alert-danger" role="alert">
            The entered bill number does not belong to your shop Or This purchase has been already added.
        </div>

<%
        }

        rs.close();
        ps.close();
        st.close();
        con.close();
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
    }
%>

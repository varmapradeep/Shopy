<jsp:include page="shoppingheader.jsp" />
<%@page import="shoppackages.ShopClass"%>
<%@page import="java.sql.*"%>
<%
    int slno = 0;
%>
<div style="background-color: #07212e; height: 15%">
    <p>
</div>
<div class="col-md-12 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <p class="card-title mb-0"></p>
            <div class="table-responsive">
                <table class="table table-hover table-borderless">
                    <thead>
                        <tr>
                            <th>Index No</th>
                            <th>Billno</th>
                            <th>Company details</th>
                            <th>Product details</th>
                            <th>quantity</th>
                            <th>Unit price</th>
                            <th>Total Amount</th>
                            <th>Previous Balance</th>
                            <th>Amount payed</th>
                            <th>Balance Payment</th>
                            <th>Purchased Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                String loginid = (String) session.getAttribute("loginid");
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
                                ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
                                String shopId = "";
                                if (shopIdResultSet.next()) {
                                    shopId = shopIdResultSet.getString("Shopid");
                                } else {
                                }
                                shopIdResultSet.close();

                                String Query = "SELECT * FROM tbl_purchase tp INNER JOIN  tbl_purchasedetails tpp ON tpp.billno=tp.billno INNER JOIN tbl_company tcc ON tcc.cpyid=tp.companyid INNER JOIN tbl_shop ts ON ts.shopid=tp.shopid INNER JOIN tbl_payment tpay ON tpay.billno=tp.billno INNER JOIN tbl_product tpr ON tpp.productid=tpr.cpyproductid WHERE tp.shopid='" + shopId + "' ORDER BY tp.Purchasedate DESC;";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <tr>

                            <td class="align-middle"><%=++slno%></td>
                            <td class="align-middle"><%=rs.getString("billno")%></td>
                            <td class="align-middle"><%=rs.getString("cpyname")%></td>
                            <td class="align-middle"><%=rs.getString("cpyproductname")%></td>
                            <td class="align-middle"><%=rs.getString("quantity")%></td>                     
                            <td class="align-middle"><%=rs.getString("cpyprdprice")%></td>
                            <td class="align-middle"><%=rs.getString("total_amount")%></td>
                            <td class="align-middle"><%=rs.getString("previousbalance")%></td>
                            <td class="align-middle"><%=rs.getString("payedamount")%></td>
                            <td class="align-middle"><%=rs.getString("balancePayment")%></td>
                            <td class="align-middle"><%=rs.getString("Purchasedate")%></td>

                        </tr>
                        <% }
                            } catch (Exception e) {
                                out.println("Exception occurred: " + e.getMessage());

                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ page import="shoppackages.ShopClass" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    int slno = 0;
    try {
        String billNo = request.getParameter("id");
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
        String Query = "SELECT * FROM tbl_purchase tp INNER JOIN tbl_purchasedetails tpd ON tp.billno=tpd.billno "
                + "INNER JOIN tbl_shop ts ON ts.shopid=tp.shopid "
                + "INNER JOIN tbl_product tpr ON tpr.cpyproductid=tpd.productid"
                + " INNER JOIN tbl_unit tu ON tu.unitid=tpr.cpyprdunit"
                + "INNER JOIN tbl_company tcc ON tcc.cpyid=tp.companyid "
                + "WHERE tp.billno='"+billNo+"'AND tp.shopid='" + shopId + "'";
        ResultSet rs = st.executeQuery(Query);
        while (rs.next()) {
%>

<html>
    <head>
        <title>Bill Details</title>
    </head>
    <body>
        <form class="forms-sample" method="post">
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

                            </tr>
                            <%
                                }
                                while (rs.next());
                            %>
                        </tbody>
                    </table>
                    <p></p>
                    <p></p>
                    <div class="row justify-content-end">
                        <div class="col-md-6">
                            <table class="cart-table table-active ">

                                <tr>
                                    <td><b>Previous Balance:</b></td>
                                </tr>
                                <tr>
                                    <td><b>Total Amount:</b></td>
                                </tr>
                                <tr>
                                    <td><b>Paid Amount:</b></td>
                                </tr>
                                <tr>
                                    <td><b>Balance Payment:</b></td>
                                </tr>
                            </table>
                            <br>
                            <!--                            <div style="text-align: right;">
                                                            <button type="submit" class="btn btn-md btn-group-toggle btn-danger"></button>
                                                        </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>

<%
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
    }
%>

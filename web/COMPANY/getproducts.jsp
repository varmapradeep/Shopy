<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<html> 
    <body>
        <%
            try {
                String loginid = (String) session.getAttribute("loginid");
                Connection con = ShopClass.getCon();
                Statement st = con.createStatement();
                String shopid = request.getParameter("id");
                String requestedDate = request.getParameter("requestedDate");
                String Query = "SELECT * FROM tbl_request tr INNER JOIN tbl_shop ts ON tr.shopid = ts.shopid INNER JOIN tbl_district tdd on tdd.districtid=ts.district INNER JOIN tbl_city tcc ON tcc.cityid=ts.city INNER JOIN tbl_company tc ON tc.cpyid=tr.companyid INNER JOIN tbl_login tl ON tl.loginid = tc.loginid WHERE tl.loginid = '" + loginid + "' AND tr.shopid = '" + shopid + "' AND tr.regdate = '" + requestedDate + "' AND tr.status = 'Accepted'";
                ResultSet rs = st.executeQuery(Query);
                boolean hasData = rs.next();
                if (!hasData) {
        %>
        <script>
            alert("No Request found.");
            window.location = "viewrequestsbyshop.jsp";
        </script>
        <%
        } else {
            double totalPrice = 0.0;
            rs.beforeFirst();
            if (rs.next()) {
        %>
        <div class="row">
            <!-- Shop Details -->
            <div class="col-sm-3">
                <div class="form-group" id="req">
                    <div class="col-md-10 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <p class="card-title mb-0" style="text-align: center">Shop Details</p>
                                <br>
                                <div class="table-responsive">
                                    <table class="table table-striped table-borderless">
                                        <thead>
                                            <tr>
                                                <th>Shop Details</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="line-height: 1.6;">
                                                    <b><%= rs.getString("ownername")%></b><br>
                                                    <%= rs.getString("shopname")%><br>
                                                    <%= rs.getString("districtname")%><br>
                                                    <%= rs.getString("cityname")%><br>
                                                    <%= rs.getString("phoneno")%>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Requests -->
            <div class="col-sm-9">
                <div class="form-group" id="req">
                    <div class="col-md-10 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <p class="card-title mb-0" style="text-align: center">Requests</p>
                                <br>
                                <div class="table-responsive">
                                    <table class="table table-striped table-borderless">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Quantity</th>
                                                <th>Comment</th>
                                                <th>Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                String Query1 = "SELECT * FROM tbl_request tr INNER join tbl_product tp on tr.productid = tp.cpyproductid INNER JOIN tbl_unit tuu ON tuu.unitid=tp.cpyprdunit INNER JOIN tbl_shop ts ON tr.shopid=ts.shopid INNER JOIN tbl_district tdd on tdd.districtid=ts.district INNER join tbl_city tcc ON tcc.cityid=ts.city INNER JOIN tbl_company tc on tr.companyid=tc.cpyid INNER JOIN tbl_login tl on tl.loginid=tc.loginid WHERE tl.loginid='" + loginid + "' AND tr.shopid='" + shopid + "'AND tr.regdate='" + requestedDate + "' AND tr.status = 'Accepted' ORDER BY tr.regdate desc;";
                                                ResultSet rss = st.executeQuery(Query1);
                                                while (rss.next()) {
                                                    double price = Double.parseDouble(rss.getString("price"));
                                                    totalPrice += price;
                                            %>
                                            <tr>
                                                <td>
                                                    <img src="../COMPANY/images/Product/<%= rss.getString("cpyproductimg1")%>"
                                                         style="height: 80px;width: 80px">
                                                    <br><br>
                                                    <%= rss.getString("cpyproductname")%>
                                                </td>
                                                <td class="font-weight-bold">
                                                    <br><%= rss.getString("quantity")%> <%= rss.getString("unitname")%>
                                                </td>
                                                <td><%= rss.getString("comment")%></td>
                                                <td><%= rss.getString("price")%></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="2"></td>
                                                <td><b>Total Price:</b></td>
                                                <td><b><%= totalPrice%></b></td>
                                                <!--                                            </tr>
                                                                                            <tr>-->
                                                <td colspan="1"></td>
                                                
                                                <td>
                                                    <a href="bill.jsp?shopid=<%=shopid%>&requestedDate=<%=requestedDate%>&totalprice=<%=totalPrice%>" class="btn btn-primary mr-2" style="color: white">Generate Bill</a>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>


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
                            <th>Product</th>
                            <th>Company details</th>
                            <th>quantity</th>
                            <th>comment</th>
                            <th>Price</th>
                            <th>Requested Date</th>
                            <th>Status</th>
                            <th>Cancel</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                String loginid = (String) session.getAttribute("loginid");
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = "SELECT * FROM tbl_request tr INNER JOIN tbl_product tp ON tr.productid=tp.cpyproductid INNER JOIN tbl_shop ts ON ts.shopid=tr.shopid  INNER JOIN tbl_company tc ON tr.companyid=tc.cpyid INNER JOIN tbl_district tdd ON tdd.districtid=tc.district INNER JOIN tbl_city tcc ON tcc.cityid=tc.city  INNER JOIN tbl_login tl ON tl.loginid=ts.loginid WHERE ts.loginid='" + loginid + "' ORDER BY tr.regdate DESC;";

//                                String Query = "SELECT * FROM tbl_request tr INNER JOIN tbl_product tp ON tr.productid=tp.cpyproductid INNER JOIN tbl_shop ts ON ts.shopid=tr.shopid  INNER JOIN tbl_company tc ON tr.companyid=tc.cpyid INNER JOIN tbl_district tdd ON tdd.districtid=tc.district INNER JOIN tbl_city tcc ON tcc.cityid=tc.city  INNER JOIN tbl_login tl ON tl.loginid=ts.loginid WHERE ts.loginid='" + loginid + "';";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                                    boolean showCancelButton = false;
                                    if (rs.getString("status").equals("Requested")) {
                                        showCancelButton = true;
                                    }
                        %>
                        <tr>
                            <td class="align-middle"><%=++slno%></td>
                            <td><img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"><br>
                                <%=rs.getString("cpyproductname")%></td>
                            <td style="line-height: 1.6;"><b><%=rs.getString("regno")%></b><br><%=rs.getString("cpyname")%><br><%=rs.getString("districtname")%>,<%=rs.getString("cityname")%><br><%=rs.getString("phone")%></td>
                            <td class="font-weight-bold align-middle"><br><%=rs.getString("quantity")%> <%=rs.getString("unit")%></td>
                            <td class="align-middle"><%=rs.getString("comment")%></td>
                            <td class="align-middle"><%=rs.getString("price")%></td>
                            <td class="align-middle"><%=rs.getString("regdate")%></td>
                            <td style="cursor: pointer;" class="font-weight-medium align-middle"><%=rs.getString("status")%></td>
                            <td style="cursor: pointer;" class="font-weight-medium align-middle">
                                <% if (showCancelButton) { %>
                                    <a href="viewrequetcancel.jsp?id=<%=rs.getString("requestid")%>" onclick="return confirm('This Request Will be Cancelled.\\nDo you want to Continue?')" class="badge badge-danger" id="cancel">Cancel</a>
                                <% } %>
                            </td>
                        </tr>
                        <% }
                            } catch (Exception e) {
                                out.println("exception");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

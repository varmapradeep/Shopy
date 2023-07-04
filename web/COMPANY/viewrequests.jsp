<jsp:include page ="Companyindex.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>

<% int slno = 0;%>    

<div class="col-md-10 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <p class="card-title mb-0" style="text-align: center">Product Requests</p>
            <br>
            
            <div class="table-responsive">
                <table class="table table-striped table-borderless">
                    <thead>
                        <tr>
                            <th>Index No</th>
                            <th>Product</th>
                            <th>shop details</th>
                            <th>quantity</th>
                            <th>comment</th>
                            <th>Price</th>
                            <th>Requested Date</th>
                            <th>Accept</th>
                            <th>Reject</th>

                        </tr>  
                    </thead>
                    <tbody>
                        <%
                            try {
                                String loginid = (String) session.getAttribute("loginid");
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = "SELECT * FROM tbl_request tr INNER join tbl_product tp on tr.productid = tp.cpyproductid INNER JOIN tbl_shop ts ON tr.shopid=ts.shopid INNER JOIN tbl_district tdd on tdd.districtid=ts.district INNER join tbl_city tcc ON tcc.cityid=ts.city INNER JOIN tbl_company tc on tr.companyid=tc.cpyid INNER JOIN tbl_login tl on tl.loginid=tc.loginid WHERE tl.loginid='" + loginid + "' AND tr.status = 'Requested';";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%=++slno%></td>
                            <td><img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"><br><br>
                                <%=rs.getString("cpyproductname")%></td>
                            <td style="line-height: 1.6;"><b><%=rs.getString("ownername")%></b><br><%=rs.getString("shopname")%><br><%=rs.getString("districtname")%><br><%=rs.getString("cityname")%><br><%=rs.getString("phoneno")%></td>
                            <td class="font-weight-bold"><br><%=rs.getString("quantity")%> <%=rs.getString("unit")%></td>
                            <td><%=rs.getString("comment")%></td>
                            <td><%=rs.getString("price")%></td>
                            <td><%=rs.getString("regdate")%></td>
                            <td style="cursor: pointer;" class="font-weight-medium"><a href="viewrequestapprove.jsp?id=<%=rs.getString("requestid")%>" onclick="return confirm('This Request Will be Approved.\\nDo you want to Continue?')" class="badge badge-success">Accept</a></td>
                            <td style="cursor: pointer;" class="font-weight-medium"><a href="viewrequestreject.jsp?id=<%=rs.getString("requestid")%>" onclick="return confirm('This Request Will be Rejected.\\nDo you want to Continue?')" class="badge badge-danger">Reject</a></td>
                        </tr>
                    </tbody>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("exception");
                        }
                    %> 
                </table>
            </div>
        </div>
    </div>
</div>

<!--                                        
                                         <tr>
                                        <td>Display Advertising</td>
                                        <td class="font-weight-bold">$551</td>
                                        <td>28 Sep 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-warning">Pending</div></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>E-Mail Marketing</td>
                                        <td class="font-weight-bold">$781</td>
                                        <td>01 Nov 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-danger">Cancelled</div></td>
                                    </tr>-->
<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<%@page import="java.util.Date"%>

<% int slno = 0;%>    

<div class="col-md-12 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <p class="card-title mb-0" style="text-align: center">Search Requests</p>
            <br>
            <div class="row">
                <div class="col-sm-4">
                    <div class="form-group">
                        <label class="col-form-label">Select Shop</label>
                        <select class="select form-control" id="shopid" name="shop">
                            <option disabled selected value="">Select shop</option>
                            <%
                                try {
                                    String loginid = (String) session.getAttribute("loginid");
                                    Connection con = ShopClass.getCon();
                                    Statement st = con.createStatement();
                                    String Query = "SELECT DISTINCT ts.shopid, ts.shopname FROM tbl_request tr INNER JOIN tbl_shop ts ON tr.shopid = ts.shopid INNER JOIN tbl_company tc ON tc.cpyid = tr.companyid INNER JOIN tbl_login tl ON tl.loginid = ts.loginid WHERE tc.loginid='" + loginid + "' AND tr.status='Accepted'";
                                    ResultSet rs = st.executeQuery(Query);
                                    while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("shopid")%>"><%=rs.getString("shopname")%></option>
                            <%
                                    }
                                } catch (Exception e) {

                                }
                            %> 
                        </select>
                    </div>
                </div>
                <%
                    // Generate the current date in yyyy-MM-dd format
                    java.time.LocalDate currentDate = java.time.LocalDate.now();
                    String formattedDate = currentDate.toString();
                %>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label class="col-form-label">Select Requested Date</label>
                        <input type="date" id="requestedDate" class="form-control">
                    </div>
                </div>

                <div class="col-sm-2">

                    <br><br><br>
                    <button type="button" onclick="displayprd()" class="btn btn-primary mr-2">Search</button>

                </div>
            </div> 
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group" id="req">
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
                                                </tr>  
                                            </thead>
                                            <tbody>
                                                <%
                                                    try {
                                                        String loginid = (String) session.getAttribute("loginid");
                                                        Connection con = ShopClass.getCon();
                                                        Statement st = con.createStatement();
                                                        String Query1 = "SELECT * FROM tbl_request tr INNER join tbl_product tp on tr.productid = tp.cpyproductid INNER JOIN tbl_shop ts ON tr.shopid=ts.shopid INNER JOIN tbl_district tdd on tdd.districtid=ts.district INNER join tbl_city tcc ON tcc.cityid=ts.city INNER JOIN tbl_company tc on tr.companyid=tc.cpyid INNER JOIN tbl_unit tuu ON tuu.unitid=tp.cpyprdunit INNER JOIN tbl_login tl on tl.loginid=tc.loginid WHERE tl.loginid='" + loginid + "' AND tr.status = 'Accepted' ORDER BY tr.regdate desc;";
                                                        ResultSet rss = st.executeQuery(Query1);
                                                        while (rss.next()) {
                                                %>
                                                <tr>
                                                    <td><%=++slno%></td>
                                                    <td><img src='../COMPANY/images/Product/<%=rss.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"><br><br>
                                                        <%=rss.getString("cpyproductname")%></td>
                                                    <td style="line-height: 1.6;"><b><%=rss.getString("ownername")%></b><br><%=rss.getString("shopname")%><br><%=rss.getString("districtname")%><br><%=rss.getString("cityname")%><br><%=rss.getString("phoneno")%></td>
                                                    <td class="font-weight-bold"><br><%=rss.getString("quantity")%> <%=rss.getString("unitname")%></td>
                                                    <td><%=rss.getString("comment")%></td>
                                                    <td><%=rss.getString("price")%></td>
                                                    <td><%=rss.getString("regdate")%></td>
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
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    function displayprd() {
        var shop = document.getElementById('shopid').value;
        var date = document.getElementById('requestedDate').value;
        $.ajax({
            type: "POST",
            url: "getproducts.jsp",
            data: {id: shop, requestedDate: date}, // Include requestedDate in the data object
            success: function(data2) {
                $("#req").html(data2);
            }
        });
    }
 var currentDate = "<%= formattedDate %>";
    document.getElementById("requestedDate").value = currentDate;
    document.getElementById("requestedDate").setAttribute("max", currentDate);
</script>

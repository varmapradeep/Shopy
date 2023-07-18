<jsp:include page ="Shopheader.jsp"/>

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
                            <th>Product Name</th>
                            <th>Product Description</th>
                            <th>Product Category</th>
                            <th>Product Subcategory</th>
                            <th>Available stock</th>
                            <th>Price/Unit</th>
                            <th>Registration date</th>
                            <th>Edit</th>
                            <th>Delete</th>
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
                                String Query = "SELECT * FROM tbl_shpproducts ts INNER JOIN tbl_shop s ON ts.prdshopid=s.shopid INNER JOIN tbl_subcategory tsub ON tsub.subcategoryid=ts.subcategory INNER JOIN tbl_category tcat ON tcat.categoryid=ts.category INNER JOIN tbl_unit tu ON tu.unitid=ts.prdunit WHERE ts.prdshopid='" + shopId + "' ORDER BY prdregdate DESC;";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <tr>

                            <td class="align-middle"><%=++slno%></td>
                            <td class="align-middle"><%=rs.getString("prdname")%></td>
                            <td class="align-middle"><%=rs.getString("prddesc")%></td>
                            <td class="align-middle"><%=rs.getString("categoryname")%></td>                     
                            <td class="align-middle"><%=rs.getString("subcategoryname")%></td>
                            <td class="align-middle"><%=rs.getString("prdstock")%> <%=rs.getString("unitname")%></td>
                            <td class="align-middle"><%=rs.getString("prdprice")%></td>
                            <td class="align-middle"><%=rs.getString("prdregdate")%></td>
                            <td class="align-middle"><a href="productedit.jsp?productid=<%=rs.getString("shpproductid")%>" onclick="return confirm('Do you want to Edit this Product?')" class="btn btn-success">Edit</a></td>
                            <td class="align-middle"><a href="productdelete.jsp?productid=<%=rs.getString("shpproductid")%>" onclick="return confirm('Do you want to Delete this Product?')" class="btn btn-danger">Delete</a></td>


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

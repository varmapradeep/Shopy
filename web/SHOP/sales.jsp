<jsp:include page="Shopheader.jsp" />
<%@ page import="java.sql.*" %>
<div style="background-color: #07212e; height: 15%"></div>
<%@ page import="shoppackages.ShopClass" %>
<%
    int slno = 0;
%>

<div class="single-product mt-60 mb-50">
    <p style="text-align: center; font-size: 30px; font-family: Copperplate Gothic;"><b>Search Products</b></p>
    <form class="container ">
        <div class="row">
            <div class="col-md-6 flex-column">
                <div class="single-product-img">
                    <div class="form-group">
                        <label class="col-form-label" style="text-align: left;">Product Category</label>
                        <select class="form-control" id="cate" onchange="displaysubcat()" name="Category">
                            <option disabled selected value="">Select Category</option>
                            <% try {
                                    Connection con = ShopClass.getCon();
                                    Statement st = con.createStatement();
                                    String Query = "select * from tbl_category";
                                    ResultSet rs = st.executeQuery(Query);
                                    while (rs.next()) {%>
                            <option value="<%= rs.getString("categoryid")%>"><%= rs.getString("categoryname")%></option>
                            <% }
                                    rs.close();
                                    st.close();
                                    con.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }%>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-6 flex-column">
                <div class="single-product-img" >
                    <div class="form-group" id="cat">
                        <label class="col-form-label" style="text-align: left;">Product Subcategory</label>
                        <select class="form-control" id="subcat" name="Subcategory">
                            <option disabled selected value="">Select SubCategory</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="col-md-12 grid-margin stretch-card" id="display">
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
                            <th>Available stock</th>
                            <th>Price/Unit</th>
                            <th>Add to list<th>

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
                                    response.sendRedirect("../GUEST/Guestindex.jsp");

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
                            <td class="align-middle"><%=rs.getString("prdstock")%> <%=rs.getString("unitname")%></td>
                            <td class="align-middle"><%=rs.getString("prdprice")%></td>
                            <td class="align-middle">
                               <a href="selectproduct.jsp?productid=<%=rs.getString("shpproductid")%>" onclick="updateLink(this);" class="bi bi-plus" style="font-size: 30px">+</a>

                            </td>



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
<jsp:include page="Shopfooter.jsp" />
<script>
    function displaysubcat() {
        var val = document.getElementById('cate').value;
        $.ajax({
            type: "POST",
            url: "getsubcategory.jsp",
            data: {id: val},
            success: function(data2) {
                $("#cat").html(data2);
            }
        });
    }
    function updateLink(link) {
        link.innerHTML = '&#10004;'; // HTML entity for the tick mark symbol
    }


</script>


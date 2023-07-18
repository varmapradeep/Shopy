<jsp:include page="Shopheader.jsp" />
<%@ page import="java.sql.*" %>
<div style="background-color: #07212e;height: 15%"></div>
<%@ page import="shoppackages.ShopClass" %>

<div class="single-product mt-60 mb-150">
    <p style="text-align: center;font-size: 30px;font-family: Copperplate Gothic;"><b>Edit Products</b></p>
    <form class="container" style="display: flex; justify-content: center;" action="producteditaction.jsp">
        <div class="col-md-6" style="text-align: left;font-size: 15px;">
            <p></p>
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
                        // Handle the case when shopId is not found
                                    response.sendRedirect("../GUEST/Guestindex.jsp");

                    }
                    shopIdResultSet.close();

                    String pid = request.getParameter("productid");
                    int productid = Integer.parseInt(pid);

                    String Query2 = "SELECT * FROM tbl_shpproducts ts INNER JOIN tbl_shop s ON ts.prdshopid=s.shopid INNER JOIN tbl_subcategory tsub ON tsub.subcategoryid=ts.subcategory INNER JOIN tbl_category tcat ON tcat.categoryid=ts.category INNER JOIN tbl_unit tu ON tu.unitid=ts.prdunit WHERE ts.prdshopid='" + shopId + "' AND ts.shpproductid='" + productid + "' ORDER BY prdregdate DESC;";
                    ResultSet rs2 = st.executeQuery(Query2);
                    if (rs2.next()) {
                        String category = rs2.getString("categoryname");
                        String subcategory = rs2.getString("subcategoryname");
                        String subcategoryid = rs2.getString("subcategoryid");

                        String productName = rs2.getString("prdname");
                        String productDesc = rs2.getString("prddesc");
                        String productStock = rs2.getString("prdstock");
                        String unit = rs2.getString("unitname");
                        String productPrice = rs2.getString("prdprice");

            %>
            <div class="single-product-img">
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Category</label>
                    <select class="form-control" id="cate" name="Category" onchange="displaysubcat()" value="<%= category%>">
                        <% try {
                                String query = "SELECT * FROM tbl_category";
                                ResultSet rs = st.executeQuery(query);
                                while (rs.next()) {
                                    String categoryId = rs.getString("categoryid");
                                    String categoryName = rs.getString("categoryname");
                                    boolean isSelected = categoryName.equals(category); // Fix the variable name to "category"

                                    if (isSelected) {
                        %>
                        <option value="<%= categoryId%>" selected><%= categoryName%></option>
                        <%
                        } else {
                        %>
                        <option value="<%= categoryId%>"><%= categoryName%></option>
                        <%
                                    }
                                }
                                rs.close();
                            } catch (Exception e) {
                                out.println("Exception occurred: " + e.getMessage());
                            }
                        %>
                    </select>
                </div>
            </div>


            <div class="form-group" id="cat">
                <label class="col-form-label" style="text-align: left;">Product Subcategory</label>
                <select class="form-control" id="subcat" name="Subcategory">
                    <option value="<%= subcategoryid%>"><%= subcategory%></option>
                </select>
            </div>
            <div class="form-group">
                <label class="col-form-label" style="text-align: left;">Product name:</label>
                <input type="text" class="form-control" id="prdname" value="<%= productName%>" placeholder="Enter Product Name" name="prdname">
            </div>
            <p></p>
            <div class="form-group">
                <label class="col-form-label" style="text-align: left;">Product Desc:</label>
                <input type="text" class="form-control" id="prddesc" value="<%= productDesc%>" placeholder="Enter Product Description" name="prddesc">
            </div>
            <div class="form-group">
                <label class="col-form-label" style="text-align: left;">Product Stock</label>
                <input type="text" class="form-control" id="prdstock" value="<%= productStock%>" placeholder="Enter Product Stock" name="prdstock">
            </div>
            <div class="form-group">
                <label class="col-form-label" style="text-align: left;">Product Unit</label>
                <select class="form-control" id="prdunit" name="prdunit">
                    <%
                        try {
                            String query = "SELECT * FROM tbl_unit";
                            ResultSet rs = st.executeQuery(query);
                            while (rs.next()) {
                                String unitId = rs.getString("unitid");
                                String unitName = rs.getString("unitname");
                                boolean isSelected = unitId.equals(unit); // Check if the current unit is selected

                                if (isSelected) {
                    %>
                    <option value="<%= unitId%>" selected><%= unitName%></option>
                    <%
                    } else {
                    %>
                    <option value="<%= unitId%>"><%= unitName%></option>
                    <%
                                }
                            }
                            rs.close();
                        } catch (Exception e) {
                            out.println("Exception occurred: " + e.getMessage());
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label class="col-form-label" style="text-align: left;">Product Unit Price:</label>
                <input type="text" class="form-control" value="<%= productPrice%>" id="prdprice" placeholder="Enter Product Price / Unit" name="prdprice">
            </div>
            <div>
                <input type="hidden" name="productid" value="<%= productid%>">

                <button type="submit" class="btn btn-danger" style="text-align: right;">Add Product</button>
            </div>
        </div>
        <%
                }
                rs2.close();
                con.close();
            } catch (Exception e) {
                out.println("Exception occurred: " + e.getMessage());
            }
        %>
</div>
</form>
</div>

<jsp:include page="Shopfooter.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
                        function displaysubcat() {
                            var val = document.getElementById('cate').value;
                            $.ajax({
                                type: "POST",
                                url: "getsubcategoryedit1.jsp",
                                data: {id: val},
                                success: function(data2) {
                                    $("#cat").html(data2);
                                }
                            });
                        }
</script>

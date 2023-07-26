<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<div class="col-md-9 grid-margin stretch-card" style="alignment-baseline: central;">
    <div class="card">
        <div class="card-body">
            <div style="text-align: center">
                <h4 class="card-title">Product Edit Form</h4>
                <p class="card-description">Edit Products</p>  
            </div>
            <%
                try {
                    String id = request.getParameter("productid");
                    int num = Integer.parseInt(id);
                    Connection con = ShopClass.getCon();
                    Statement st = con.createStatement();
                    String Query = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num + "'");
                    ResultSet rs = st.executeQuery(Query);
                    if (rs.next()) {
//                        String catid = rs.getString("subcategoryid");
                        String cpyproductname = rs.getString("cpyproductname");
                        String cpyproductdesc = rs.getString("cpyproductdesc");
//                        String categoryname = rs.getString("categoryname");
                        String subcategoryname = rs.getString("subcategoryname");
//                        String unitname = rs.getString("unitname");
                        String cpyprdprice = rs.getString("cpyprdprice");
                        String cpyproductimg1 = rs.getString("cpyproductimg1");
                        String cpyproductimg2 = rs.getString("cpyproductimg2");
                        String cpyproductimg3 = rs.getString("cpyproductimg3");
                        String categoryid = rs.getString("categoryid");
                        String unitid = rs.getString("unitid");
                        String pid = rs.getString("cpyproductid");


            %>
            <form class="forms-sample" action="cpyproducteditaction.jsp" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label  class="col-form-label">Product Category</label>
                            <select class="form-control" id="cate" onchange="displaysubcat()"  name="Category">
                                <% try {
                                        String querycat = "SELECT * FROM tbl_category";
                                        ResultSet rscat = st.executeQuery(querycat);
                                        while (rscat.next()) {
                                            String categoryId = rscat.getString("categoryid");
                                            String categoryName = rscat.getString("categoryname");
                                            boolean isSelected = categoryId.equals(categoryid); // Fix the variable name to "category"

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
                    <div class="col-sm-6">
                        <div class="form-group" id="cat">
                            <label  class="col-form-label">Product Subcategory</label>
                            <select class="form-control" id="subcat" name="subcat">
                                <option disabled selected value="catid"><%= subcategoryname%></option>
                                
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-form-label">Product Name</label>
                            <input type="text" class="form-control" value="<%= cpyproductname%>" name="cpyprdname" id="cpyprdname" placeholder="Product Name">
                        </div>
                    </div>


                    <div class="col-sm-6">
                        <div class="form-group">
                            <label  class="col-form-label">Product Description</label>
                            <textarea class="form-control" id="cpyprddesc" name="cpyprddesc" placeholder="Product Description"><%=cpyproductdesc%></textarea>   
                        </div>
                    </div>
                </div>



                <div class="row">
                    <div class="col-sm-6">                   
                        <div class="form-group" id="cat">
                            <label  class="col-form-label">Unit</label>
                            <select class="form-control" name="unit" id="unit">
                                <%
                                    try {
                                        String queryunit = "SELECT * FROM tbl_unit";
                                        ResultSet rsunit = st.executeQuery(queryunit);
                                        while (rsunit.next()) {
                                            String unitId = rsunit.getString("unitid");
                                            String unitName = rsunit.getString("unitname");
                                            boolean isSelected = unitId.equals(unitid); // Check if the current unit is selected

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




                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label  class="col-form-label">Product Price per Unit</label>
                            <input type="text" class="form-control" value="<%=cpyprdprice%> " name="price" id="price" placeholder="Product Price">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <div class="form-group">
                            <label  class="col-form-label">Product image 1</label>
                            <input type="file" class="form-control"  name="image1" id="image1">
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <label class="col-form-label">Product image 2</label>
                            <input type="file" class="form-control" value="<%= cpyproductimg2%>" name="image2" id="image2">
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <div class="form-group">
                            <label class="col-form-label">Product image 3</label>
                            <input type="file" class="form-control" name="image3" id="image3">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <button type="submit" class="btn btn-primary mr-2">Submit</button>
                        <button class="btn btn-light">Cancel</button>
                    </div>
                </div>
                <input type="hidden" class="form-control" value="<%= pid%>" name="productid" id="productid">

            </form>
            <% }
                } catch (Exception e) {
                    out.println("Exception occurred: " + e.getMessage());

                }
            %>
        </div>
    </div>
</div>
<script>
    function displaysubcat() {
        var val = document.getElementById('cate').value;
        $.ajax({
            type: "POST",
            url: "getsubcategory.jsp",
            data: {id: val}, // Updated syntax for sending data
            success: function(data2) {
                $("#cat").html(data2);
            }
        });
    }
</script>
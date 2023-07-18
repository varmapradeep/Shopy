<jsp:include page="Shopheader.jsp" />

<%@ page import="java.sql.*" %>
<div style="background-color: #07212e;height: 15%"></div>
<%@ page import="shoppackages.ShopClass" %>

<div class="single-product mt-60 mb-150">
    <p style="text-align: center;font-size: 30px;font-family: Copperplate Gothic;"><b>Add Products</b></p>
    <form class="container" style="display: flex; justify-content: center;" action="productaction.jsp">
        <div class="col-md-6" style="text-align: left;font-size: 15px;">
            <p></p>
            <div class="single-product-img">
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Category</label>
                    <select class="form-control" id="cate" onchange="displaysubcat()" name="Category">
                        <option disabled selected value="">Select Category</option>
                        <% 
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "select * from tbl_category";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) { 
                        %>
                                <option value="<%= rs.getString("categoryid") %>"><%= rs.getString("categoryname") %></option>
                        <% 
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>   
                    </select>
                </div>
                <div class="form-group" id="cat">
                    <label class="col-form-label" style="text-align: left;">Product Subcategory</label>
                    <select class="form-control" id="subcat" name="Subcategory">
                        <option disabled selected value="">Select Subcategory</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product name:</label>
                    <input type="text" class="form-control" id="prdname" placeholder="Enter Product Name" name="prdname">
                </div>
                <p></p>
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Desc:</label>
                    <input type="text" class="form-control" id="prddesc" placeholder="Enter Product Description" name="prddesc">
                </div>
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Stock</label>
                    <input type="text" class="form-control" id="prdstock" placeholder="Enter Product Stock" name="prdstock">
                </div>
                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Unit</label>
                    <select class="form-control" id="prdunit"  name="prdunit">
                        <option disabled selected value="">Select Unit</option>
                        <% 
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "select * from tbl_unit";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) { 
                        %>
                                <option value="<%= rs.getString("unitid") %>"><%= rs.getString("unitname") %></option>
                        <% 
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch (Exception e) {
                                    out.println("Exception occurred: " + e.getMessage());
                        } %>   
                    </select>
                </div>

                <div class="form-group">
                    <label class="col-form-label" style="text-align: left;">Product Unit Price:</label>
                    <input type="text" class="form-control" id="prdprice" placeholder="Enter Product Price / Unit" name="prdprice">
                </div>
                
                <div>
                    <button type="submit" class="btn btn-danger" style="text-align: right;">Add Product</button>
                </div>
            </div>
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
            url: "getsubcategory.jsp",
            data: {id: val},
            success: function(data2) {
                $("#cat").html(data2);
            }
        });
    }
</script>

<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<div class="col-md-9 grid-margin stretch-card" style="alignment-baseline: central;">
    <div class="card">
        <div class="card-body">
            <div style="text-align: center">
                <h4 class="card-title">Product Form</h4>
                <p class="card-description">Add Products</p>  
            </div>
            <form class="forms-sample" action="Cpyaddproductaction.jsp" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label  class="col-form-label">Product Category</label>
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
                                <option value="<%=rs.getString("categoryid")%>"><%=rs.getString("categoryname")%></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                    }
                                %>   
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group" id="cat">
                            <label  class="col-form-label">Product Subcategory</label>
                            <select class="form-control" id="subcat">
                                <option disabled selected value="">Select Category</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="col-form-label">Product Name</label>
                            <input type="text" class="form-control" name="cpyprdname" id="cpyprdname" placeholder="Product Name">
                        </div>
                    </div>
                  
                    
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label  class="col-form-label">Product Description</label>
                            <textarea class="form-control" id="cpyprddesc" name="cpyprddesc" placeholder="Product Description" >  
                            </textarea>     
                        </div>
                    </div>
                </div>


               
        <div class="row">
<!--            <div class="col-sm-5">
                <div class="form-group">
                    <label  class="col-form-label">Product Stock</label>
                    <input type="text" class="form-control" id="stock" name="stock" placeholder="Product Stock">
                </div>
            </div>-->
            <div class="col-sm-6">
                <div class="form-group" id="cat">
                    <label  class="col-form-label">Unit</label>
                    <select class="form-control" name="unit" id="unit">
                        <option disabled selected value="">Select Unit</option>
                        <%!
                            public String getUnits() {
                                StringBuilder options = new StringBuilder();
                                try {
                                    Connection con = ShopClass.getCon();
                                    Statement st = con.createStatement();
                                    String Query = "SELECT * FROM tbl_unit";
                                    ResultSet rs = st.executeQuery(Query);
                                    while (rs.next()) {
                                        options.append("<option value=\"").append(rs.getString("unitid")).append("\">")
                                                .append(rs.getString("unitname")).append("</option>");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                return options.toString();
                            }
                        %>
                        <%= getUnits()%>
                    </select>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group">
                    <label  class="col-form-label">Product Price per Unit</label>
                    <input type="text" class="form-control" name="price" id="price" placeholder="Product Price">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-4">
                <div class="form-group">
                    <label  class="col-form-label">Product image 1</label>
                    <input type="file" class="form-control" name="image1" id="image1">
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-group">
                    <label class="col-form-label">Product image 2</label>
                    <input type="file" class="form-control" name="image2" id="image2">
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
        </form>
    </div>
</div>
</div>
<script>
    function displaysubcat()
    {
//        alert("a")
        var val = document.getElementById('cate').value;
//        alert(val)
        $.ajax({
            type: "POST",
            url: "getsubcategory.jsp",
            data: "id=" + val,
            success: function(data2)
            {
// alert(data2);
                $("#cat").html(data2);
            }
        })
    }
</script> 

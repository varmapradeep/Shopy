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
            <div>
                <form class="forms-sample" action="cpyproducteditaction.jsp" method="post" enctype="multipart/form-data">
                    <%
                        try {
                            String id = request.getParameter("productid");
                            int num = Integer.parseInt(id);
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num + "'");
                            ResultSet rs = st.executeQuery(Query);
                            if (rs.next()) {
                                String catid = rs.getString("subcategoryid");
                    %>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label  class="col-form-label">Product Category</label>
                                <select class="form-control" id="cate" onchange="displaysubcatedit()" name="Category">
                                    <option disabled selected value=""><%=rs.getString("categoryname")%></option>
                                    <%
                                        try {

                                            String Query1 = "select * from tbl_category";
                                            ResultSet rs2 = st.executeQuery(Query1);
                                            while (rs2.next()) {
                                    %>
                                    <option value="<%=rs2.getString("categoryid")%>"><%=rs2.getString("categoryname")%></option>
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
                                    <option disabled selected value="">Select Subcategory</option>

                                    <%
                                        try {

                                            String Query1 = "select * from tbl_subcategory where subcategoryid='" + catid + "'";
                                            ResultSet rs2 = st.executeQuery(Query1);
                                            while (rs2.next()) {
                                    %>
                                    <option  selected value=""><%=rs2.getString("subcategoryname")%></option>

                                    <%
                                            }
                                        } catch (Exception e) {

                                        }
                                    %>  

                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Product Name</label>
                                <%
                                    try {
                                        String id1 = request.getParameter("productid");
                                        int num1 = Integer.parseInt(id);
                                        String prdname = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num1 + "'");
                                        ResultSet name = st.executeQuery(prdname);
                                        while (name.next()) {
                                %>
                                <input type="text" class="form-control" value="<%=name.getString("cpyproductname")%>" name="cpyprdname" id="cpyprdname" placeholder="Product Name">
                                <%
                                        }
                                    } catch (Exception e) {

                                    }
                                %> 

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label  class="col-form-label">Product Description</label>
                                <%
                                    try {
                                        String id1 = request.getParameter("productid");
                                        int num1 = Integer.parseInt(id);
                                        String prdname = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num1 + "'");
                                        ResultSet desc = st.executeQuery(prdname);
                                        while (desc.next()) {
                                %>
                                <textarea class="form-control" id="cpyprddesc" name="cpyprddesc"  placeholder="Product Description" > <%=desc.getString("cpyproductdesc")%> 
                            </textarea>
                                <%
                                        }
                                    } catch (Exception e) {

                                    }
                                %> 
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label  class="col-form-label">Product Stock</label>
                                <%
                                    try {
                                        String id1 = request.getParameter("productid");
                                        int num1 = Integer.parseInt(id);
                                        String prdname = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num1 + "'");
                                        ResultSet stock = st.executeQuery(prdname);
                                        while (stock.next()) {
                                %>
                                <input type="text" class="form-control" id="stock" value="<%=stock.getString("cpyproductname")%>" name="stock" placeholder="Product Stock">
                                <%
                                        }
                                    } catch (Exception e) {

                                    }
                                %> 
                            </div>
                        </div>
                        <%
                            try {

                                String Queryv = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num + "'");
                                ResultSet rsd = st.executeQuery(Queryv);
                                if (rsd.next()) {

                        %>
                        <div class="col-sm-2">
                            <div class="form-group" id="cat">
                                <label  class="col-form-label">Unit</label>
                                <select class="form-control" name="unit" id="unit">
                                    <option disabled selected value=""><%=rsd.getString("unitname")%></option>

                                    <% 
                                       try {

                                            String Query1 = "select * from tbl_unit";
                                            ResultSet rs2 = st.executeQuery(Query1);
                                            while (rs2.next()) {
                                    %>

                                    <option value="<%=rs2.getString("unitid")%>"><%=rs2.getString("unitname")%></option>
                                    <%
                                            }
                                        } catch (Exception e) {

                                        }
                                    %>  
                                </select>
                            </div>
                        </div>
                           <%
                                            }
                                        } catch (Exception e) {

                                        }
                                    %>  
                                    
                          <%
                            try {

                                String Queryv = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num + "'");
                                ResultSet rsd = st.executeQuery(Queryv);
                                if (rsd.next()) {

                        %>                                                                                                                       
                        <div class="col-sm-5">
                            <div class="form-group">
                                <label  class="col-form-label">Product Price per Unit</label>
                                <input type="text" class="form-control" value="<%=rsd.getString("cpyprdprice")%>" name="price" id="price" placeholder="Product Price">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label  class="col-form-label">Product image 1</label>
                                <input type="file" class="form-control" disabled name="image1" id="image1">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-form-label">Product image 2</label>
                                <input type="file" class="form-control" disabled name="image2" id="image2">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-form-label">Product image 3</label>
                                <input type="file" class="form-control" disabled name="image3" id="image3">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <button type="submit" class="btn btn-primary mr-2">Update</button>
                            <button class="btn btn-light" >Cancel</button>
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {

                        }
                    %> 
                </form>
                <%
                        }
                    } catch (Exception e) {
                        out.println("error");
                    }
                %>      

            </div>
        </div>
    </div>
</div>
<script>
    function displaysubcatedit()
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

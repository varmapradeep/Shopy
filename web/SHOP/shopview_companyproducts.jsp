<jsp:include page ="shoppingheader.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<div style="background-color: #07212e;height: 15%">
    <p>   
</div>
<div class="product-section ">
    <div class="container">
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

        <div class="row product-lists">
            <%
                try {
                    String loginid = (String) session.getAttribute("loginid");
                    Connection con = ShopClass.getCon();
                    Statement st = con.createStatement();
                    String Query = "SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid";
                    ResultSet rs = st.executeQuery(Query);
                    while (rs.next()) {
            %>
            <div class="col-lg-3 col-md-12 text-center">
                <div class="single-product-item">
                    <div class="product-image">
                        <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block w-100 align-content-center" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 300px;object-fit: contain" alt="First slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg2")%>' style="height: 300px;object-fit: contain" alt="Second slide">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg3")%>' style="height: 300px;object-fit: contain" alt="third slide">
                                </div>

                            </div>
                        </div>
                    </div>
                    <h3><%=rs.getString("cpyproductname")%></h3>
                    <p style="padding: 10px;"><%=rs.getString("cpyproductdesc")%><p>
                    <p><span><b>&#8377;<%=rs.getString("cpyprdprice")%></b></span><br>Per <%=rs.getString("unitname")%></p>

                    <a href="requestform.jsp?productid=<%=rs.getString("cpyproductid")%>" class="cart-btn"><i class="fas fa-shopping-cart"></i>Book now</a>
                </div>
            </div> 
            <%
                    }
                } catch (Exception e) {
                    out.println("exception");
                }
            %>
        </div>

    </div>

    <div class="row">
        <div class="col-lg-12 text-center">
            <div class="pagination-wrap">
                <ul>
                    <li><a href="#">Prev</a></li>
                    <li><a href="#">1</a></li>
                    <li><a class="active" href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">Next</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>
<!-- end products -->

<!-- logo carousel -->

<!-- end logo carousel -->
<jsp:include page ="Shopfooter.jsp"/>
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

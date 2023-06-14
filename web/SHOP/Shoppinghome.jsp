<jsp:include page ="shoppingheader.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<!-- home page slider -->
<div class="loader">
    <div class="loader-inner">
        <div class="circle"></div>
    </div>
</div>
<div class="homepage-slider">
    <!-- single home slider -->

    <div class="single-homepage-slider homepagee-bgg-3">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1 text-center">
                    <div class="hero-text">
                        <div class="hero-text-tablecell">
                            <p class="subtitle">Fresh & Organic</p>
                            <h1>Delicious Seasonal Fruits</h1>
                            <div class="hero-btns">
                                <a href="error.jsp" class="boxed-btn">Visit Shop</a>
                                <a href="error.jsp" class="bordered-btn">Contact Us</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- single home slider -->
    <div class="single-homepage-slider homepagee-bgg-2">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1 text-center">
                    <div class="hero-text">
                        <div class="hero-text-tablecell">
                            <p class="subtitle">Fresh Everyday</p>
                            <h1>100% Organic Collection</h1>
                            <div class="hero-btns">
                                <a href="error.jsp" class="boxed-btn">Visit Shop</a>
                                <a href="error.jsp" class="bordered-btn">Contact Us</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- single home slider -->
</div>
<div>
    <h3 style="text-align: center;padding-top: 20px;font-family: Garamond, serif;"><u>PRODUCTS</u></h3>
   
    <div class="product-section mt-50 mb-20">
        <div class="container">
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
                <div class="col-lg-4 col-md-12 text-center strawberry">
                    <div class="single-product-item">
                        <div class="product-image">
                            <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img class="d-block w-100 align-content-center" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 300px" alt="First slide">
                                    </div>
                                    <div class="carousel-item">
                                        <img class="d-block w-100" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg2")%>' style="height: 300px" alt="Second slide">
                                    </div>
                                    <div class="carousel-item">
                                        <img class="d-block w-100" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg3")%>' style="height: 300px" alt="Second slide">
                                    </div>

                                </div>
                            </div>
                        </div>
                        <h3><%=rs.getString("cpyproductname")%></h3>
                        <p><%=rs.getString("cpyproductdesc")%><p>
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
    </div>

</div>

<!-- end home page slider -->

<!-- features list section -->


<jsp:include page ="Shopfooter.jsp"/>

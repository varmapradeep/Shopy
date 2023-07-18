<jsp:include page ="shoppingheader.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<% int slno = 0;%>    
<style>
    .hide{

        visibility: hidden

    }
</style>

<div style="background-color: #07212e;height: 15%">
</div>
<p style="text-align: center;font-size: 35px;font-family: Copperplate Gothic;"><b>REQUEST FORM</b></p>
<div class="cart-section mt-50 mb-150">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div class="cart-table-wrap">
                    <table class="cart-table">
                        <thead class="cart-table-head">
                            <tr class="table-head-row">
                                <td><%=++slno%></td>
                                <th class="product-image">Product Image</th>
                                <th class="product-name">Name</th>
                                <th class="product-desc">Product description</th>
                                <th class="product-price">Price</th>
                                <th class="product-total">Unit</th>
                                <th class="product-total">Quantity</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    String loginid = (String) session.getAttribute("loginid");
                                    String id = request.getParameter("productid");
                                    int num = Integer.parseInt(id);
                                    Connection con = ShopClass.getCon();
                                    Statement st = con.createStatement();
                                    String Query = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cpyproductid ='" + num + "'");
                                    ResultSet rs = st.executeQuery(Query);
                                    while (rs.next()) {

                            %>
                            <tr class="table-body-row">

                                <td class="product-remove"><a href="#"><i class="far fa-window-close"></i></a></td>
                                <td class="product-image"><img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' alt="Second slide">
                                </td>
                                <td class="product-name"><%=rs.getString("cpyproductname")%></td>
                                <td class="product-description"><%=rs.getString("cpyproductdesc")%></td>

                                <td class="product-price" id="price">&#8377;<%=rs.getString("cpyprdprice")%> </td>
                                <td class="product-quantity"><input type="number" id="qty" name="quantity" onchange="total()"  min="1" oninput="this.value = Math.abs(this.value)"></td>


                                <td class="product-unit"><%=rs.getString("unitname")%></td>



                                <td class="product-price-hide"><input type="hidden" id="price1" value="<%=rs.getString("cpyprdprice")%>" ></td>

                            </tr>

                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("exception");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

                        <div class="col-lg-4">
                            <div class="total-section">
                                <table class="total-table">
                                    <thead class="total-table-head">
                                        <tr class="table-total-row">
                                            <th>Total</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="total-data">
                                            <td><strong>Total Price: </strong></td>
                                            <td>&#8377;<input class="form-control" id="totalprice" type="number" readonly></td>
                                        </tr>
                                        <tr class="total-data">
                                            <td><strong>Shipping Charge: </strong></td>
                                            <td>&#8377;<input class="form-control"  type="number" value="20" readonly></td>
            
                                        </tr>
                                        <tr class="total-data">
                                            <td><strong>Total: </strong></td>
                                            <td>&#8377;<input class="form-control" id="total" type="number" readonly></td>
            
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="cart-buttons">
                                    <a href="cart.html" class="boxed-btn">Request now</a>
                                    <a href="checkout.html" class="boxed-btn black">Check Out</a>
                                </div>
                            </div>

                            <div class="coupon-section">
                                <h3>Apply Coupon</h3>
                                <div class="coupon-form-wrap">
                                    <form action="index.html">
                                        <p><input type="text" placeholder="Coupon"></p>
                                        <p><input type="submit" value="Apply"></p>
                                    </form>
                                </div>
                            </div>
        </div>
    </div>
</div>
</div>
<script>
    function total() {
        var val = document.getElementById('qty').value;
        var price = document.getElementById('price1').value;
        var total = val * price;
        document.getElementById('totalprice').value = total;
        grandtotal = total + 20;
        document.getElementById('total').value = grandtotal;


    }
</script>







<jsp:include page ="Shopfooter.jsp"/>





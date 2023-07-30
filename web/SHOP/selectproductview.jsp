<jsp:include page="Shopheader.jsp" />
<%@ page import="java.sql.*" %>
<div style="background-color: #07212e; height: 15%"></div>
<%@ page import="shoppackages.ShopClass" %>
<p style="text-align: center; font-size: 30px; font-family: Copperplate Gothic;"><b>SALES</b></p>

<div class="cart-section mt-50 mb-150">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="cart-table-wrap table-hover">
                    <form action="salesaction.jsp" method="POST">
                        <table class="cart-table">
                            <thead class="cart-table-head">
                                <tr class="table-head-row table-danger">
                                    <th class="product-remove">Index No</th>
                                    <th class="product-name">Name</th>
                                    <th class="product-name">Desc</th>
                                    <th class="product-price">Price</th>
                                    <th class="product-price">Available Stock</th>
                                    <th class="product-quantity">Required Quantity</th>
                                    <th class="product-total">Total</th>
                                    <th class="product-total">Cancel</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int slno = 0;
                                    double subtotal = 0;

                                    try {
                                        String loginid = (String) session.getAttribute("loginid");
                                        Connection con = ShopClass.getCon();
                                        PreparedStatement ps = null;
                                        ResultSet rs = null;

                                        String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid=?";
                                        ps = con.prepareStatement(shopidQuery);
                                        ps.setString(1, loginid);
                                        ResultSet shopIdResultSet = ps.executeQuery();
                                        String shopId = "";
                                        if (shopIdResultSet.next()) {
                                            shopId = shopIdResultSet.getString("Shopid");
                                            String selectedProductsQuery = "SELECT * FROM tbl_selectedproducts ts INNER JOIN tbl_shpproducts tsp ON ts.productid=tsp.shpproductid INNER JOIN tbl_unit tuu ON tuu.unitid=tsp.prdunit INNER JOIN tbl_shop tss ON ts.shopid=tss.shopid WHERE ts.shopid=? AND ts.status='Selected'";
                                            ps = con.prepareStatement(selectedProductsQuery);
                                            ps.setString(1, shopId);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                String prdname = rs.getString("prdname");
                                                String prddesc = rs.getString("prddesc");
                                                String productid = rs.getString("productid");
                                                double prdprice = Double.parseDouble(rs.getString("prdprice"));
                                                double prdstock = Double.parseDouble(rs.getString("prdstock"));
                                                double prdquantity = 0;
                                                double prdtotal = 0;
                                %>
                                <tr class="table-body-row">
                            <input type="hidden" name="shpproductid[]" value="<%= productid%>">
                            <input type="hidden" name="prdquantity[]" value="<%= prdquantity%>">
                            <input type="hidden" name="prdtotal[]" value="<%= prdtotal%>">
                            <input type="hidden" name="Prdstock[]" value="<%= prdstock%>">

                            <input type="hidden" name="shopid" value="<%= shopId%>">
                            <td class="product-index"><%= ++slno%></td>
                            <td class="product-name"><%= prdname%></td>
                            <td class="product-name"><%= prddesc%></td>
                            <td class="product-price"><%= prdprice%></td>
                            <td class="product-price"><%= prdstock%> <%= rs.getString("unitname")%></td>
                            <td class="product-quantity">
                                <input type="number" min="1" id="Quantity<%= slno%>" name="quantity[]" placeholder="0" onchange="updateTotal(<%= slno%>)" oninput="this.value = Math.abs(this.value)">
                            </td>
                            <td class="product-total">
                                <input type="number" name="total[]" id="total<%= slno%>" readonly>
                            </td>
                            <td class="product-remove">
                                <a href="removeselected.jsp?id=<%= rs.getString("selectid")%>">
                                    <i class="far fa-window-close"></i>
                                </a>
                            </td>
                            </tr>
                            <%
                                            subtotal += prdtotal;
                                        }
                                    } else {
                                        response.sendRedirect("../GUEST/Guestindex.jsp");
                                    }
                                    shopIdResultSet.close();
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (ps != null) {
                                        ps.close();
                                    }
                                    con.close();
                                } catch (Exception e) {
                                    out.println("Exception occurred: " + e.getMessage());
                                    e.printStackTrace();
                                }
                            %>
                            </tbody>
                        </table>
                        <br>
                        <div class="row">
                            <div class="col-lg-8"></div>
                            <div class="col-lg-4">
                                <div class="total-section">
                                    <table class="total-table">
                                        <thead class="total-table-head">
                                            <tr class="table-total-row table-danger">
                                                <th>Total</th>
                                                <th>Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="total-data">
                                                <td><strong>Subtotal: </strong></td>
                                                <td>&#x20B9;<span id="subtotalDisplay"><%= subtotal%></span></td>
                                            </tr>
                                        <input type="hidden" name="subtotalDisplay" id="subtotal" value="<%= subtotal%>">
                                        </tbody>
                                    </table>
                                    <div class="cart-buttons">
                                        <input type="submit" value="Print Bill" class="boxed-btn">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="Shopfooter.jsp" />

<script>
    function updateTotal(index) {
        var quantityInput = document.getElementById('Quantity' + index);
        var totalInput = document.getElementById('total' + index);
        var row = quantityInput.parentNode.parentNode;
        var price = parseFloat(row.querySelector('.product-price').innerText);
        var quantity = parseFloat(quantityInput.value);
        var prdstock = parseFloat(row.querySelector('.product-price').nextElementSibling.innerText);

        if (quantity > prdstock) {
            alert('No stock available.');
            quantityInput.value = prdstock; // Reset the quantity to the available stock
            quantity = prdstock;
        }

        var total = price * quantity;
        totalInput.value = total.toFixed(2);

        calculateSubtotal();
    }

    function calculateSubtotal() {
        var quantityInputs = document.querySelectorAll('.product-quantity input');
        var totalInputs = document.querySelectorAll('.product-total input');
        var subtotal = 0;

        for (var i = 0; i < quantityInputs.length; i++) {
            var quantity = parseFloat(quantityInputs[i].value);
            var total = parseFloat(totalInputs[i].value);

            if (!isNaN(quantity) && !isNaN(total)) {
                subtotal += total;
            }
        }

        document.getElementById('subtotal').value = subtotal.toFixed(2);
        document.getElementById('subtotalDisplay').innerText = subtotal.toFixed(2);

        calculateTotal();
    }

</script>

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


<!--<div class="col-md-10">
    <div class="single-product-content">
        <div class="contact-from-section mt-500 mb-150">
            <div class="container" id="bill">
                <div class="row">
                    <div class="col-lg-12" id="details">
                        <style>
                            h2 {
                                text-align: center;
                                color: #333;
                            }

                            form {
                                max-width: 800px;
                                margin: 0 auto;
                                padding: 20px;
                                background-color: #fff;
                                border-radius: 5px;
                                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                display: grid;
                                grid-template-columns: repeat(2, 1fr);
                                grid-gap: 20px;
                            }

                            label {
                                color: #333;
                                font-weight: bold;
                            }

                            input[type="text"],
                            input[type="email"],
                            input[type="number"],
                            textarea {
                                width: 100%;
                                padding: 10px;
                                border: 1px solid #ccc;
                                border-radius: 4px;
                                box-sizing: border-box;
                            }

                            input[type="submit"] {
                                width: 100%;
                                background-color: #4CAF50;
                                color: white;
                                padding: 10px;
                                border: none;
                                border-radius: 4px;
                                cursor: pointer;
                                font-weight: bold;
                            }

                            input[type="submit"]:hover {
                                background-color: #4CAF50;
                            }

                            .form-row {
                                display: grid;
                                grid-gap: 20px;
                            }
                            input[type="date"] {
                                width: 100%;
                                padding: 10px;
                                border: 1px solid #ccc;
                                border-radius: 4px;
                                box-sizing: border-box;
                                appearance: textfield; /* Add this line for better cross-browser support */
                            }
                            


                            .form-row label {
                                display: block;
                            }
                        </style>
                        <form action="requestaction.jp" method="post">
<%
//    String billNo = request.getParameter("billno");
//    Date dNow = new Date();
//    SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
//    if (billNo != null) {
//        try {
//            String Query1 = "SELECT * FROM tbl_billmaster tb INNER JOIN tbl_shop ts ON tb.shopid=ts.shopid INNER JOIN tbl_billdetails tbd ON tb.Billid=tbd.billno INNER JOIN tbl_product tp ON tbd.productid=tp.cpyproductid INNER JOIN tbl_company tc on tb.shopid=tc.cpyid INNER JOIN tbl_city tcc ON tc.city=tcc.cityid INNER JOIN tbl_district td on tc.district=td.districtid INNER JOIN tbl_unit tu on tp.cpyprdunit=tu.unitid INNER JOIN tbl_category tca on tp.categoryid=tca.categoryid INNER JOIN tbl_subcategory tsa on tp.subcategoryid=tsa.subcategoryid  WHERE tb.Billid='" + billNo + "'  AND tb.status='Paid'";
//            ResultSet rst = st.executeQuery(Query1);
//            while (rst.next()) {
%>
<div>
    <div>
        <label>Bill Generated Date:</label>
        <input type="date" id="price" value="<%=rst.getString("confirmeddate")%>" name="price" readonly>
    </div>
    <div>
        <label>Company Name:</label>
        <input type="text" id="cpyname" value="<%=rst.getString("cpyname")%>" name="cpyname" readonly >
    </div>
    <div>
        <label>SubCategory:</label>
        <input type="text" id="subcategory" name="subcategory" value="<%=rst.getString("subcategoryname")%>" >
    </div>
    <div>
        <label>Quantity:</label>
        <input type="text" id="quantity" value="<%=rst.getString("quantity")%>" name="quantity" >
    </div>
    <div>
        <label>Mrp/pcs</label>
        <input type="number" id="totalamount" name="totalamount" >
    </div>
</div>
<div>
    <div>
        <label>Current Date:</label>
        <input type="date" id="currentdate" value="<%=ft.format(dNow)%>" name="currentdate" readonly>
    </div>
    <div>
        <label>Product:</label>
        <input type="text" id="product" value="<%=rst.getString("cpyproductname")%>" name="product" readonly>
    </div>
    <div>
        <label>Category:</label>
        <input type="text" id="category" value="<%=rst.getString("categoryname")%>" name="category" readonly>
    </div>
    <div>
        <label>Unit:</label>
        <input type="text" id="unit" value="<%=rst.getString("unitname")%>" name="unit" readonly>
    </div>
    <div>
        <label>Total Amount:</label>
        <input type="text" id="totalamount" value="<%=rst.getString("totalprice")%>" name="totalamount" readonly>
    </div>
</div>
<div>
    <input type="submit" value="Submit">
</div>
<%
            }
        } catch (Exception e) {
            out.println("exception");
        }
    }
%>
</form>
<%
} else {
// Handle case when bill number is not found
%>
<div class="alert alert-danger" role="alert">
    Bill number not found.
</div>
</div>
</div>
</div>
</div>
</div>
</div>-->


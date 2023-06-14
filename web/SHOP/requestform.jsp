<jsp:include page ="shoppingheader.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<div style="background-color: #07212e;height: 15%"></div>

<div class="single-product mt-60 mb-150">
    <p style="text-align: center;font-size: 35px;font-family: Copperplate Gothic;"><b>REQUEST FORM</b></p>
    <div class="container">
        <div class="row">
            <%
                try {
                    String loginid = (String) session.getAttribute("loginid");
                    int log = Integer.parseInt(loginid);
                    String id = request.getParameter("productid");
                    int num = Integer.parseInt(id);
                    Connection con = ShopClass.getCon();
                    Statement st = con.createStatement();
                    String Query = ("SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid INNER JOIN tbl_login tll ON tb.cmpyid = tll.loginid INNER JOIN tbl_company tcc ON tll.loginid = tcc.loginid where cpyproductid='" + num + "'");
                    ResultSet rs = st.executeQuery(Query);
                    while (rs.next()) {

            %>
            <div class="col-md-3">
                <div class="single-product-img">
                    <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-90 align-content-center" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 300px" alt="First slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-90" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg2")%>' style="height: 300px" alt="Second slide">
                            </div>
                            <div class="carousel-item">
                                <img class="d-block w-90" src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg3")%>' style="height: 300px" alt="Second slide">
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="single-product-content">
                    <div class="contact-from-section mt-500 mb-150">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12">
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
                                            background-color: #45a049;
                                        }
                                    </style>
                                    <form action="requestaction.jsp" method="post">
                                        <div>
                                            <label>Product Name:</label>
                                            <input type="text" id="name" name="name"  value="<%=rs.getString("cpyproductname")%>" readonly>
                                            <label>Product Description:</label>
                                            <input type="text" id="prddesc" name="prddesc" value="<%=rs.getString("cpyproductdesc")%>" readonly>
                                            <label>Company Name</label>
                                            <input type="text" id="cpyname" name="cpyname" value="<%=rs.getString("cpyname")%>" readonly>
                                            <label>Product Price</label>
                                            <input type="text" id="price" name="price" value="<%=rs.getString("cpyprdprice")%>" readonly>

                                            <input type="hidden" name="productid" id="productid" value="<%= rs.getString("cpyproductid")%>">
                                            <input type="hidden" name="companyid" id="comid" value="<%= rs.getString("cpyid")%>">
                                            <input type="hidden" name="unit" id="unit" value="<%= rs.getString("unitname")%>">
                                            <input type="hidden" name="companyid" id="comid" value="<%= rs.getString("cpyid")%>">


                                            <%
                                                try {

                                                    String Query1 = ("SELECT * FROM tbl_login tl INNER JOIN tbl_shop ts ON tl.loginid = ts.loginid  where tl.loginid='" + log + "'");
                                                    ResultSet rst = st.executeQuery(Query1);
                                                    while (rst.next()) {

                                            %>
                                            <input type="hidden" id="shopid" name="shopid" value="<%=rst.getString("shopid")%>">

                                            <%                     }
                                                } catch (Exception e) {
                                                    out.println("exception");
                                                }
                                            %>

                                        </div>
                                        <div>
                                            <label>Quantity:</label>
                                            <input type="number" id="qty" name="qty" onchange="gettotal()" min="1" oninput="this.value = Math.abs(this.value)" >
                                            <p></p>
                                            <label>Additional Comments:</label>
                                            <textarea id="message" name="message"></textarea>
                                            <p></p>
                                            <div class="col-lg-3">
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
                                                                <td>&#8377;<input class="form-control" name="totalprice" id="totalprice" type="number" readonly></td>
                                                            </tr>

                                                        </tbody>
                                                    </table>                                                 
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <input type="submit" value="Submit">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

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

<script>
    function gettotal() {
        var val = document.getElementById('qty').value;
        var price = document.getElementById('price').value;
        var total = val * price;
        document.getElementById('totalprice').value = total;
//        grandtotal = total + 20;
//        document.getElementById('total').value = grandtotal;


    }
</script>






<jsp:include page ="Shopfooter.jsp"/>

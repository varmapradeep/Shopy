<jsp:include page="Shopheader.jsp" />
<%@ page import="java.sql.*" %>
<div style="background-color: #07212e; height: 15%"></div>
<%@ page import="shoppackages.ShopClass" %>
<% int slno = 0;%>       
<!DOCTYPE html>
<html>
    <head>
        <title>Billing Details</title>
        <style>
            /* CSS styles for the invoice */
            body {
                font-family: Arial, sans-serif;
            }

            .invoice {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
            }

            .invoice-header {
                text-align: center;
                margin-bottom: 20px;
            }

            .invoice-header h2 {
                margin: 0;
            }

            .row {
                display: flex;
                margin-bottom: 10px;
            }

            .column {
                flex: 1;
            }

            .section-heading {
                margin-bottom: 10px;
                font-weight: bold;
            }

            .section-content {
                margin-bottom: 20px;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
            }

            .product-table th,
            .product-table td {
                padding: 10px;
                border: 1px solid #ccc;
            }

            .product-table th {
                background-color: #f0f0f0;
                text-align: left;
            }

            .total-price {
                margin-top: 20px;
                text-align: right;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%
            try {
                String salesno = request.getParameter("salesno");
                String shopid = request.getParameter("shopid");
                Connection con = ShopClass.getCon();
                Statement st = con.createStatement();
                String Query = "SELECT * FROM tbl_sales s INNER JOIN tbl_shop ts ON s.shopid=ts.shopid INNER JOIN tbl_salesdetails sd ON sd.salesid=s.salesid INNER JOIN tbl_district td ON td.districtid=ts.district INNER JOIN tbl_city tc ON tc.cityid=ts.city INNER JOIN tbl_shpproducts tsp ON tsp.shpproductid=sd.productid INNER JOIN tbl_unit tuu ON tuu.unitid=sd.unit WHERE s.salesid='" + salesno + "' AND s.shopid='" + shopid + "'";

                ResultSet rs = st.executeQuery(Query);
        //        out.println(Query);
                while (rs.next()) {
        %>
        <br>
        <div class="invoice" style=" background-color:lightgrey">
            
            <div class="invoice-header">
                <h3>Shop Billing Details</h3>
            </div>
            <div class="row">
                <div class="column">
                    <div class="section-heading">Sales No: <%=rs.getString("salesid")%></div>
                </div>
            </div>

            <div class="row">
                <div class="column">
                    <div class="section-heading">Shop Details</div>
                    <div class="section-content">
                        <!-- Replace with appropriate code to display shop details -->
                        <p>Owner Name: <%=rs.getString("ownername")%></p>
                        <p>Shop Name: <%=rs.getString("shopname")%></p>
                        <p>District: <%=rs.getString("districtname")%></p>
                        <p>City: <%=rs.getString("cityname")%></p>
                        <p>Mobile No: <%=rs.getString("phoneno")%></p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="column">
                    <div class="section-heading">Order Details</div>
                    <div class="section-content">
                        <p>Sales Date: <b><%=rs.getString("salesdate")%></b></p>
                    </div>
                </div>
            </div>

            <div class="section-heading">Product Details</div>
            <div class="section-content">
                <table class="product-table">
                    <thead>
                        <tr>
                            <th>Index No</th>
                            <th>Product Name</th>
                            <th>Product Desc</th>
                            <th>Quantity</th>
                            <th>Product Price</th>
                            <!-- Add more table headers if needed -->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                String Query1 = "SELECT * FROM tbl_salesdetails ts INNER JOIN tbl_shpproducts tsp ON tsp.shpproductid=ts.productid INNER JOIN tbl_unit tu ON tu.unitid=tsp.prdunit WHERE ts.salesid='" + salesno + "'";
                                ResultSet rss = st.executeQuery(Query1);
                                while (rss.next()) {
                        %>
                        <tr>
                            <td><%=++slno%></td>
                            <td><%=rss.getString("prdname")%></td>
                            <td><%=rss.getString("prddesc")%></td>
                            <td><%=rss.getString("quantitity")%> <%=rss.getString("unitname")%></td>
                            <td><%=rss.getString("prdprice")%></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("Exception occurred: " + e.getMessage());
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="total-price">
                <%
                    try {
                        String loginid = (String) session.getAttribute("loginid");
                        String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
                        ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
                        String shopId = "";
                        if (shopIdResultSet.next()) {
                            shopId = shopIdResultSet.getString("Shopid");
                        } else {
                            response.sendRedirect("../GUEST/Guestindex.jsp");
                        }
                        shopIdResultSet.close();

                        String query = "SELECT * FROM tbl_sales t INNER JOIN tbl_shop ts ON ts.shopid=t.shopid WHERE t.salesid='" + salesno + "' AND t.status='Pending'";
                        ResultSet rst = st.executeQuery(query);

                        if (rst.next()) {
                            double totalAmount = rst.getDouble("totalprice");
                %>
                <p>Total: <b><%=totalAmount%></b></p>
                <%
                        }
                    } catch (Exception e) {
                        out.println("Exception occurred: " + e.getMessage());
                    }
                %>
            </div>
            <button class="print-button" onclick="printInvoice()">Print Invoice</button>
            <p></p>
            <button class="print-button" onclick="cancel()">Cancel</button>
        </div>
           
        <script>
            function cancel() {
                alert("cancel printing the bill");
                window.location = "sales.jsp";
            }

            function printInvoice() {
                var invoiceContent = document.querySelector(".invoice").innerHTML;
                var printWindow = window.open("", "_blank");
                printWindow.document.open();
                printWindow.document.write('<html><head><title>Billing Details</title>');
                printWindow.document.write('<style>');
                printWindow.document.write('body {');
                printWindow.document.write('    font-family: Arial, sans-serif;');
                printWindow.document.write('    padding: 20px;');
                printWindow.document.write('}');
                printWindow.document.write('.invoice {');
                printWindow.document.write('    max-width: 800px;');
                printWindow.document.write('    margin: 0 auto;');
                printWindow.document.write('    border: 1px solid #ccc;');
                printWindow.document.write('}');
                printWindow.document.write('.invoice-header, .total-price, .print-button {');
                printWindow.document.write('    display: none;');
                printWindow.document.write('}');
                printWindow.document.write('.row {');
                printWindow.document.write('    display: flex;');
                printWindow.document.write('    margin-bottom: 10px;');
                printWindow.document.write('}');
                printWindow.document.write('.column {');
                printWindow.document.write('    flex: 1;');
                printWindow.document.write('}');
                printWindow.document.write('.section-heading {');
                printWindow.document.write('    margin-bottom: 10px;');
                printWindow.document.write('    font-weight: bold;');
                printWindow.document.write('}');
                printWindow.document.write('.section-content {');
                printWindow.document.write('    margin-bottom: 20px;');
                printWindow.document.write('}');
                printWindow.document.write('.product-table {');
                printWindow.document.write('    width: 100%;');
                printWindow.document.write('    border-collapse: collapse;');
                printWindow.document.write('}');
                printWindow.document.write('.product-table th, .product-table td {');
                printWindow.document.write('    padding: 10px;');
                printWindow.document.write('    border: 1px solid #ccc;');
                printWindow.document.write('}');
                printWindow.document.write('.product-table th {');
                printWindow.document.write('    background-color: #f0f0f0;');
                printWindow.document.write('    text-align: left;');
                printWindow.document.write('}');
                printWindow.document.write('.total-price {');
                printWindow.document.write('    margin-top: 20px;');
                printWindow.document.write('    text-align: right;');
                printWindow.document.write('    font-weight: bold;');
                printWindow.document.write('}');
                printWindow.document.write('</style>');
                printWindow.document.write('</head><body>');
                printWindow.document.write(invoiceContent);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.onload = function() {
                    printWindow.document.querySelector(".invoice-header").style.display = "none";
                    printWindow.document.querySelector(".total-price").style.display = "block";
                    printWindow.document.querySelector(".print-button").style.display = "none";
                    printWindow.print();
                    printWindow.close();
                };
            }
        </script>
        <br>
        <%
                }
            } catch (Exception e) {
//                out.println("Exception occurred: " + e.getMessage());
            }
        %>

    </body>
</html>

<jsp:include page="Shopfooter.jsp" />

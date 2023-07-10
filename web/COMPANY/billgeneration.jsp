<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<jsp:include page="Companyindex.jsp" />
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
                String billId = request.getParameter("billId");
                String cmpid = request.getParameter("cmpid");
                Connection con = ShopClass.getCon();
                Statement st = con.createStatement();
                String Query = "SELECT * FROM tbl_billmaster tb INNER JOIN tbl_shop ts ON tb.shopid=ts.shopid INNER JOIN tbl_billdetails tbb on tbb.billno=tb.Billid INNER JOIN tbl_district td on ts.district=td.districtid INNER JOIN tbl_city tc ON ts.city=tc.cityid INNER JOIN tbl_product tp on tbb.productid=tp.cpyproductid INNER JOIN tbl_unit tu ON tp.cpyprdunit=tu.unitid INNER JOIN tbl_company tcc ON tcc.cpyid=tb.companyid WHERE tb.Billid='" + billId + "'AND tb.companyid='" + cmpid + "'";

//                                out.println(Query);
                ResultSet rs = st.executeQuery(Query);
                while (rs.next()) {
        %>
        <div class="invoice">
            <div class="invoice-header">
                <h1>Billing Details</h1>
            </div>
            <div class="row">
                <div class="column">
                    <div class="section-heading">Bill No: <%=rs.getString("Billid")%></div>

                </div>
            </div>

            <div class="row">

                <div class="column">
                    <div class="section-heading">Shop Details</div>
                    <div class="section-content">
                        <!-- Replace with appropriate code to display shop details -->
                        <p>Owner Name:<%=rs.getString("ownername")%></p>
                        <p>Shop Name:<%=rs.getString("shopname")%></p>
                        <p>District:<%=rs.getString("districtname")%> </p>
                        <p>City:<%=rs.getString("cityname")%> </p>
                        <p>Mobile No:<%=rs.getString("phoneno")%> </p>

                    </div>
                </div>

                <div class="column">
                    <div class="section-heading">Company Details</div>
                    <div class="section-content">
                        <!-- Replace with appropriate code to display company details -->
                        <p>Company Reg No:<%=rs.getString("regno")%> </p>
                        <p>Company Name:<%=rs.getString("cpyname")%></p>
                        <p>District:<%=rs.getString("districtname")%> </p>
                        <p>City:<%=rs.getString("cityname")%> </p>
                        <p>Mobile No:<%=rs.getString("phone")%> </p>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="column">
                    <div class="section-heading">Order Details</div>
                    <div class="section-content">
                        <p>Order confirmed date: <b><%=rs.getString("confirmeddate")%></b></p>

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
                                String Query1 = "SELECT * FROM tbl_billdetails tb INNER JOIN tbl_product tp ON tb.productid=tp.cpyproductid INNER JOIN tbl_unit tu ON tu.unitid=tp.cpyprdunit WHERE tb.billno='" + billId + "'";
                                ResultSet rss = st.executeQuery(Query1);
                                while (rss.next()) {
                        %>

                        <tr>
                            <td><%=++slno%></td>
                            <td><%=rss.getString("cpyproductname")%></td>
                            <td><%=rss.getString("cpyproductdesc")%></td>
                            <td><%=rss.getString("quantity")%> <%=rss.getString("unitname")%></td>
                            <td><%=rss.getString("cpyprdprice")%></td>

                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("exception");
                            }
                        %> 
                    </tbody>
                </table>
                <div class="total-price">


                    <%
                        try {
                            String shopidQuery = "SELECT Shopid FROM tbl_billmaster WHERE Billid='" + billId + "'";
                            ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
                            String shopId = "";
                            if (shopIdResultSet.next()) {
                                shopId = shopIdResultSet.getString("Shopid");
                                System.out.println(shopId);
                            } else {
                                out.println("No shop ID found for bill number: " + billId);
                            }
                            shopIdResultSet.close();

                            String query = "SELECT * FROM tbl_billmaster tb INNER JOIN tbl_shop ts ON tb.shopid=ts.shopid WHERE tb.Billid='" + billId + "' AND tb.status='Pending'";
                            ResultSet rst = st.executeQuery(query);

                            if (rst.next()) {
                                double totalAmount = rst.getDouble("totalprice");

                                String balanceQuery = "SELECT Balance FROM tbl_billmaster WHERE shopid='" + shopId + "' AND Billid < '" + billId + "' ORDER BY Billid DESC LIMIT 1";
                                ResultSet balanceResultSet = st.executeQuery(balanceQuery);
                                double previousDue = 0;
                                if (balanceResultSet.next()) {
                                    previousDue = balanceResultSet.getDouble("Balance");
                                }
                                balanceResultSet.close();

                                double grandTotal = totalAmount + previousDue;
                    %>

                    <p>Total: <b><%=totalAmount%></b></p>
                    <p>Previous Balance: <b><%=previousDue%></b></p>
                    <p>Grand Total: <b><%=grandTotal%></b></p>

                    <%
                            }
                        } catch (Exception e) {
                            out.println("exception");
                        }
                    %> 
                </div>
                <button class="print-button" onclick="printInvoice()">Print Invoice</button>
                <p></p>
                <button class="print-button" onclick="cancel()">Cancel</button>

                <script>
                    function cancel() {
                        alert("cancell printing the bill");
                        window.location = "viewrequestsbyshop.jsp";

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


            </div>
            <%
                    }
                } catch (Exception e) {
                    //                out.println("exception");
                }
            %> 


    </body>
</html>










<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<div class="col-md-8 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <h4 class="card-title" style="text-align: center">Payment Form</h4>

            <% 
            try {
                String billNo = request.getParameter("billno");
                Connection con = ShopClass.getCon();
                Statement st = con.createStatement();
                String shopidQuery = "SELECT Shopid FROM tbl_billmaster WHERE Billid='" + billNo + "'";
                ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
                String shopId = "";
                if (shopIdResultSet.next()) {
                    shopId = shopIdResultSet.getString("Shopid");
                    System.out.println(shopId);
                } else {
                    out.println("No shop ID found for bill number: " + billNo);
                }
                shopIdResultSet.close();

                String query = "SELECT * FROM tbl_billmaster tb INNER JOIN tbl_shop ts ON tb.shopid=ts.shopid WHERE tb.Billid='" + billNo + "' AND tb.status='Pending'";
                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {
                    String ownerName = rs.getString("ownername");
                    String shopName = rs.getString("shopname");
                    double totalAmount = rs.getDouble("totalprice");

                    String balanceQuery = "SELECT Balance FROM tbl_billmaster WHERE shopid='" + shopId + "' AND Billid < '" + billNo + "' ORDER BY Billid DESC LIMIT 1";
                    ResultSet balanceResultSet = st.executeQuery(balanceQuery);
                    double previousDue = 0;
                    if (balanceResultSet.next()) {
                        previousDue = balanceResultSet.getDouble("Balance");
                    }
                    balanceResultSet.close();

                    double grandTotal = totalAmount + previousDue;
            %>
            <form class="forms-sample" action="PaymentDetailsaction.jsp" method="post">
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Bill No</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" value="<%= billNo%>" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Owner Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" value="<%= ownerName%>" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Shop Name</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" value="<%= shopName%>" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Total Amount</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" value="<%= totalAmount%>" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Previous Due</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="previousDue" value="<%= previousDue%>" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Grand Total</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" value="<%= grandTotal%>" readonly>
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Received Amount</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="receivedAmount" id="receivedAmount" placeholder="Amount Received">
                    </div>
                </div>

                <input type="hidden" name="billNo" value="<%= billNo%>">
                <input type="hidden" name="ownerName" value="<%= ownerName%>">
                <input type="hidden" name="shopName" value="<%= shopName%>">
                <input type="hidden" name="totalAmount" value="<%= totalAmount%>">
                <input type="hidden" name="previousDue" value="<%= previousDue%>">
                <input type="hidden" name="grandTotal" value="<%= grandTotal%>">

                <button type="submit" class="btn btn-primary mr-2">Submit</button>
            </form>
            <% 
            } else {
                // Handle case when bill number is not found
            %>
            <div class="alert alert-danger" role="alert">
                Bill number not found.
            </div>
            <% 
            }
            rs.close();
            st.close();
            con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </div>
    </div>
</div>
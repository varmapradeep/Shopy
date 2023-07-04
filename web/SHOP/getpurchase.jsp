<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>

<%
    int slno = 0;
    String billNo = request.getParameter("id");

    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String query = "SELECT * FROM tbl_billmaster tb INNER JOIN tbl_shop ts ON tb.shopid=ts.shopid INNER JOIN tbl_billdetails tbd ON tb.Billid=tbd.billno INNER JOIN tbl_product tp ON tbd.productid=tp.cpyproductid INNER JOIN tbl_unit tu ON tp.cpyprdunit=tu.unitid INNER JOIN tbl_unit tuu ON tuu.unitid=tp.cpyprdunit INNER JOIN tbl_company tc ON tb.companyid=tc.cpyid WHERE tb.Billid='" + billNo + "'";
        ResultSet rs = st.executeQuery(query);

        // Check if the bill number exists
        if (!rs.next()) {
%>
<div class="alert alert-danger" role="alert">
    Bill number not found.
</div>
<%
} else {
%>
<form>
    <div class="col-lg-12 col-md-12">
        <div class="cart-table-wrap">
            <table class="cart-table">
                <thead class="cart-table-head">
                    <tr class="table-head-row">
                        <th class="product-image">Index no</th>
                        <th class="product-image">Company</th>
                        <th class="product-name">Product Name</th>
                        <th class="product-desc">Product description</th>
                        <th class="product-price">Total Price</th>
                        <th class="product-total">Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Reset the ResultSet cursor
                        rs.beforeFirst();

                        while (rs.next()) {
                    %>
                    <tr class="table-body-row">
                        <td><%=++slno%></td>
                        <td class="product-unit"><%=rs.getString("cpyname")%></td>
                        <td class="product-unit"><img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"><br><%=rs.getString("cpyproductname")%></td>
                        <td class="product-unit"><%=rs.getString("cpyproductdesc")%></td>
                        <td class="product-unit"><%=rs.getString("totalprice")%></td>
                        <td class="product-unit"><%=rs.getString("quantity")%> <%=rs.getString("unitname")%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                
            </table>
                
                <br>
                <div style="display: grid; alignment-adjust: baseline">
                    <button type="button" class="btn btn-info">Confirm</button>
                </div>
                </form>
                <%
                        }
                    } catch (Exception e) {
                        out.println("exception");
                    }
                %>

<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%
    int slno = 0;
%>


<div class="col-md-12 grid-margin stretch-card">
    <div class="card"  id="display">
        <div class="card-body">
            <p class="card-title mb-0"></p>
            <div class="table-responsive">
                <table class="table table-hover table-borderless">
                    <thead>
                        <tr>
                            <th>Index No</th>
                            <th>Product Name</th>
                            <th>Product Description</th>                           
                            <th>Available stock</th>
                            <th>Price/Unit</th>
                            <th>Add to Cart<th>

                        </tr>
                    </thead>

                    <tbody> 
                        <%
                            try {
                                String loginid = (String) session.getAttribute("loginid");
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();

                                String shopidQuery = "SELECT Shopid FROM tbl_login tl INNER JOIN tbl_shop ts ON ts.loginid=tl.loginid WHERE tl.loginid='" + loginid + "'";
                                ResultSet shopIdResultSet = st.executeQuery(shopidQuery);
                                String shopId = "";
                                if (shopIdResultSet.next()) {
                                    shopId = shopIdResultSet.getString("Shopid");
                                } else {
                                    response.sendRedirect("../GUEST/Guestindex.jsp");

                                }
                                String subcat = request.getParameter("val");
                                String catid = request.getParameter("value");

                                String Query = "SELECT * FROM tbl_shpproducts ts INNER JOIN tbl_shop s ON ts.prdshopid=s.shopid INNER JOIN tbl_subcategory tsub ON tsub.subcategoryid=ts.subcategory INNER JOIN tbl_category tcat ON tcat.categoryid=ts.category INNER JOIN tbl_unit tu ON tu.unitid=ts.prdunit WHERE tsub.subcategoryid='" + subcat + "' AND tcat.categoryid='" + catid + "' AND ts.prdshopid='" + shopId + "'  ORDER BY prdregdate DESC;";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {

                        %>
                        <tr>

                            <td class="align-middle"><%=++slno%></td>
                            <td class="align-middle"><%=rs.getString("prdname")%></td>
                            <td class="align-middle"><%=rs.getString("subcategoryname")%></td>
                            <td class="align-middle"><%=rs.getString("prdstock")%> <%=rs.getString("unitname")%></td>
                            <td class="align-middle"><%=rs.getString("prdprice")%></td>
                            <td class="align-middle">
                                <a href="selectproduct.jsp?productid=<%=rs.getString("shpproductid")%>" onclick="updateLink(this);
                                        class ="bi bi-plus" style="font-size: 30px">+</a>
                            </td>
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
        </div>
    </div>
</div> 


<script>
    function updateLink(link) {
        link.innerHTML = '&#10004;'; // HTML entity for the tick mark symbol
    }
</script>
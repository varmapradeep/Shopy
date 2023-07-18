<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%
    int slno = 0;
%>
<%
    try {
        String loginid = (String) session.getAttribute("loginid");
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String subcat = request.getParameter("val");
        String catid = request.getParameter("value");

        String Query = "SELECT * FROM tbl_shpproducts ts INNER JOIN tbl_shop s ON ts.prdshopid=s.shopid INNER JOIN tbl_subcategory tsub ON tsub.subcategoryid=ts.subcategory INNER JOIN tbl_category tcat ON tcat.categoryid=ts.category INNER JOIN tbl_unit tu ON tu.unitid=ts.prdunit WHERE tsub.subcategoryid='" + subcat + "' AND tcat.categoryid='" + catid + "'  ORDER BY prdregdate DESC;";
        ResultSet rs = st.executeQuery(Query);
        while (rs.next()) {

//            out.println(Query);
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div> 

<%
        }
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());

    }

%>
<script>
    function updateLink(link) {
        link.innerHTML = '&#10004;'; // HTML entity for the tick mark symbol
    }
</script>
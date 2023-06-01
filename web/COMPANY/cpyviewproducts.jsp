<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>

<% int slno = 0;%>    
<div class="col-sm-10 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <p class="card-title mb-6" style="text-align: center"><u><b>OUR PRODUCTS</b></u></p>
            <div class="table-responsive">
                <table class="table table-striped table-borderless">
                    <thead>
                        <tr>
                            <th>Index No</th>
                            <th>Image</th>
                            <th>Product name</th>
                            <th>Product Description</th>
                            <th>Category</th>
                            <th>Sub Category</th>
                            <th>Available Stock</th>
                            <th>Price/Unit</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>  
                    </thead>
                    <tbody>
                        <%
                            try {
                                String loginid = (String) session.getAttribute("loginid");
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = "SELECT * from tbl_product tb INNER JOIN tbl_category tc on tb.categoryid=tc.categoryid INNER JOIN tbl_subcategory ts ON tb.subcategoryid = ts.subcategoryid INNER JOIN tbl_unit tu ON tb.cpyprdunit=tu.unitid WHERE cmpyid='" + loginid + "'";
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%=++slno%></td>
                            <td><img src='../COMPANY/images/Product/<%=rs.getString("cpyproductimg1")%>' style="height: 80px;width: 80px"></td>
                            <td><%=rs.getString("cpyproductname")%></td>
                            <td><textarea readonly rows="4" cols="40" style="border: none;background-color: transparent;line-height: 1.1;"><%=rs.getString("cpyproductdesc")%></textarea></td>
                            <td><%=rs.getString("categoryname")%></td>
                            <td><%=rs.getString("subcategoryname")%></td>
                            <td><%=rs.getString("cpyprdstock")%><%=rs.getString("unitname")%></td>
                            <td><%=rs.getString("cpyprdprice")%>Rs</td>
                            <td> <a class="btn btn-info" onclick="return confirm('Do u want to Edit Product?')" href="../COMPANY/cpyproductedit.jsp?productid=<%=rs.getString("cpyproductid")%>" ><i class="ti-pencil btn-icon-prepend"></i></a></td>
                            <td> <a class="btn btn-danger" onclick="return confirm('Do u want to Delete Product?')" href="../COMPANY/Categorydelete.jsp?productid=<%=rs.getString("cpyproductid")%>" ><i class="ti-trash btn-icon-prepend"></i></a></td>                   
                        </tr>
                    <td></td>

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
    </div>
</div>









<!-- plugins:js -->
<script src="vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="vendors/chart.js/Chart.min.js"></script>
<script src="vendors/datatables.net/jquery.dataTables.js"></script>
<script src="vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
<script src="js/dataTables.select.min.js"></script>

<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="js/off-canvas.js"></script>
<script src="js/hoverable-collapse.js"></script>
<script src="js/template.js"></script>
<script src="js/settings.js"></script>
<script src="js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="js/dashboard.js"></script>
<script src="js/Chart.roundedBarCharts.js"></script>


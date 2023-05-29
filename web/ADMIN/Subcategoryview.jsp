<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<% int slno = 0;%>    

<div class="white_shd full margin_bottom_30">
    <div class="full graph_head">
        <div class="heading1 margin_0 ">
            <h2><b> Sub-CATEGORIES</b></h2>
        </div>
        <div class="dash_head">
            <h3><span><i class="fa fa-comments-o"></i> Sub-Category View</span><span class="plus_green_bt"><a href="Subcategory.jsp">+</a></span></h3>
              <div class="form-outline mb">
            <label class="label_field">Select Category</label>
            <select class="select form-control" name="Cate"  style="width: 20%; display: inline-grid;">
                <option disabled selected value="">Select Category</option>
                

            </select>

        </div>
        </div>
    </div>

    <div class="table_section padding_infor_info">
        <div class="table-responsive-sm">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Index No</th>
                        <th>Sub-Category Image</th>
                        <th>Sub-Category Name</th>
                        <th>Sub-Category Description</th>
                        <th>Category Selected</th>
                        <th>Edit</th>
                        <th>Delete</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "SELECT * FROM tbl_subcategory ts INNER JOIN tbl_category tc ON ts.categoryid=tc.categoryid";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%=++slno%></td>
                        <td><img src='../ADMIN/images/subcategoryimg/<%=rs.getString("subcategoryimg")%>' width="110" height="80"></td>
                        <td><%=rs.getString("subcategoryname")%></td>
                        <td><%=rs.getString("subcategorydesc")%></td>
                        <td><%=rs.getString("categoryname")%></td>

                        <td class="w3-xlarge"> <a onclick="return confirm('Do u want to Edit Sub-Category?')" href="Subcategoryedit.jsp?id=<%=rs.getString("categoryid")%>" class="fa fa-edit"></a></td>
                        <td class="w3-xlarge"> <a onclick="return confirm('Do u want to delete this Sub-Category?')" href="SubCategorydelete.jsp?subid=<%=rs.getString("subcategoryid")%>" class="fa fa-trash"></a></td>

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
</div>
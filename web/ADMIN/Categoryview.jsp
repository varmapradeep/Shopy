<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<% int slno = 0;%>    

<div class="white_shd full margin_bottom_30">
    <div class="full graph_head">
        <div class="heading1 margin_0 ">
            <h2><b>CATEGORIES</b></h2>
        </div>
        <div class="dash_head">
            <h3><span><i class="fa fa-comments-o"></i> Category View</span><span class="plus_green_bt"><a href="Category.jsp">+</span></h3>
        </div>
    </div>
    
    <div class="table_section padding_infor_info">
        <div class="table-responsive-sm">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Index No</th>
                        <th>Category Image</th>
                        <th>Category Name</th>
                        <th>Categorydec</th>
                        <th>Edit</th>
                        <th>Delete</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "select * from tbl_category";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%=++slno%></td>
                        <td><img src='../ADMIN/images/categoryimg/<%=rs.getString("categoryimage")%>' width="100" height="80"></td>
                        <td><%=rs.getString("categoryname")%></td>
                        <td><%=rs.getString("Categorydec")%></td>
                        <td class="w3-xlarge"> <a onclick="return confirm('Do u want to Edit Category?')" href="../ADMIN/Categoryedit.jsp?eid=<%=rs.getString("categoryid")%>" class="fa fa-edit"></a></td>
                        <td class="w3-xlarge"> <a onclick="return confirm('Do u want to delete?')" href="../ADMIN/Categorydelete.jsp?id=<%=rs.getString("categoryid")%>" class="fa fa-trash"></a></td>

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
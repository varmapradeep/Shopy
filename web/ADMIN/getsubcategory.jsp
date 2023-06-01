<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<% int slno = 0;%>    
<table class="table">
            <thead class="thead-dark">
                <tr>
                    <th>Index No</th>
                    <th>Sub-Category Image</th>
                    <th>Sub-Category Name</th>
                    <th>Sub-Category Description</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = ShopClass.getCon();
                        Statement st = con.createStatement();
                        String subcategoryid = request.getParameter("id");
                        String Query = "select * from tbl_subcategory where categoryid='" + subcategoryid + "'";
                        ResultSet rs = st.executeQuery(Query);
                        while (rs.next()) {
                %>
                <tr>
                    <td><%=++slno%></td>
                    <td><img src='../ADMIN/images/subcategoryimg/<%=rs.getString("subcategoryimg")%>' width="110" height="80"></td>
                    <td><%=rs.getString("subcategoryname")%></td>
                    <td><%=rs.getString("subcategorydesc")%></td>

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







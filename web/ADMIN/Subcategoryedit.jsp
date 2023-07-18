<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<body class="inner_page login">
    <div class="full_container">
        <div class="container">
            <div class="center verticle_center full_height">
                <div class="login_section">
                    <div class="logo_login">
                        <div class="center">
                            <img width="210" src="images/logo/logo1.png" alt="#" />
                        </div>
                    </div>

                    <div class="login_form">
                        <%
                            try {
                                String id = request.getParameter("id");
                                int num = Integer.parseInt(id);
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = ("select * from tbl_subcategory ts INNER JOIN tbl_category tc ON ts.categoryid=tc.categoryid where subcategoryid='" + num + "'");
                                ResultSet rs = st.executeQuery(Query);
                                if (rs.next()) {
                                    String category = rs.getString("categoryname");

                        %>
                        <form action="../ADMIN/Subcategoryeditaction.jsp" method="post" enctype="multipart/form-data">
                            <div class="field">
                                <div class="form-outline mb">
                                    <label class="label_field">Category</label>
                                    <select class="select form-control" name="Category" style="width: 65%; display: inline-grid;">
                                        <option disabled selected value=""><%=rs.getString("categoryname")%></option>
                                        <% try {
                                                String query = "SELECT * FROM tbl_category";
                                                ResultSet rs1 = st.executeQuery(query);
                                                while (rs1.next()) {
                                                    String categoryId = rs1.getString("categoryid");
                                                    String categoryName = rs1.getString("categoryname");
                                                    boolean isSelected = categoryName.equals(category); // Fix the variable name to "category"

                                                    if (isSelected) {
                                        %>
                                        <option value="<%= categoryId%>" selected><%= categoryName%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%= categoryId%>"><%= categoryName%></option>
                                        <%
                                                    }
                                                }
                                                rs.close();
                                            } catch (Exception e) {
                                                out.println("Exception occurred: " + e.getMessage());
                                            }
                                        %>    
                                    </select>
                                </div>
                            </div>
                            <%
                                try {

                                    String Query2 = ("select * from tbl_subcategory  where subcategoryid='" + num + "'");
                                    ResultSet rs1 = st.executeQuery(Query2);

                                    if (rs1.next()) {
                            %>
                            <div class="field">
                                <label class="label_field">Sub Category</label>
                                <input type="text" name="Subcategory" value="<%=rs1.getString("subcategoryname")%>" placeholder="SubCategory Name" />
                            </div>
                            <div class="field">
                                <label class="label_field">Description</label>
                                <input type="text" name="subcategorydesc" value="<%=rs1.getString("subcategorydesc")%>" placeholder="SubCategory Description " />
                            </div>
                            <div class="field">
                                <label class="label_field">Upload Image</label>
                                <input type="file" name="subcatimg" value="<%=rs1.getString("subcategoryimg")%>" />
                            </div>
                            <div class="field">
                                <input type="hidden" name="id" value="<%=rs1.getString("subcategoryid")%>">
                            </div>
                            <div class="field margin_0">
                                <label class="label_field hidden">hidden label</label>

                                <button class="main_bt">Update Subcategory</button>
                            </div>


                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("error");
                                }
                            %>  
                        </form>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("error");
                            }
                        %>      

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
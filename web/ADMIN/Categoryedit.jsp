<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*"%>
<%@page import="shoppackages.ShopClass"%>

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

                                String id = request.getParameter("eid");
                                int num = Integer.parseInt(id);
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = ("select * from tbl_category where categoryid='" + num + "'");
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <form action="Categoryeditaction.jsp" method="post" enctype="multipart/form-data" >
                            <fieldset>
                                <div class="field">
                                    <label class="label_field">Category</label>
                                    <input type="text" name="Category" value="<%=rs.getString("categoryname")%>" placeholder="Category Name"/>
                                </div>
                                <div class="field">
                                    <label class="label_field">Description</label>
                                    <input type="text" name="Categorydec" value="<%=rs.getString("Categorydec")%>" placeholder="Category Description" />
                                </div>
                                <div class="field">
                                    <label class="label_field">Upload Image</label>
                                    <input type="file" name="Categoryimg" value="<%=rs.getString("categoryimage")%>" placeholder="Upload Image" />
                                </div>
                                <input type="text" value="<%=rs.getString("categoryimage")%>" id="Categoryimg" name="Categoryimg" >

                                <div class="field margin_0">
                                    <label class="label_field hidden">hidden label</label>
                                    <button class="main_bt">Update Category</button>
                                    <input type="hidden" name="id" value="<%=rs.getString("categoryid")%>">
                                </div> 
                            </fieldset>
                        </form>
                        <%
                                }
                            } catch (Exception e) {

                            }
                        %> 
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
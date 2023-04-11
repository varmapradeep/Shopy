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
                        <form action="Subcategoryaction.jsp" method="post" enctype="multipart/form-data">

                            <fieldset>
                                <div class="field">
                                    <div class="form-outline mb">
                                        <label class="label_field">Category</label>
                                        <select class="select form-control" name="Category" style="width: 65%; display: inline-grid;">
                                            <option disabled selected value="">Select Category</option>
                                            <%
                                                try {
                                                    Connection con = ShopClass.getCon();
                                                    Statement st = con.createStatement();
                                                    String Query = "select * from tbl_category";
                                                    ResultSet rs = st.executeQuery(Query);
                                                    while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("categoryid")%>"><%=rs.getString("categoryname")%></option>
                                            <%
                                                    }
                                                } catch (Exception e) {

                                                }
                                            %>      

                                        </select>

                                    </div>

                                </div>
                                <div class="field">
                                    <label class="label_field">Sub Category</label>
                                    <input type="text" name="Subcategory" placeholder="SubCategory Name" />
                                </div>
                                <div class="field">
                                    <label class="label_field">Description</label>
                                    <input type="text" name="subcategorydesc" placeholder="SubCategory Description " />
                                </div>
                                <div class="field">
                                    <label class="label_field">Upload Image1</label>
                                    <input type="file" name="Subcategoryimg1"/>
                                    <div class="field margin_0">
                                        <label class="label_field hidden">hidden label</label>
                                        <button class="main_bt">Add Subcategory</button>
                                    </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
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
                        %>
                        <form action="../ADMIN/Subcategoryeditaction.jsp" method="post" enctype="multipart/form-data">

                            <fieldset>
                                <div class="field">
                                    <style>
                                        .profile-pic {
                                            color: transparent;
                                            transition: all 0.3s ease;
                                            display: flex;
                                            justify-content: center;
                                            align-items: center;
                                            position: relative;
                                            transition: all 0.3s ease;
                                        }
                                        .profile-pic input {
                                            display: none;
                                        }
                                        .profile-pic img {
                                            position: absolute;
                                            object-fit: cover;
                                            width: 165px;
                                            height: 165px;
                                            box-shadow: 0 0 10px 0 rgba(255, 255, 255, 0.35);
                                            border-radius: 100px;
                                            z-index: 0;
                                        }
                                        .profile-pic .-label {
                                            cursor: pointer;
                                            height: 165px;
                                            width: 165px;
                                        }
                                        .profile-pic:hover .-label {
                                            display: flex;
                                            justify-content: center;
                                            align-items: center;
                                            background-color: rgba(0, 0, 0, 0.8);
                                            z-index: 10000;
                                            color: #fafafa;
                                            transition: background-color 0.2s ease-in-out;
                                            border-radius: 100px;
                                            margin-bottom: 0;
                                        }
                                        .profile-pic span {
                                            display: inline-flex;
                                            padding: 0.2em;
                                            height: 2em;
                                        }

                                    </style>

                                    <div class="profile-pic">
                                        <label class="-label" for="file">
                                            <span class="glyphicon glyphicon-camera"></span>
                                            <span>Change Image</span>
                                        </label>
                                        <input id="file" type="file" onchange="loadFile(event)"/>
                                        <img src='../ADMIN/images/subcategoryimg/<%=rs.getString("subcategoryimg")%>' id="Subcategoryimg1" name="Subcategoryimg1"/>
                                    </div>
                                    <script>
                                        var loadFile = function(event) {
                                            var image = document.getElementById("Subcategoryimg1");
                                            image.src = URL.createObjectURL(event.target.files[0]);
                                        };
                                    </script>

                                </div>
                                <div class="field">
                                    <div class="form-outline mb">
                                        <label class="label_field">Category</label>
                                        <select class="select form-control" name="Category" style="width: 65%; display: inline-grid;">
                                            <option disabled selected value=""><%=rs.getString("categoryname")%></option>
                                            <%
                                                try {

                                                    String Query1 = "select * from tbl_category";
                                                    ResultSet rs2 = st.executeQuery(Query1);
                                                    while (rs2.next()) {
                                            %>
                                            <option value="<%=rs2.getString("categoryid")%>"><%=rs2.getString("categoryname")%></option>
                                            <%
                                                    }
                                                } catch (Exception e) {

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
                                    <input type="hidden" name="id" value="<%=rs1.getString("subcategoryid")%>">
                                </div>
                                <div class="field margin_0">
                                    <label class="label_field hidden">hidden label</label>

                                    <button class="main_bt">Update Subcategory</button>
                                </div>

                            </fieldset>
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
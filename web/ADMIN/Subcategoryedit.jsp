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
                                String id = request.getParameter("subid");
                                int num = Integer.parseInt(id);
                                Connection con = ShopClass.getCon();
                                Statement st = con.createStatement();
                                String Query = ("select * from tbl_subcategory  where subcategoryid='" + num + "'");
                                ResultSet rs = st.executeQuery(Query);
                                while (rs.next()) {
                        %>
                        <form action="../Admin/Subcategoryeditaction.jsp" method="post" enctype="multipart/form-data">

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
                                        <img src='../Admin/images/subcategoryimg/<%=rs.getString("subcategoryimg")%>' id="Subcategoryimg1" name="Subcategoryimg1"/>
                                    </div>
                                    <script>
                                        var loadFile = function(event) {
                                            var image = document.getElementById("Subcategoryimg1");
                                            image.src = URL.createObjectURL(event.target.files[0]);
                                        };
                                    </script>

                                </div>
                                <div class="field">
                                    <label class="label_field">Sub Category</label>
                                    <input type="text" name="Subcategory" value="<%=rs.getString("subcategoryname")%>" placeholder="SubCategory Name" />
                                </div>
                                <div class="field">
                                    <label class="label_field">Description</label>
                                    <input type="text" name="subcategorydesc" value="<%=rs.getString("subcategorydesc")%>" placeholder="SubCategory Description " />
                                </div>
                                <div class="field">
                                    <input type="hidden" name="id" value="<%=rs.getString("subcategoryid")%>">
                                </div>
                                <div class="field margin_0">
                                    <label class="label_field hidden">hidden label</label>

                                    <button class="main_bt">Update Subcategory</button>
                                </div>

                            </fieldset>
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
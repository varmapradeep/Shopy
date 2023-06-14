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
                        <form action="Cityregaction.jsp" method="post">
                            <fieldset>
                                <div class="field">
                                    <div class="form-outline mb">
                                        <label class="label_field">District</label>
                                        <select class="select form-control" name="District"  style="width: 65%; display: inline-grid;">
                                            <option disabled selected value="">Select District</option>
                                            <%
                                                try {
                                                    Connection con = ShopClass.getCon();
                                                    Statement st = con.createStatement();
                                                    String Query = "select * from tbl_district";
                                                    ResultSet rs = st.executeQuery(Query);
                                                    while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString("districtid")%>"><%=rs.getString("districtname")%></option>
                                            <%
                                                    }
                                                } catch (Exception e) {

                                                }
                                            %>    

                                        </select>

                                    </div>

                                </div>
                                <div class="field">
                                    <label class="label_field">City Name</label>
                                    <input type="text" name="City" placeholder="Enter City Name" />
                                </div>
                                <div class="field margin_0"> 
                                    <label class="label_field hidden">hidden label</label>
                                    <button class="main_bt">Add City</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

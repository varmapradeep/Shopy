<!doctype html>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="fonts/icomoon/style.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <!-- Style -->
        <link rel="stylesheet" href="css/style.css">

        <title>SHOPY-Company Registration</title>
        <link rel="shortcut icon" type="image/png" href="images/logo_icon1.png">
    </head>
    <body>


        <div class="d-lg-flex half"  >
            <div class="bg order-1 order-md-2" style="background-image: url('images/BG_2.jpg') ;height: 130%"></div>
            <div class="contents order-2 order-md-1">

                <div class="container" style="margin-top:2%;margin-bottom: 2%;" >
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-7">
                            <h3>Signup to <strong><b>SHOPY</b></strong></h3>
                            <h5>Shop Managament System</h5>

                            <p class="mb-6">COMPANY REGISTRATION</p>
                            <form action="companyregaction.jsp" method="post" enctype="multipart/form-data">
                                <div class="form-group first">
                                    <label>Company Name</label>
                                    <input type="text" class="form-control" placeholder="Enter your Company Name" name="companyname">
                                </div>
                                <div class="form-group first">
                                    <label>Company Logo</label>
                                    <input type="file" class="form-control" name="companylogo">
                                </div>
                                <div class="form-group first">
                                    <label>Company Registration No</label>
                                    <input type="text" class="form-control" placeholder="Enter your Registration no" name="regno">
                                </div>
                                <div class="form-group first">
                                    <label>Phone no</label>
                                    <input type="text" class="form-control" placeholder="Enter your Phone no" name="phoneno">
                                </div>
                                <div class="form-group first">
                                    <div class="field">
                                        <div class="form-outline mb">
                                            <label class="label_field">District</label>
                                            <select class="select form-control" name="District">
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
                                </div>
                                <div class="form-group first">
                                    <div class="field">
                                        <div class="form-outline mb">
                                            <label class="label_field">City</label>
                                            <select class="select form-control" name="City">
                                                <option disabled selected value="">Select District</option>
                                                <%
                                                    try {
                                                        Connection con = ShopClass.getCon();
                                                        Statement st = con.createStatement();
                                                        String Query = "select * from tbl_city";
                                                        ResultSet rs = st.executeQuery(Query);
                                                        while (rs.next()) {
                                                %>
                                                <option value="<%=rs.getString("cityid")%>"><%=rs.getString("cityname")%></option>
                                                <%
                                                        }
                                                    } catch (Exception e) {

                                                    }
                                                %>    

                                            </select>

                                        </div>

                                    </div>
                                </div>
                                <div class="form-group first">
                                    <label>E-mail</label>
                                    <input type="text" class="form-control" placeholder="Enter your E-mail id" name="email">
                                </div>
                                <div class="form-group last mb-3">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" placeholder="Your Password" name="password">
                                </div>
                                <input type="submit" value="Sign up" class="btn btn-block btn-primary">

                            </form>
                        </div>
                    </div>
                </div>
            </div 
        </div>
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
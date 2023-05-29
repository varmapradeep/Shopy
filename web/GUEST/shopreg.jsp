<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<div >
    <jsp:include page ="Guestheader.jsp"/>
</div>

<link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="login/fonts/icomoon/style.css">
<link rel="stylesheet" href="login/css/owl.carousel.min.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="login/css/bootstrap.min.css">
<!-- Style -->
<link rel="stylesheet" href="login/css/style.css">
<title> SHOPY- Shop Registration</title>
<link rel="shortcut icon" type="image/png" href="login/images/logo_icon1.png">






<div class="d-lg-flex half">
    <div class="bg order-1 order-md-2" style="background-image: url('login/images/dd.jpg');height: 140%"></div>
    <div class="contents order-2 order-md-1" style="background-color: #ebdada;height: 140%">

        <div class="container" style="padding-top: 18%;">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-7">

                    <h3>SHOP REGISTRATION</h3>

                    <!--<p class="mb-6"></p>-->
                    <form action="Shopregaction.jsp" method="post">
                        <div class="form-group first">
                            <label>Shop Name</label>
                            <input type="text" class="form-control" placeholder="Enter your Shop Name" name="shopname">
                        </div>

                        <div class="form-group first">
                            <label>Owner Name</label>
                            <input type="text" class="form-control" placeholder="Enter Ownername" name="ownername">
                        </div>

                        <div class="form-group first">
                            <div class="field">
                                <div class="form-outline mb">
                                    <label class="label_field">District</label>
                                    <select class="select form-control" id="dis" onchange="displaycity()" name="District">
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
                                <div class="form-outline mb" id="city">
                                    <label class="label_field">City</label>
                                    <select class="select form-control"id="cityid" name="City">
                                        <option disabled selected value="">Select City</option>
                                        
                                        
                                    </select>

                                </div>

                            </div>
                        </div>
                        <div class="form-group first">
                            <label>Phone no</label>
                            <input type="text" class="form-control" placeholder="Enter your Phone no" name="phoneno">
                        </div>
                        <div class="form-group first">
                            <label>E-mail</label>
                            <input type="text" class="form-control" placeholder="Enter your E-mail id" name="email">
                        </div>
                        <div class="form-group last mb-3">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" placeholder="Your Password" name="password">
                        </div><br>
                        <input type="submit" value="Sign up" class="btn btn-block btn-primary">

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                                        <script>
    function displaycity()
    {
 
        var val = document.getElementById('dis').value;
// alert(val)
        $.ajax({
            type: "POST",
            url: "getcity.jsp",
            data: "id=" + val,
            success: function(data2)
            {
// alert(data2);
                $("#city").html(data2);
            }
        })
    }
</script>  



<script src="login/js/jquery-3.3.1.min.js"></script>
<script src="login/js/popper.min.js"></script>
<script src="login/js/bootstrap.min.js"></script>
<script src="login/js/main.js"></script>

<div style="padding-top: 280px">
    <jsp:include page ="Guestfooter.jsp"/>
</div>





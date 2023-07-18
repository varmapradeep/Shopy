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
                    <form action="Shopregaction.jsp" method="post"onsubmit="return validateForm()">
                        <div class="form-group first">
                            <label>Shop Name</label>
                            <input type="text" class="form-control" placeholder="Enter your Shop Name" name="shopname" required>
                        </div>
                        <div class="form-group first">
                            <label>Owner Name</label>
                            <input type="text" class="form-control" placeholder="Enter Ownername" name="ownername" required>
                        </div>
                        <div class="form-group first">
                            <div class="field">
                                <div class="form-outline mb">
                                    <label class="label_field">District</label>
                                    <select class="select form-control" id="dis" onchange="displaycity()" name="District" required>
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
                                    <select class="select form-control"id="cityid" name="City" required>
                                        <option disabled selected value="">Select City</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group first">
                            <label>Phone no</label>
                            <input type="text" class="form-control" placeholder="Enter your Phone no" min="10" max="10" name="phoneno" required>
                        </div>
                        <div class="form-group first">
                            <label>E-mail</label>
                            <input type="text" class="form-control" placeholder="Enter your E-mail id" name="email" required>
                        </div>
                        <div class="form-group last mb-3">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" placeholder="Your Password" min="8" name="password" required>
                        </div><br>
                        <input type="submit" value="Sign up" class="btn btn-block btn-primary">
                        <input type="reset" value="Reset" class="btn btn-block btn-primary">

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


    function validateForm() {
        var shopname = document.getElementById("shopname").value;
        var ownername = document.getElementById("ownername").value;
        var District = document.getElementById("District").value;
        var City = document.getElementById("City").value;
        var phoneno = document.getElementById("phoneno").value;
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;


        if (shopname.trim() === "") {
            alert("Shop name must be filled out");
            return false;
        }

        if (ownername.trim() === "") {
            alert("Ownername must be filled out");
            return false;
        }
        if (phoneno.trim() === "") {
            alert("Phone Number must be filled out");
            return false;
        }

        if (District.trim() === "") {
            alert("Please select a District");
            return false;
        }

        if (City.trim() === "") {
            alert("Please select a City");
            return false;
        }

        if (email.trim() === "") {
            alert("E-mail must be filled out");
            return false;
        }
        if (password.trim() === "") {
            alert("Password must be filled out.<br> min 8 characters");
            return false;
        }

        return true;
    }

</script>  



<script src="login/js/jquery-3.3.1.min.js"></script>
<script src="login/js/popper.min.js"></script>
<script src="login/js/bootstrap.min.js"></script>
<script src="login/js/main.js"></script>

<div style="padding-top: 280px">
    <jsp:include page ="Guestfooter.jsp"/>
</div>





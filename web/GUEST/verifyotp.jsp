<jsp:include page ="Guestheader.jsp"/>


<link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="login/fonts/icomoon/style.css">
<link rel="stylesheet" href="login/css/owl.carousel.min.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="login/css/bootstrap.min.css">
<!-- Style -->
<link rel="stylesheet" href="login/css/style.css">
<title>SHOPY-Login Page</title>
<link rel="shortcut icon" type="image/png" href="login/images/logo_icon1.png">



<div class="d-lg-flex half">
    <div class="bg order-1 order-md-2" style="background-image: url('login/images/bg_1.jpg');"></div>
    <div class="contents order-2 order-md-1" style="background-color: #ebdada">

        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-7">
                    <h3>LOGIN to <strong><b>SHOPY</b></strong></h3>
                    <h5>Shop Managament System</h5>

                    <p class="mb-4">Manage our whole shop online</p>
                    <form action="otpaction.jsp" method="post">
                        <div class="form-group first">
                            <label>Otp</label>
                            <input type="text" class="form-control" placeholder="Enter your otp" name="verifyotp">
                        </div>
                        <input type="submit"  value="Verify Otp" class="btn btn-block btn-primary">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="login/js/jquery-3.3.1.min.js"></script>
<script src="login/js/popper.min.js"></script>
<script src="login/js/bootstrap.min.js"></script>
<script src="login/js/main.js"></script>

<jsp:include page ="Guestfooter.jsp"/>





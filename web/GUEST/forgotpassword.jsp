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
                    <h3><strong><b style="font: ">SHOPY</b></strong></h3>


                    <p class="mb-4">Manage our whole shop online</p>                  
                    <p class="mb-4">Reset Password of  </p>


                    <form action="loginaction.jsp" method="post">
                        <div class="form-group first">
                            <label for="username">Password</label>
                            <input type="Password" class="form-control" placeholder="Your Password" name="pass1">
                        </div>
                        <div class="form-group last mb-3">
                            <input type="password" class="form-control" placeholder="Re-enter Your Password" name="pass2">
                        </div>



                        <input type="submit" value="reset" class="btn btn-block btn-primary">

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





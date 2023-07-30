<jsp:include page="Guestheader.jsp" />

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
                    <h3>LOGIN To SHOPY</h3>
                    <h5>Shop Management System</h5>

                    <p class="mb-4">Reset your Password</p>
                    <form action="passaction.jsp" method="post" onsubmit="return validateForm()">
                        <div class="form-group first">
                            <label>Password</label>
                            <input type="password" class="form-control" placeholder="Enter your Password" name="password1" required>
                        </div>
                        <div class="form-group first">
                            <label>Re-Enter the password</label>
                            <input type="password" class="form-control" placeholder="Re-Enter the password" name="password2" required>
                        </div>
                        <div class="form-group ">
                            <label for="showPassword">Show Password</label>
                            <input type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
                        </div>
                        <input type="submit" value="Update" class="btn btn-block btn-primary">
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

<script>
                                function validateForm() {
                                    var password1 = document.getElementsByName('password1')[0].value;
                                    var password2 = document.getElementsByName('password2')[0].value;

                                    if (password1 !== password2)
                                    {
                                        alert("Passwords do not match. Please enter again.");
                                        window.location = "upadatepassword.jsp";
                                        return false;
                                    }
                                    alert("Password Updated Sucessfully");
                                    window.location = "passaction.jsp";
                                   
                                    return true;
                                }

                                function togglePasswordVisibility() {
                                    var passwordInput = document.getElementsByName('password1')[0];
                                    var confirmPasswordInput = document.getElementsByName('password2')[0];
                                    var showPasswordCheckbox = document.getElementById('showPassword');

                                    if (showPasswordCheckbox.checked) {
                                        passwordInput.type = 'text';
                                        confirmPasswordInput.type = 'text';
                                    } else {
                                        passwordInput.type = 'password';
                                        confirmPasswordInput.type = 'password';
                                    }
                                }
</script>

<jsp:include page="Guestfooter.jsp" />

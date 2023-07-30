<%@page import="java.sql.*"%>
<%@page import="shoppackages.ShopClass"%>
<%@page import="otp.otpGenerator"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.Random"%>
<%@page import="java.util.Properties" %>


<%

    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String verifyotp = request.getParameter("verifyotp");
        String creatotp = (String) session.getAttribute("otp");
        int userEnteredOTP = Integer.parseInt(verifyotp);
        int storedOTP = Integer.parseInt(creatotp);
        if (userEnteredOTP == storedOTP) {
            session.removeAttribute("otp");

%>
<script>
    alert("OTP VERIFIED SUCESSFULLY");
    window.location = "upadatepassword.jsp";
</script>

<script>
    alert("OTP Does not match.\n\
Enter Correct Otp")

</script>
<%        }
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
    }


%>




























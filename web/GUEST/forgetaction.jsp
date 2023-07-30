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
        String reqemail = request.getParameter("email");

        String Query = "SELECT * FROM tbl_login  WHERE username='" + reqemail + "' AND status='Confirmed'";
        ResultSet rs = st.executeQuery(Query);
        if (rs.next()) {
            String otp = otpGenerator.generateOTP();
            String loginid = rs.getString("loginid");
            session.setAttribute("otp", otp);
            session.setAttribute("loginid", loginid);
        // ... (rest of the code)

%>
<script>
    alert("OTP sent Sucessfully to");
    window.location = "verifyotp.jsp";
</script>
<%    // Send email notification
    // Sender's and recipient's email address
    String senderEmail = "shopy4shop@gmail.com";
    String recipientEmail = request.getParameter("email");

    // SMTP server configuration
    String host = "smtp.gmail.com";
    String port = "587";
    final String finalUsername = senderEmail;
    final String finalPassword = "pkkrixqzuimlnxtt";

    // Set properties and authentication
    Properties props = new Properties();
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    // Create a Session with authentication
    Authenticator auth = new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(finalUsername, finalPassword);
        }
    };
    Session sessions = Session.getInstance(props, auth);

    // Create a default MimeMessage object
    MimeMessage message = new MimeMessage(sessions);

    // Set From: header field
    message.setFrom(new InternetAddress(senderEmail));

    // Set To: header field
    message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));

    // Set Subject: header field
    String otpValue = otp;
//    String otpValue = request.getParameter("otp");
    message.setSubject("RESET YOUR PASSWORD");

    String emailContent = "<html>"
            + "<body style=\"font-family: Arial, sans-serif;\">"
            + "<div style=\"background-color:'#a7d9cd'; padding: 30px;\">"
            + "<h1 style=\"color: #007BFF;\">Welcome to Shopy</h1>"
            + "<p>We are thrilled to have you onboard! Now you can start showcasing your products to millions of potential customers.</p>"
            + "<p>Log in to your Shopy dashboard and start managing Again.</p>"
            + "<p>Thank you for choosing Shopy as your e-commerce platform!</p>"
            + "<p>Here is your One-Time Password (OTP): </p>"
            + "<h3 style=\"color: #A70D2A;\"><strong>" + otpValue + "</strong></h3>"
            + "<p>From Shopy Team</p>"
            + "</a>"
            + "</div>"
            + "</div>"
            + "</body>"
            + "</html>";

    message.setContent(emailContent, "text/html");
    // Use setContent() instead of setText()

// Send the message
    Transport.send(message);
} else {
%>
<script>
    alert("This Mailid is not Registered Into the Shopy")
    window.location = "forgot.jsp";
</script>
<%
        }
    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
    }


%>




























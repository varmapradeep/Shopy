<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@page import= "javax.mail.MessagingException" %>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage" %>
<%@page import="java.util.Properties" %>
<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String shopname = request.getParameter("shopname");
        String ownername = request.getParameter("ownername");
        String District = request.getParameter("District");
        String City = request.getParameter("City");
        String phoneno = request.getParameter("phoneno");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql1 = "insert into tbl_login(username,password,role,status)values('" + email + "','" + password + "','Shop','Unconfirmed')";
        out.println(sql1);
        st.executeUpdate(sql1);
        out.println(sql1);
        //get login id

        String sql3 = "select max(loginid) as 'lid' from tbl_login";
        out.println(sql3);
        ResultSet rs1 = st.executeQuery(sql3);
        if (rs1.next()) {
            String lid = rs1.getString("lid");
            Date dNow = new Date();
            SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
            String sql4 = "insert into tbl_shop (shopname,ownername,district,city,phoneno,loginid,regdate)values('" + shopname + "','" + ownername + "','" + District + "','" + City + "','" + phoneno + "','" + lid + "','" + ft.format(dNow) + "')";
            st.executeUpdate(sql4);
%>
<script>
    alert("Shop Registeration Successfully");
    window.location = "Guestindex.jsp";
</script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    // Send email notification
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
    String shopName = request.getParameter("shopname");
    String imageURL = "https://htmlcolorcodes.com/assets/images/html-color-codes-color-tutorials-hero.jpg";
    message.setSubject("Congratulations    " + shopName + " Your Shop is now on Shopy;");

// Set message content
    String emailContent = "<html>"
            + "<body style=\"font-family: Arial, sans-serif;\">"
            + "<div style=\"background-image: url('" + imageURL + "');padding: 30px;\">"
            + "<h1 style=\"color: #007BFF;\">Welcome to Shopy</h1>"
            + "<h2 style=\"color: #A70D2A;\">Congratulations  " + shopName + "</h2>"
            + "<p>Your shop has been successfully registered on Shopy. We are thrilled to have you onboard!Now you can start showcasing your products to millions of potential customers.</p>"
            + "<p>Log in to your Shopy dashboard and start managing your shop with easy.</p>"
            + "<p>Thank you for choosing Shopy as your e-commerce platform!</p>"
            + "<p>From Shopy Team</p>"
            + "<div style=\"text-align: center;\">"
            + "<a href=\"https://www.shopy.com/dashboard\" style=\"background-color: #007BFF; color: #ffffff; padding: 10px 20px; border-radius: 5px; text-decoration: none;\">"
            + "Go to Shopy Dashboard"
            + "</a>"
            + "<p></p>"
            + "</div>"
            + "</div>"
            + "</body>"
            + "</html>";

    message.setContent(emailContent, "text/html"); // Use setContent() instead of setText()

// Send the message
    Transport.send(message);

%>





<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%
   // Sender's and recipient's email address
   String senderEmail = "keralabloodbank2023@gmail.com";
   String recipientEmail = "varmapradeepvp@gmail.com";

   // SMTP server configuration
   String host = "smtp.gmail.com";
   String port = "587";
   String username = "keralabloodbank2023@gmail.com";
   String password = "mlqalukpbrmwetiv";

   // Set properties and authentication
   Properties props = new Properties();
   props.put("mail.smtp.host", host);
   props.put("mail.smtp.port", port);
   props.put("mail.smtp.auth", "true");
   props.put("mail.smtp.starttls.enable", "true");

   // Create a Session with authentication
   Authenticator auth = new Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
         return new PasswordAuthentication(username, password);
      }
   };
   Session sessions = Session.getInstance(props, auth);

   try {
      // Create a default MimeMessage object
      MimeMessage message = new MimeMessage(sessions);

      // Set From: header field
      message.setFrom(new InternetAddress(senderEmail));

      // Set To: header field
      message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));

      // Set Subject: header field
      message.setSubject("Testing JavaMail API");

      // Set message content
      message.setText("Hello, this is a test email from JavaMail!");

      // Send the message
      Transport.send(message);
      out.println("Email sent successfully!");
   } catch (MessagingException ex) {
      out.println("Error: " + ex.getMessage());
      ex.printStackTrace();
   }
%>

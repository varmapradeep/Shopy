<%@page import="shoppackages.ShopClass" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    File file;
    ArrayList<String> fileset = new ArrayList();
    ArrayList<String> details = new ArrayList();
    int maxFileSize = 50000 * 1024;
    int maxMemSize = 50000 * 1024;
    String localpath = "D:/SHOP MANAGMENT SYSTEM/SHOPY/web/GUEST/img/companylogo/";
    String filePath = localpath;
    File folder = new File(filePath);
    folder.mkdir();
    // Verify the content type
    String contentType = request.getContentType();
    
    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("c:\\temp"));
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);
        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);
            Iterator i = fileItems.iterator();
            out.println("<html>");
            out.println("<head>");
            out.println("<title>JSP File upload</title>");
            out.println("</head>");
            out.println("<body>");
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                out.println("<br/>" + fi);
                if (!fi.isFormField()) {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    // Write the file
                    if (fileName.lastIndexOf("\\") >= 0) {
                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\")));
                    } else {
                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\") + 1));
                    }
                    fi.write(file);
                    String fname = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    out.println("<br/>file:  " + fname);
                    fileset.add(fname);
                } else {
                    String key = fi.getString();
                    details.add(key);
                }
            }

            try {
                String companyname = details.get(0);
                String companylogo = fileset.get(0);
                String regno = details.get(1);
                String phoneno = details.get(2);
                String District = details.get(3);
                String City = details.get(4);
                String email = details.get(5);
                String password = details.get(6);

                Connection con = ShopClass.getCon();
                Statement st = con.createStatement();
                String login1 = "insert into tbl_login(username,password,role,status)values('" + email + "','" + password + "','Company','Unconfirmed')";
                st.executeUpdate(login1);
                out.println(login1);
                // Get login id
                String getid = "select max(loginid) as 'lid' from tbl_login";
                ResultSet rs1 = st.executeQuery(getid);
                if (rs1.next()) {
                    String loginid = rs1.getString("lid");
                    Date dNow = new Date();
                    SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
                    String s = "insert into tbl_company(cpyname,cpylogo,regno,phone,district,city,loginid,regdate) values('" + companyname + "','" + companylogo + "','" + regno + "','" + phoneno + "','" + District + "','" + City + "','" + loginid + "','" + ft.format(dNow) + "')";
                    st.executeUpdate(s);
                    
                    // Send email notification
                    // Sender's and recipient's email address
                    String senderEmail = "keralabloodbank2023@gmail.com";
                    String recipientEmail = email;

                    // SMTP server configuration
                    String host = "smtp.gmail.com";
                    String port = "587";
                    final String finalUsername = senderEmail;
                    final String finalPassword = "mlqalukpbrmwetiv";

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
                    message.setSubject("Registration Successful");

                    // Set message content
                    String emailContent = "Hello, your company has been registered successfully.";
                    message.setText(emailContent);

                    // Send the message
                    Transport.send(message);
                } else {
%>
<script>
    alert("Failed to Register");
</script>
<%
                }
                st.close();
                con.close();
                out.println("closed");
                // response.sendRedirect("vehsubreg.jsp");
            } catch (Exception e) {
                out.println(e);
            }
        %>
<script>
    alert("Company Registration Successful");
    window.location = "Guestindex.jsp";
</script>
<%
        out.println("</body>");
        out.println("</html>");
    } catch (Exception ex) {
        System.out.println(ex);
    }
} else {
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Servlet upload</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<p>No file uploaded</p>");
    out.println("</body>");
    out.println("</html>");
}
%>

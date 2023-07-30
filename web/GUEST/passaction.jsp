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
        String password = request.getParameter("password2");
        String loginid = (String) session.getAttribute("loginid");
        int loginid1 = Integer.parseInt(loginid);

        String sql1 = "UPDATE tbl_login SET password = ? WHERE loginid = ?";
        PreparedStatement pstmt = con.prepareStatement(sql1);
        pstmt.setString(1, password);
        pstmt.setInt(2, loginid1);
        pstmt.executeUpdate();

        session.removeAttribute("loginid");

%>
<script>
    window.location = "login.jsp";
</script>


<%    } catch (Exception e) {
        out.println("Exception occurred: " + e.getMessage());
    }


%>




























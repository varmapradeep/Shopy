<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
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

        String sql1 = "insert into tbl_login(username,password,role,status)values('" + email + "','" + password + "','Shop',' notconfirmed')";
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
%>




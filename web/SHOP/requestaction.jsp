<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>

<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String productid = request.getParameter("productid");
        String companyid = request.getParameter("companyid");
        String shopid = request.getParameter("shopid");
        String qty = request.getParameter("qty");
        String unit = request.getParameter("unit");
        String price = request.getParameter("totalprice");
        Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
        String comment = request.getParameter("message");
        st.executeUpdate("insert into tbl_request (productid,companyid,shopid,quantity,unit,price,regdate,comment,status) values ('" + productid + "','" + companyid + "','" + shopid + "','" + qty + "','" + unit + "','" + price + "','" + ft.format(dNow) + "','" + comment + "','Requested')");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<script>
    alert("Request Successfully Sent");
    window.location = "Shoppinghome.jsp";
</script>









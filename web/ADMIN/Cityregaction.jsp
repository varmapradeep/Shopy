<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
try{
     Connection con=ShopClass.getCon();
       Statement st=con.createStatement();
        String districtid=request.getParameter("District");
        String City=request.getParameter("City");
       st.executeUpdate("insert into tbl_city (districtid,cityname) values ('"+districtid+"','"+City+"')");
        }
catch(Exception e){
            e.printStackTrace();
}
%>
<script>
    alert("City Registeration Successfully");
    window.location = "Cityreg.jsp";
</script>
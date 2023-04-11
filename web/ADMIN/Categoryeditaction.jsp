<%@page import="java.sql.*"%>
<%@page import="shoppackages.ShopClass"%>
<%@page import="javafx.scene.control.Alert"%>

<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String categoryname = request.getParameter("Category");
        String categorydesc = request.getParameter("Categorydec");
        String did = request.getParameter("id");
        int num = Integer.parseInt(did);
        String sql1 = "update tbl_category set categoryname='" + categoryname + "',Categorydec='" + categorydesc + "' where categoryid='" + num + "' ";
        st.executeUpdate(sql1);
                   

     

        response.sendRedirect("Categoryview.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

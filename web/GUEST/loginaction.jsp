<%@page import="java.sql.*"%>
<%@page import="shoppackages.ShopClass"%>
<%
    try {
        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String Username = request.getParameter("username");
        String Password = request.getParameter("password");
        //String role="customer";
        //String status="notconfirmed";

        String Query = "Select * from tbl_login WHERE username='" + Username + "' and password ='" + Password + "'  ";
        // out.println(Query);
        ResultSet rs = st.executeQuery(Query);
// out.println("...INSERTED..");
        if (rs.next()) {
            // out.println("he");
            int loginid = rs.getInt("loginid"); 
            session.setAttribute("loginid", loginid);
// String r="admin";
            // out.println(loginid);
            String role = rs.getString("role").replaceAll("\\s", ""); // replaceAll("\\s", "")
            out.println(role);
            String status = rs.getString("status");
// st.executeUpdate("Update tbl_login set status='confirmed' where username ='"+Username+"'  ");
            //out.println("hi");
// if(role=="admin"){
            if (role.equals("Admin"))
            {
                response.sendRedirect("../ADMIN/AdminHome.jsp");
            } else if (role.equals("Shop")) 
            {
                response.sendRedirect("../SHOP/Shophome.jsp");
            } else if (role.equals("Company")) 
            {
                if (status.equals("Confirmed"))
                {
                    response.sendRedirect("../COMPANY/Companyhome.jsp");
                }
                else 
                {
                    out.println("pls wait");
                }
            }
        }
         else {
            out.println("invalid username or password");

        }
    } 
    
        catch (Exception e) 
                {
    }

%>


























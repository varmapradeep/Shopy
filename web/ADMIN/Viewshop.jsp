<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<% int slno = 0;%>    

<div class="white_shd full margin_bottom_30">
    <div class="full graph_head">
        <div class="heading1 margin_0 ">
            <h2><b>SHOP</b></h2>
        </div>
        <div class="dash_head">
            <h3><span><i class="fa fa-comments-o"></i> Shop View</span><span class="plus_green_bt"><a href="Shoprequests.jsp" style="border-radius: 15%;width: 135px;font-size: 12px;">Shop Request</</span></h3>

        </div>
    </div>
    <div class="table_section padding_infor_info">
        <div class="table-hover table-responsive-md">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Index No</th>
                        <th>Shop Name</th>
                        <th>Owner Name</th>
                        <th>Phone</th>
                        <th>District</th>
                        <th>City</th>
                        <th>E-mail</th>
                        <th>Reg Date</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "SELECT * FROM tbl_shop tc INNER JOIN tbl_login tl ON tc.loginid=tl.loginid INNER JOIN tbl_district td ON tc.district=td.districtid INNER JOIN tbl_city t ON tc.city=t.cityid WHERE tl.status='Confirmed'";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%=++slno%></td>
                        <td><%=rs.getString("shopname")%></td>
                        <td><%=rs.getString("ownername")%></td>
                        <td><%=rs.getString("phoneno")%></td>
                        <td><%=rs.getString("districtname")%></td>
                        <td><%=rs.getString("cityname")%></td>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("regdate")%></td>


                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("exception");
                        }
                    %> 
                </tbody>
            </table>
        </div>
    </div>
</div>
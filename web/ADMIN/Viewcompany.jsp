<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<% int slno = 0;%>    

<div class="white_shd full margin_bottom_30">
    <div class="full graph_head">
        <div class="heading1 margin_0 ">
            <h2><b>COMPANIES</b></h2>
        </div>
        <div class="dash_head">
            <h3><span><i class="fa fa-comments-o"></i> Company View</span></h3>
        </div>
    </div>
    <div class="table_section padding_infor_info">
        <div class="table-responsive-sm table-hover table-bordered">
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th>Index No</th>
                        <th>Company logo</th>
                        <th>Company Name</th>
                        <th>Company Reg No</th>
                        <th>Phone</th>
                        <th>District</th>
                        <th>City</th>
                        <th>E-mail</th>
                        <th>Reg Date</th>
                        <th>Approve</th>
                        <th>Reject</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "SELECT * FROM tbl_company tc INNER JOIN tbl_login tl ON tc.loginid=tl.loginid INNER JOIN tbl_district td ON tc.district=td.districtid INNER JOIN tbl_city t ON tc.city=t.cityid";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%=++slno%></td>
                        <td><img src='../GUEST/img/companylogo/<%=rs.getString("cpylogo")%>' width="80" height="80"></td>
                        <td><%=rs.getString("cpyname")%></td>
                        <td><%=rs.getString("regno")%></td>
                        <td><%=rs.getString("phone")%></td>
                        <td><%=rs.getString("districtname")%></td>
                        <td><%=rs.getString("cityname")%></td>
                        <td><%=rs.getString("username")%></td>
                        <td><%=rs.getString("regdate")%></td>

                        <td class="w3-xlarge"> <a onclick="return confirm('This Company Will be Approved.\n Do you want to Continue?')" href="Companyapprove.jsp?id=<%=rs.getString("cpyid")%>" class="fa fa-check"></a></td>
                        <td class="w3-xlarge"> <a onclick="return confirm('This Company Will be Rejected.\n Do you want to Continue?')" href="Companyapprove.jsp?id=<%=rs.getString("cpyid")%>" class="fa fa-close"></a></td>

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
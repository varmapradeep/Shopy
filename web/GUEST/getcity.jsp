<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String districtid = request.getParameter("id");
        String Query = "select * from tbl_city where districtid='" + districtid + "'";
        ResultSet rs = st.executeQuery(Query);
%>

<label class="label_field">City</label>
<select class="select form-control" id="city" name="City">
    <option disabled selected value="">Select City</option>

 
        <!--<option value="0">city</option>-->

        <%
            while (rs.next()) {
        %>
        <option value="<%=rs.getString("cityid")%>"> <%=rs.getString("cityname")%>  </option>

        <%
            }
        %>
    </select>
    <%
        } catch (Exception e) {
        }

    %>
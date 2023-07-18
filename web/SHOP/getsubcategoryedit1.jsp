<%@page import="shoppackages.ShopClass" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%
    try {

        Connection con = ShopClass.getCon();
        Statement st = con.createStatement();
        String catid = request.getParameter("id");
        String Query = "select * from tbl_subcategory where categoryid='" + catid + "'";
        ResultSet rs = st.executeQuery(Query);
%>

<label  class="col-form-label">Product Subcategory</label>
<select class="form-control" id="subcat" name="Subcategory">
    <option disabled selected value="">Select Subategory</option>

        <%
            while (rs.next()) {
        %>
        <option value="<%=rs.getString("subcategoryid")%>"> <%=rs.getString("subcategoryname")%>  </option>

        <%
            }
        %>
    </select>
    <%
        } catch (Exception e) {
        }

    %>
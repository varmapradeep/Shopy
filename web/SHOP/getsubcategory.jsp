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
<select class="form-control" id="subcat" name="subcat" onchange="display()">
    <option disabled selected value="">Select SubCategory</option>

    

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

<script>
    function display() {
        var val = document.getElementById('subcat').value;
        var value = document.getElementById('cate').value;
//        alert(val);
//        alert(value);

        $.ajax({
            type: "POST",
            url: "getproductsbysubcat.jsp",
            data: {
                val: val,
                value: value
            },
            success: function(data3) {
                $("#display").html(data3);
            }
        });
    }
</script>
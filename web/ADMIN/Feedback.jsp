<jsp:include page ="Adminindex.html"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<% int slno = 0;%>    

<div class="white_shd full margin_bottom_30">
    <div class="full graph_head">
        <div class="heading1 margin_0 ">
            <h2><b>VIEW FEEDBACK</b></h2>
        </div>
        <div class="dash_head" >
            <h3><span><i class="fa fa-comments-o"></i> Feedback-View</span><span class="plus_green_bt"><a href="Subcategory.jsp">+</a></span></h3>
            <div class="form-outline mb">
                <br>
                <label class="label_field" style="color: white">Select Stakeholder</label>
                <select class="select form-control" name="Cate" id="cate" onchange="displaysubcat()" style="width: 20%; display: inline-grid;">
                    <option disabled selected value="">Select Stakeholder</option>

                    <%
                        try {
                            Connection con = ShopClass.getCon();
                            Statement st = con.createStatement();
                            String Query = "select * from tbl_feedback";
                            ResultSet rs = st.executeQuery(Query);
                            while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("categoryid")%>"><%=rs.getString("categoryname")%></option>
                    <%
                            }
                        } catch (Exception e) {

                        }
                    %>    
                </select>
            </div>
        </div>
    </div>
    <div class="table_section padding_infor_info" id="cat">
        <div class="table-responsive-sm">

        </div>
    </div>
</div>             
<script>
    function displaysubcat()
    {
//        alert("a")
        var val = document.getElementById('cate').value;
//        alert(val)
        $.ajax({
            type: "POST",
            url: "getsubcategory.jsp",
            data: "id=" + val,
            success: function(data2)
            {
// alert(data2);
                $("#cat").html(data2);
            }
        })
    }
</script> 
<script src="js/jquery-3.3.1.min.js"></script>

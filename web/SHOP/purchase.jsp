<jsp:include page="shoppingheader.jsp" />
<%@ page import="java.sql.*" %>
<%@ page import="shoppackages.ShopClass" %>
<% int slno = 0;%>    

<div style="background-color: #07212e;height: 15%"></div>

<div class="single-product mt-60 mb-150">
    <p style="text-align: center;font-size: 35px;font-family: Copperplate Gothic;"><b>Purchase Form</b></p>
    <div class="container">
        <div class="row">
            <div class="col-md-12" style="text-align: center;font-size: 25px;font-family: Copperplate Gothic;">
                    <p></p>
                <div class="single-product-img" id="search">
                    <div>
                        <label>Bill No:</label>
                        <input type="text" id="billno" placeholder="Enter Bill Number" value="1001" name="billno">
                    </div>
                    <p></p>
                    <div>
                        <button type="button" class="btn btn-danger" onclick="getbill()">Submit</button>
                           
                    </div>
                </div>
            </div>
            

            
            <div class="col-md-12">
                <div class="single-product-content">
                    <div class="contact-from-section mt-500 mb-150">
                        <br>
                        <br>
                        <div class="container" id="bill">
                            <div class="row">                               
                                
                            </div>                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function getbill()
    {
//        alert("a")
        var billno = document.getElementById('billno').value;
//        alert(billno)
        $.ajax({
            type: "POST",
            url: "getpurchase.jsp",
            data: "id=" + billno,
            success: function(data2)
            {
//                alert(data2);
                $("#bill").html(data2);
            }
        })
    }
</script> 
<jsp:include page="Shopfooter.jsp" />


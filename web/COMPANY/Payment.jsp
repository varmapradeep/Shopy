<jsp:include page="Companyindex.jsp" />
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass" %>
<div class="col-md-8 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
            <h4 class="card-title" style="text-align: center">Payment Form</h4>

            <form class="forms-sample" action="PaymentDetails.jsp" method="post">
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label">Bill No</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="billno" placeholder="Bill Number" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary mr-2">Submit</button>
            </form>
        </div>
    </div>
</div>

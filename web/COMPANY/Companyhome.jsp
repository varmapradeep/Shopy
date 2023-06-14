<jsp:include page ="Companyindex.jsp"/>
<%@page import="java.sql.*" %>
<%@page import="shoppackages.ShopClass"%>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-md-12 grid-margin">
                <div class="row"><%
                    try {
                        String loginid = (String) session.getAttribute("loginid");
                        Connection con = ShopClass.getCon();
                        Statement st = con.createStatement();
                        String Query = "SELECT * FROM tbl_company WHERE loginid='" + loginid + "'";
                        ResultSet rs = st.executeQuery(Query);
                        while (rs.next()) {
                %>
                    <div class="col-12 col-xl-8 mb-4 mb-xl-0">
                        <h3 class="font-weight-bold">Welcome <b><%=rs.getString("cpyname")%></b></h3>
                        <h6 class="font-weight-normal mb-0">All systems are running smoothly! You have <span class="text-primary">3 unread alerts!</span></h6>
                    </div>
                     <%
                        }
                    } catch (Exception e) {
                        out.println("exception");
                    }
                %>
                    <div class="col-12 col-xl-4">
                        <div class="justify-content-end d-flex">
                            <div class="dropdown flex-md-grow-1 flex-xl-grow-0">
                                <i class="mdi mdi-calendar"></i> Today (10 Jan 2021)
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuDate2">
                                    <a class="dropdown-item" href="#">January - March</a>
                                    <a class="dropdown-item" href="#">March - June</a>
                                    <a class="dropdown-item" href="#">June - August</a>
                                    <a class="dropdown-item" href="#">August - November</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card tale-bg">
                    <div class="card-people mt-auto">
                        <img src="images/dashboard/people.svg" alt="people">
                        <div class="weather-info">
                            <div class="d-flex">
                                <div>
                                    <h2 class="mb-0 font-weight-normal"><i class="icon-sun mr-2"></i>31<sup>C</sup></h2>
                                </div>
                                <div class="ml-2">
                                    <h4 class="location font-weight-normal">Bangalore</h4>
                                    <h6 class="font-weight-normal">India</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 grid-margin transparent">
                <div class="row">
                    <div class="col-md-6 mb-4 stretch-card transparent">
                        <div class="card card-tale">
                            <div class="card-body">
                                <p class="mb-4">Today?s Bookings</p>
                                <p class="fs-30 mb-2">4006</p>
                                <p>10.00% (30 days)</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4 stretch-card transparent">
                        <div class="card card-dark-blue">
                            <div class="card-body">
                                <p class="mb-4">Total Bookings</p>
                                <p class="fs-30 mb-2">61344</p>
                                <p>22.00% (30 days)</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-4 mb-lg-0 stretch-card transparent">
                        <div class="card card-light-blue">
                            <div class="card-body">
                                <p class="mb-4">Number of Meetings</p>
                                <p class="fs-30 mb-2">34040</p>
                                <p>2.00% (30 days)</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 stretch-card transparent">
                        <div class="card card-light-danger">
                            <div class="card-body">
                                <p class="mb-4">Number of Clients</p>
                                <p class="fs-30 mb-2">47033</p>
                                <p>0.22% (30 days)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <p class="card-title">Sales Report</p>
                            <a href="#" class="text-info">View all</a>
                        </div>
                        <p class="font-weight-500">The total number of sessions within the date range. It is the period time a user is actively engaged with your website, page or app, etc</p>
                        <div id="sales-legend" class="chartjs-legend mt-4 mb-2"></div>
                        <canvas id="sales-chart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <p class="card-title mb-0">Top Products</p>
                        <div class="table-responsive">
                            <table class="table table-striped table-borderless">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Search Engine Marketing</td>
                                        <td class="font-weight-bold">$362</td>
                                        <td>21 Sep 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-success">Completed</div></td>
                                    </tr>
                                    <tr>
                                        <td>Search Engine Optimization</td>
                                        <td class="font-weight-bold">$116</td>
                                        <td>13 Jun 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-success">Completed</div></td>
                                    </tr>
                                    <tr>
                                        <td>Display Advertising</td>
                                        <td class="font-weight-bold">$551</td>
                                        <td>28 Sep 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-warning">Pending</div></td>
                                    </tr>
                                    <tr>
                                        <td>Pay Per Click Advertising</td>
                                        <td class="font-weight-bold">$523</td>
                                        <td>30 Jun 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-warning">Pending</div></td>
                                    </tr>
                                    <tr>
                                        <td>E-Mail Marketing</td>
                                        <td class="font-weight-bold">$781</td>
                                        <td>01 Nov 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-danger">Cancelled</div></td>
                                    </tr>
                                    <tr>
                                        <td>Referral Marketing</td>
                                        <td class="font-weight-bold">$283</td>
                                        <td>20 Mar 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-warning">Pending</div></td>
                                    </tr>
                                    <tr>
                                        <td>Social media marketing</td>
                                        <td class="font-weight-bold">$897</td>
                                        <td>26 Oct 2018</td>
                                        <td class="font-weight-medium"><div class="badge badge-success">Completed</div></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021.  Premium <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash. All rights reserved.</span>
                    <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
                </div>
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Distributed by <a href="https://www.themewagon.com/" target="_blank">Themewagon</a></span> 
                </div>
            </footer> 
            <!-- partial -->
        </div>
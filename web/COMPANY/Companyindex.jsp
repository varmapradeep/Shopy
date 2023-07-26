<!DOCTYPE html>
<html lang="en">
    <%@page import="java.sql.*" %>
    <%@page import="shoppackages.ShopClass"%>

    <head>

        <title>Shopy-Company</title>
        <link rel="shortcut icon" href="images/logo_icon1.png" />

        <!-- plugins:css -->
        <link rel="stylesheet" href="vendors/feather/feather.css">
        <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
        <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" type="text/css" href="js/select.dataTables.min.css">
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <link rel="stylesheet" href="css/vertical-layout-light/style.css">
        <!-- endinject -->
    </head>
    <body style="background-color: transparent">
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
                <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center" style="background-color: #248AFD">
                    <a class="navbar-brand brand-logo mr-5" href="Companyhome.jsp"><img  src="images/logo1.png" class="mr-2" alt="logowhite"/></a>
                    <a class="navbar-brand brand-logo-mini" href="Companyhome.jsp"><img src="images/logo_icon1.png" alt="logoshort"/></a>
                </div>
                <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end" style="background-color:transparent">
                    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                        <span class="icon-menu"></span>
                    </button>
                    <ul class="navbar-nav mr-lg-2">
                        <li class="nav-item nav-search d-none d-lg-block">
                            <div class="input-group">
                                <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
                                    <span class="input-group-text" id="search">
                                        <i class="icon-search"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" id="navbar-search-input" placeholder="Search now" aria-label="search" aria-describedby="search">
                            </div>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-nav-right">
                        <li class="nav-item dropdown">
                            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
                                <i class="icon-bell mx-0"></i>
                                <span class="count"></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
                                <p class="mb-0 font-weight-normal float-left dropdown-header">Notifications</p>
                                <a class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-success">
                                            <i class="ti-info-alt mx-0"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <h6 class="preview-subject font-weight-normal">Application Error</h6>
                                        <p class="font-weight-light small-text mb-0 text-muted">
                                            Just now
                                        </p>
                                    </div>
                                </a>
                                <a class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-warning">
                                            <i class="ti-settings mx-0"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <h6 class="preview-subject font-weight-normal">Settings</h6>
                                        <p class="font-weight-light small-text mb-0 text-muted">
                                            Private message
                                        </p>
                                    </div>
                                </a>
                                <a class="dropdown-item preview-item">
                                    <div class="preview-thumbnail">
                                        <div class="preview-icon bg-info">
                                            <i class="ti-user mx-0"></i>
                                        </div>
                                    </div>
                                    <div class="preview-item-content">
                                        <h6 class="preview-subject font-weight-normal">New user registration</h6>
                                        <p class="font-weight-light small-text mb-0 text-muted">
                                            2 days ago
                                        </p>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="nav-item nav-profile dropdown">
                            <%
                                try {
                                    String loginid = (String) session.getAttribute("loginid");
                                    Connection con = ShopClass.getCon();
                                    Statement st = con.createStatement();
                                    String Query = "SELECT * FROM tbl_company WHERE loginid='" + loginid + "'";
                                    ResultSet rs = st.executeQuery(Query);
                                    while (rs.next()) {
                            %>
                            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
                                <img src='../GUEST/img/companylogo/<%=rs.getString("cpylogo")%>' alt="profile"/>
                                <!--<img src='../GUEST/img/companylogo/<%=rs.getString("cpylogo")%>' width="80" height="80">-->
                            </a>
                            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
                                <a class="dropdown-item">
                                    <i class="ti-settings text-primary"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="../GUEST/Guestindex.jsp">
                                    <i class="ti-power-off text-primary" ></i>
                                    Log Out

                                </a>
                            </div>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("exception");
                                }
                            %> 
                        </li>

                    </ul>
                    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                        <span class="icon-menu"></span>
                    </button>
                </div>
            </nav>
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_settings-panel.html -->

                <!-- partial -->

                <!-- partial:partials/_sidebar.html -->
                <nav class="sidebar sidebar-offcanvas" id="sidebar">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="Companyhome.jsp">
                                <i class="icon-grid menu-icon"></i>
                                <span class="menu-title">Home</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Cmpaddproduct.jsp">
                                <i class="icon-plus menu-icon"></i>
                                <span class="menu-title">Add Products</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cpyviewproducts.jsp">
                                <i class="icon-bag menu-icon"></i>
                                <span class="menu-title">View products</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="viewrequests.jsp">
                                <i class="icon-contract menu-icon"></i>
                                <span class="menu-title">View Requests</span>
                            </a>
                        </li>

                         <li class="nav-item">
                            <a class="nav-link" href="viewrequestsbyshop.jsp">
                                <i class="icon-paper menu-icon"></i>
                                <span class="menu-title">Accepted Requests</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Payment.jsp">
                                <i class="icon-pause menu-icon"></i>
                                <span class="menu-title">Payments</span>
                            </a>
                        </li>

                        <!--                        <li class="nav-item">
                                                    <a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
                                                        <i class="icon-grid-2 menu-icon"></i>
                                                        <span class="menu-title">Tables</span>
                                                        <i class="menu-arrow"></i>
                                                    </a>
                                                    <div class="collapse" id="tables">
                                                        <ul class="nav flex-column sub-menu">
                                                            <li class="nav-item"> <a class="nav-link" href="pages/tables/basic-table.html">Basic table</a></li>
                                                        </ul>
                                                    </div>
                                                </li>-->

                       
                        <li class="nav-item">
                            <a class="nav-link" href="feedback.jsp">
                                <i class="icon-command menu-icon"></i>
                                <span class="menu-title">Sent Feedback</span>
                            </a>
                        </li>
                    </ul>
                </nav> 



                <!-- page-body-wrapper ends -->

                <!-- container-scroller -->

                <!-- plugins:js -->
                <script src="vendors/js/vendor.bundle.base.js"></script>
                <!-- endinject -->
                <!-- Plugin js for this page -->
                <script src="vendors/chart.js/Chart.min.js"></script>
                <script src="vendors/datatables.net/jquery.dataTables.js"></script>
                <script src="vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
                <script src="js/dataTables.select.min.js"></script>

                <!-- End plugin js for this page -->
                <!-- inject:js -->
                <script src="js/off-canvas.js"></script>
                <script src="js/hoverable-collapse.js"></script>
                <script src="js/template.js"></script>
                <script src="js/settings.js"></script>
                <script src="js/todolist.js"></script>
                <!-- endinject -->
                <!-- Custom js for this page-->
                <script src="js/dashboard.js"></script>
                <script src="js/Chart.roundedBarCharts.js"></script>
                <!-- End custom js for this page-->
                </body>


                </html>


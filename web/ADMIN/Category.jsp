<jsp:include page ="Adminindex.html"/>


<body class="inner_page login">
    <div class="full_container">
        <div class="container">
            <div class="center verticle_center full_height">
                <div class="login_section">
                    <div class="logo_login">
                        <div class="center">
                            <img width="210" src="images/logo/logo1.png" alt="#" />
                        </div>
                    </div>
                    <div class="login_form">
                        <form action="Categoryregaction.jsp" method="post" enctype="multipart/form-data">

                            <fieldset>
                                <div class="field">
                                    <label class="label_field">Category</label>
                                    <input type="text" name="Category" placeholder="Category Name" />
                                </div>
                                 <div class="field">
                                    <label class="label_field">Description</label>
                                    <input type="text" name="Categorydec" placeholder="Category Description" />
                                </div>
                                <div class="field">
                                    <label class="label_field">Upload Image</label>
                                    <input type="file" name=" Categoryimg" />
                                </div>

                                <div class="field margin_0">
                                    <label class="label_field hidden">hidden label</label>
                                    <button class="main_bt">Add Category</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
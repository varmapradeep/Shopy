                String s = "insert into tbl_product(cpyid,cpyproductname,cpyproductdesc,categoryid,subcategoryid,cpyprdstock,cpyprdunit,cpyprdprice,cpyproductimg1,cpyproductimg2,cpyproductimg3,date)values('" + companyloginid + "','" + cpyprdname + "','" + cpyprddesc + "','" + Category + "','" + subcat + "','" + stock + "','" + unit + "','" + price + "','" + image1 + "','" + image2 + "','" + image3 + "','" + ft.format(dNow) + "')";

                String Category = details.get(0);
                String subcat = details.get(1);
                String cpyprdname = details.get(2);
                String cpyprddesc = details.get(3);
                String stock = details.get(4);
                String unit = details.get(5);
                String price = details.get(6);
                String image1 = fileset.get(0);
                String image2 = fileset.get(1);
                String image3 = fileset.get(2);
                
                
                
                Date dNow = new Date();
                SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");
                
                 String companyloginid = (String)session.getAttribute("loginid");
                 
                     String localpath = "D:/SHOP MANAGMENT SYSTEM/SHOPY/web/COMPANY/images/Product/";

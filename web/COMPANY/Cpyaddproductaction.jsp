<%@page import="shoppackages.ShopClass" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    File file;
    ArrayList<String> fileset = new ArrayList();
    ArrayList<String> details = new ArrayList();
    int maxFileSize = 50000 * 1024;
    int maxMemSize = 50000 * 1024;
    String localpath = "D:/SHOP MANAGMENT SYSTEM/SHOPY/web/COMPANY/images/Product/";
    String filePath = localpath;
    File folder = new File(filePath);
    folder.mkdir();
    // Verify the content type
    String contentType = request.getContentType();
//  out.println(contentType);
    if ((contentType.indexOf("multipart/form-data") >= 0)) {

        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("c:\temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);
        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);
            // Process the uploaded file items
            //out.println("<br/>"+fileItems);
            Iterator i = fileItems.iterator();

            out.println("<html>");
            out.println("<head>");
            out.println("<title>JSP File upload</title>");
            out.println("</head>");
            out.println("<body>");
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();

                out.println("<br/>" + fi);
                if (!fi.isFormField()) {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    // Write the file
                    if (fileName.lastIndexOf("\\") >= 0) {
                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\")));
                    } else {
                        file = new File(filePath
                                + fileName.substring(fileName.lastIndexOf("\\") + 1));
                    }
                    fi.write(file);

                    String fname = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    out.println("<br/>file:  " + fname);
                    fileset.add(fname);
                } else {
                    String key = fi.getString();

                    details.add(key);
                }

            }

            try {
//                String companyloginid = (String) session.getAttribute("loginid");
                String Category = details.get(0);
                String subcat = details.get(1);
                String cpyprdname = details.get(2);
                String cpyprddesc = details.get(3);
//                String stock = details.get(4);
                String unit = details.get(4);
                String price = details.get(5);

                String image1 = fileset.get(0);
                String image2 = fileset.get(1);
                String image3 = fileset.get(2);
                Date dNow = new Date();
                SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd");

                Connection con = ShopClass.getCon();
                Statement st = con.createStatement(); 
                String loginid=(String)session.getAttribute("loginid");
                String s = "insert into tbl_product(cmpyid,cpyproductname,cpyproductdesc,categoryid,subcategoryid,cpyprdunit,cpyprdprice,cpyproductimg1,cpyproductimg2,cpyproductimg3,date)values('" + loginid + "','" + cpyprdname + "','" + cpyprddesc + "','" + Category + "','" + subcat + "','" + unit + "','" + price + "','" + image1 + "','" + image2 + "','" + image3 + "','" + ft.format(dNow) + "')";

                out.println(s);
                st.executeUpdate(s);
                st.close();
                con.close();
                out.println("closed");
                // response.sendRedirect("vehsubreg.jsp");
            } catch (Exception e) {
                out.println(e);
            }
%>
<script>
    alert("Product Added Successfully");
    window.location = "Cmpaddproduct.jsp";
</script>
<%
            out.println("</body>");
            out.println("</html>");
        } catch (Exception ex) {
            System.out.println(ex);
        }
    } else {
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet upload</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<p>No file uploaded</p>");
        out.println("</body>");
        out.println("</html>");
    }
%>


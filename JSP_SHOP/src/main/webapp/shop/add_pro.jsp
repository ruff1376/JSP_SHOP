<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.nio.charset.StandardCharsets" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="org.apache.commons.fileupload2.core.FileItem" %>
<%@ page import="org.apache.commons.fileupload2.core.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload2.jakarta.servlet6.JakartaServletFileUpload" %>

<%
    request.setCharacterEncoding("UTF-8");

    String uploadPath = application.getRealPath("/upload");
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String fileName = null;
    Product product = new Product();

    try {
        
        DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
        JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
        upload.setHeaderCharset(StandardCharsets.UTF_8);

        List<FileItem> items = upload.parseRequest(request);

        for (FileItem item : items) {
            if (item.isFormField()) {
                String field = item.getFieldName();
                String value = item.getString(StandardCharsets.UTF_8);

                switch(field) {
                    case "productId": product.setProductId(value); break;
                    case "name": product.setName(value); break;
                    case "unitPrice": product.setUnitPrice(Integer.parseInt(value)); break;
                    case "description": product.setDescription(value); break;
                    case "manufacturer": product.setManufacturer(value); break;
                    case "category": product.setCategory(value); break;
                    case "unitsInStock": product.setUnitsInStock(Integer.parseInt(value)); break;
                    case "condition": product.setCondition(value); break;
                }
            } else {
                // 파일 저장
                fileName = new File(item.getName()).getName();
                if (!fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    item.write(storeFile.toPath()); // 파일 저장

                    // DB에는 상대 경로로 저장 (ImgServlet에서 이 경로를 사용할 수 있게)
                    product.setFile("upload/" + fileName);
                }
            }

        }

        // DB 저장
        ProductRepository dao = new ProductRepository();
        int result = dao.insert(product);

        if (result > 0) {
%>
        <script>
            alert("상품이 등록되었습니다.");
            location.href = "products.jsp";
        </script>
<%
        } else {
%>
        <script>
            alert("상품 등록에 실패했습니다.");
            history.back();
        </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("예외가 발생했습니다.");
        history.back();
    </script>
<%
    }
%>

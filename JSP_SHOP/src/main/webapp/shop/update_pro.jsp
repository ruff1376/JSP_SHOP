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
    String productId = null;
    Product product = new Product();

    // 기존 상품 정보 조회(기존 파일명 유지 목적)
    ProductRepository dao = new ProductRepository();
    String oldFileName = null;

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
                    case "productId":
                        productId = value;
                        product.setProductId(value);
                        break;
                    case "name": product.setName(value); break;
                    case "unitPrice": product.setUnitPrice(Integer.parseInt(value)); break;
                    case "description": product.setDescription(value); break;
                    case "manufacturer": product.setManufacturer(value); break;
                    case "category": product.setCategory(value); break;
                    case "unitsInStock": product.setUnitsInStock(Integer.parseInt(value)); break;
                    case "condition": product.setCondition(value); break;
                    // quantity 등 다른 필드도 필요하면 추가
                }
            } else {
                // 파일 저장
                fileName = new File(item.getName()).getName();
                if (!fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    item.write(storeFile.toPath());
                    product.setFile(fileName); // 새 파일명 저장
                }
            }
        }

        // 기존 파일명 유지 로직
        if (fileName == null || fileName.isEmpty()) {
            // 기존 상품의 파일명 조회
            Product oldProduct = dao.getProductById(productId);
            if (oldProduct != null) {
                product.setFile(oldProduct.getFile());
            }
        }

        // productId는 반드시 있어야 함
        if (product.getProductId() == null || product.getProductId().isEmpty()) {
%>
        <script>
            alert("상품 코드가 없습니다.");
            history.back();
        </script>
<%
        } else {
            int result = dao.update(product);
            if (result > 0) {
%>
        <script>
            alert("상품이 수정되었습니다.");
            location.href = "products.jsp";
        </script>
<%
            } else {
%>
        <script>
            alert("상품 수정에 실패했습니다.");
            history.back();
        </script>
<%
            }
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

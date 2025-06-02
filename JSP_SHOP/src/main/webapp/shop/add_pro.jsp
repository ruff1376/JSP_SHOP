<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, java.nio.file.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="shop.dao.JDBConnection" %>
<%

    JDBConnection jdbc = new JDBConnection();
    Connection conn = jdbc.con;
%>

<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 수집
    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    String unitPriceStr = request.getParameter("unitPrice");
    String description = request.getParameter("description");
    String manufacturer = request.getParameter("manufacturer");
    String category = request.getParameter("category");
    String unitsInStockStr = request.getParameter("unitsInStock");
    String condition = request.getParameter("condition");

    // 숫자 변환
    int unitPrice = unitPriceStr != null ? Integer.parseInt(unitPriceStr) : 0;
    int unitsInStock = unitsInStockStr != null ? Integer.parseInt(unitsInStockStr) : 0;

    // 유효성 검사: 상품코드 - 'P'로 시작 + 6자리 숫자
    if (!productId.matches("P\\d{6}")) {
        out.println("<script>alert('상품 코드는 P로 시작하는 6자리 숫자여야 합니다.'); history.back();</script>");
        return;
    }

    // 파일 업로드 경로
    String uploadDir = application.getRealPath("/static/uploads/");
    File dir = new File(uploadDir);
    if (!dir.exists()) dir.mkdirs();

    // multipart/form-data 파일 업로드 처리
    Part filePart = request.getPart("file");
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String savedFilePath = "";

    if (fileName != null && !fileName.isEmpty()) {
        savedFilePath = uploadDir + File.separator + fileName;
        filePart.write(savedFilePath);
    }

    // 파일명만 저장 (상대경로용)
    String savedFileName = fileName;

    // DB 저장 처리
    Connection conn = null;d
    PreparedStatement pstmt = null;

    try {
    	
        conn = JDBConnection.getConnection();
        String sql = "INSERT INTO product (product_id, name, unit_price, description, manufacturer, category, units_in_stock, condition, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productId);
        pstmt.setString(2, name);
        pstmt.setInt(3, unitPrice);
        pstmt.setString(4, description);
        pstmt.setString(5, manufacturer);
        pstmt.setString(6, category);
        pstmt.setInt(7, unitsInStock);
        pstmt.setString(8, condition);
        pstmt.setString(9, savedFileName); // 파일 이름만 저장

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("./products.jsp");
        } else {
            out.println("<script>alert('상품 등록에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

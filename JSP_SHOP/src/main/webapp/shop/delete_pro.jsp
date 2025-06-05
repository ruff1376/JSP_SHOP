<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository" %>
<%
    request.setCharacterEncoding("UTF-8");

    String productId = request.getParameter("id");
    
    if (productId != null && !productId.trim().equals("")) {
    	ProductRepository dao = new ProductRepository();  // DAO 객체 생성
        int result = dao.delete(productId); // 삭제 메서드 호출

        if (result > 0) {
            // 삭제 성공 시 상품 목록으로 이동
            response.sendRedirect("products.jsp");
        } else {
            // 삭제 실패
            out.println("<script>alert('삭제에 실패했습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('잘못된 요청입니다.'); history.back();</script>");
    }
%>
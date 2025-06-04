<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, shop.dto.Product" %>

<%
    String cartId = request.getParameter("cartId");
    String productId = request.getParameter("productId");
    // 세션에서 cartList 가져오기
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");

    if (cartList != null) {
        if (productId != null && !productId.trim().isEmpty()) {
            // 개별 상품 삭제
            Iterator<Product> it = cartList.iterator();
            while (it.hasNext()) {
                Product p = it.next();
                if (p.getProductId().equals(productId)) {
                    it.remove();
                    break;
                }
            }
        } else {
            // 전체 삭제
            cartList.clear();
        }
        // 세션에 cartList 갱신
        session.setAttribute("cartList", cartList);
    }
    // 삭제 후 장바구니로 이동
    response.sendRedirect("cart.jsp");
%>

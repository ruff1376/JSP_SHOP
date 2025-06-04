<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="java.util.*" %>

<%
    // 1. 상품 ID 가져오기
    String productId = request.getParameter("id");

    // 2. DB에서 해당 상품 정보 가져오기
    ProductRepository dao = new ProductRepository();
    Product product = dao.getProductById(productId);

    // 3. 수량 기본값 1 설정
    product.setQuantity(1);

    // 4. 세션에서 cartList 가져오기 (없으면 새로 생성)
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    if (cartList == null) {
        cartList = new ArrayList<Product>();
    }

    // 5. 이미 같은 상품이 있으면 수량 증가
    boolean found = false;
    for (Product p : cartList) {
        if (p.getProductId().equals(productId)) {
            p.setQuantity(p.getQuantity() + 1);
            found = true;
            break;
        }
    }

    if (!found) {
        cartList.add(product);
    }

    // 6. 세션에 cartList 저장
    session.setAttribute("cartList", cartList);

    // 7. products.jsp로 리다이렉트
    response.sendRedirect("products.jsp");
%>

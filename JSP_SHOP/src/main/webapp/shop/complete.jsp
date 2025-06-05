<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%@ page import="java.util.UUID, shop.dto.Order" %>
<%@ page import="shop.dto.Order, shop.dto.Product, java.util.*" %>
<%@ page import="shop.dao.OrderRepository, shop.dao.ProductIORepository, shop.dao.ProductRepository" %>
<%
    // 1. 주문 정보 저장
    OrderRepository orderRepo = new OrderRepository();
    ProductIORepository ioRepo = new ProductIORepository();
    ProductRepository productRepo = new ProductRepository();

    Order order = (Order) session.getAttribute("order");
    String address = (order != null) ? order.getAddress() : "배송지 정보 없음";
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");

    // 회원/비회원 정보 세팅
    String userId = request.getParameter("userId");
    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");
    if (userId != null && !userId.trim().isEmpty()) {
        order.setUserId(userId);
    } else {
        order.setPhone(phone);
        order.setOrderPw(orderPw);
    }

    // 총 금액 계산
    int totalPrice = 0;
    for (Product p : cartList) {
        totalPrice += p.getUnitPrice() * p.getQuantity();
    }
    order.setTotalPrice(totalPrice);

    // 1. 주문 테이블에 추가
    orderRepo.insert(order);

    // 2. 방금 추가한 주문의 order_no 조회
    int orderNo = orderRepo.lastOrderNo();

    // 3. 각 상품별로 입출고 테이블에 출고(OUT) 데이터 추가 및 재고 감소
    for (Product p : cartList) {
        // 입출고 데이터 추가
        p.setOrderNo(orderNo);
        p.setType("OUT");
        p.setUserId(userId); // 회원일 경우만, 비회원은 null
        ioRepo.insert(p);

        // 상품 재고 감소
        Product dbProduct = productRepo.getProductById(p.getProductId());
        dbProduct.setQuantity(dbProduct.getQuantity() - p.getQuantity());
        productRepo.update(dbProduct);
    }

    // 세션 정리
    session.removeAttribute("cartList");
    session.removeAttribute("order");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp"/>
	
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	
			<!-- 주문 완료 확인 -->
		<div class="container order mb-5 p-5">
		    <h2 class="text-center">주문이 완료되었습니다.</h2>
		
		    <!-- 주문정보 -->
		    <div class="ship-box">
		        <table class="table">
		            <tr>
		                <td>주문번호 :</td>
		                <td><%= orderNo %></td>
		            </tr>
		            <tr>
		                <td>배송지 :</td>
		                <td><%= address %></td>
		            </tr>
		        </table>
		
		        <%
				    String queryString = "";
				    if (userId != null) {
				        queryString = "?userId=" + userId;
				    } else if (phone != null && orderPw != null) {
				        queryString = "?phone=" + phone + "&orderPw=" + orderPw;
				    }
				%>
				<div class="btn-box d-flex justify-content-center">
				    <a href="<%= root %>/user/order.jsp<%= queryString %>" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
				</div>
		    </div>
		</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%@ page import="shop.dto.Order" %>
<%
    // cartId는 세션ID를 기본으로 사용하거나, 파라미터로 전달받을 수 있습니다.
    String cartId = request.getParameter("cartId");
    if (cartId == null || cartId.trim().isEmpty()) {
        cartId = session.getId();
    }
%>
<%
	Order order = (Order) session.getAttribute("order");
	if (order == null) {
	    order = new Order();
	    order.setCartId(cartId);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보</title>
<jsp:include page="/layout/link.jsp" />
</head>
<body>
<jsp:include page="/layout/header.jsp"/>

<!-- 배송 정보 입력 -->
	<div class="px-4 py-5 my-5 text-center">
			<h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
		</div>
		
		<!-- 배송 정보 입력 -->
		<div class="container shop mb-5 p-4">
			<form action="ship_pro.jsp" class="form-horizontal" method="post">
				<input type="hidden" name="cartId" value="<%= session.getId() %>" />
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">성명</label>
					<input type="text" class="form-control col-md-10" name="name"
						   value="<%= order.getShipName() != null ? order.getShipName() : "" %>" required>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">배송일</label>
					<input type="text" class="form-control col-md-10" name="shippingDate"
						   value="<%= order.getDate() != null ? order.getDate() : "" %>" required>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">국가명</label>
					<input type="text" class="form-control col-md-10" name="country"
							value="<%= order.getCountry() != null ? order.getCountry() : "" %>" required>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">우편번호</label>
					<input type="text" class="form-control col-md-10" name="zipCode"
							value="<%= order.getZipCode() != null ? order.getZipCode() : "" %>" required>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">주소</label>
					<input type="text" class="form-control col-md-10" name="address"
							value="<%= order.getAddress() != null ? order.getAddress() : "" %>" required>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="">전화번호</label>
					<input type="text" class="form-control col-md-10" name="phone"
							value="<%= order.getPhone() != null ? order.getPhone() : "" %>" required>
				</div>
				
				<!-- 버튼 영역 -->
				<div class="d-flex justify-content-between mt-5 mb-5">
					<div class="item">
						<a href="cart.jsp" class="btn btn-lg btn-success">이전</a>
						<!-- 취소 프로세스는 이어서... -->				
						<a href="<%= root %>" class="btn btn-lg btn-danger">취소</a>				
					</div>
					<div class="item">
						<input type="submit" class="btn btn-lg btn-primary" value="등록" />
					</div>
				</div>
				
			</form>
		</div>

<jsp:include page="/layout/footer.jsp" />
<jsp:include page="/layout/script.jsp" />
</body>
</html>

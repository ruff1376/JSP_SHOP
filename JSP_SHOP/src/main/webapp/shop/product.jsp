<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dto.Product" %>
<%@ page import="shop.dao.ProductRepository" %>
<%@ include file="/layout/meta.jsp"%>
<%
    // 1. 요청 파라미터로 상품 ID 받기
    String productId = request.getParameter("id");

    // 2. DAO를 통해 상품 조회
    ProductRepository repo = new ProductRepository();
    Product product = repo.getProductById(productId);

    if (product == null) {
%>
    <p>해당 상품 정보를 찾을 수 없습니다.</p>
<%
    return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp"/>

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="./products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
			</div>
		</div>
	</div>
	
	<!-- 상품 정보 영역 -->
	
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<!-- [NEW] 썸네일 이미지 요청하기 추가 -->
				<img src="img?id=<%= product.getProductId() %>" class="w-100 p-2" />
			</div>
			<div class="col-md-6">
				<h3 class="mb-5"><%= product.getName() %></h3>
			<table class="table">
				<tr><td>상품ID :</td><td><%= product.getProductId() %></td></tr>
				<tr><td>제조사 :</td><td><%= product.getManufacturer() %></td></tr>
				<tr><td>분류 :</td><td><%= product.getCategory() %></td></tr>
				<tr><td>상태 :</td><td><%= product.getCondition() %></td></tr>
				<tr><td>재고 수 :</td><td><%= product.getUnitsInStock() %></td></tr>
				<tr><td>가격 :</td><td><%= product.getUnitPrice() %> 원</td></tr>
			</table>
				<div class="mt-4">
					<form name="addForm" action="<%= root %>/shop/cart_pro.jsp" method="post">
						<input type="hidden" name="id" value="<%= product.getProductId() %>" />
						<div class="btn-box d-flex justify-content-end ">
							<!-- [NEW] 장바구니 버튼 추가 -->
							<a href="<%= root %>/shop/cart.jsp" class="btn btn-lg btn-warning mx-3">장바구니</a>
							
							<!-- 페이지 이동 막기 :  href="javascript:;" -->			
							<a href="javascript:;" class="btn btn-lg btn-success mx-3" onclick="addToCart()">주문하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" /> 
	<script>
	
		// 장바구니 추가
		function addToCart() {
		    if (confirm("상품을 장바구니에 추가하고 바로 주문하시겠습니까?")) {
		        document.addForm.target = "_self";
		        document.addForm.action = "<%= root %>/shop/cart_pro.jsp?redirect=order";
		        document.addForm.submit();
		    } else {
		        document.addForm.reset();
		    }
		}

		
	</script>
<body>

</body>
</html>
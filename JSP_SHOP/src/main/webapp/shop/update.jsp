<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>

<%
    String productId = request.getParameter("id");
    if (productId == null || productId.trim().isEmpty()) {
        out.println("<script>alert('상품 코드가 없습니다.'); location.href='products.jsp';</script>");
        return;
    }
    
    ProductRepository dao = new ProductRepository();
    Product product = dao.getProductById(productId);
    
    if (product == null) {
        out.println("<script>alert('상품 정보를 찾을 수 없습니다.'); location.href='products.jsp';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp"/>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	
	<!-- 상품 수정 입력 화면 -->
	<div class="container shop">
		<!-- [NEW] enctype 추가 -->
		<form name="product" action="./update_pro.jsp" onsubmit="return checkProduct()" method="post" enctype="multipart/form-data">
			
			<div class="input-group mb-3 row">
				<img src="img?id=<%=product.getProductId()%>" class="w-100 p-2" />
			</div>
			
				
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-10" name="file">
			</div>	
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 코드</label>
				<input type="text" class="form-control col-md-10" name="productId" 
						value="<%=product.getProductId()%>" readonly>
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품명</label>
				<input type="text" class="form-control col-md-10" name="name"
						value="<%=product.getName()%>" >
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">가격</label>
				<input type="number" class="form-control col-md-10" name="unitPrice"
						value="<%=product.getUnitPrice()%>" >
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text w-100" id="">상세 정보</label>
				<textarea class="form-control" name="description" style="height: 200px !important;"
						><%=product.getDescription()%></textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">제조사</label>
				<input type="text" class="form-control col-md-10" name="manufacturer"
						value="<%=product.getManufacturer()%>" >
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">분류</label>
				<input type="text" class="form-control col-md-10" name="category"
						value="<%=product.getCategory()%>" >
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label>
				<input type="number" class="form-control col-md-10" name="unitsInStock"
						value="<%=product.getUnitsInStock()%>" >
			</div>
			<div class="input-group mb-3 row">
				<div class="col-md-2 p-0">
					<label class="input-group-text" id="">상태</label>
				</div>
				<div class="col-md-10 d-flex align-items-center">
					<div class="radio-box d-flex">
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input" name="condition" value="NEW" id="condition-new" 
							<%= "NEW".equals(product.getCondition()) ? "checked" : "" %> />
							<label for="condition-new">신규 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input" name="condition" value="OLD" id="condition-old" 
							<%= "OLD".equals(product.getCondition()) ? "checked" : "" %> />
							<label for="condition-old">중고 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input" name="condition" value="RE" id="condition-re" 
							<%= "RE".equals(product.getCondition()) ? "checked" : "" %> />
							<label for="condition-re">재생 제품</label>
						</div>
					</div>
				</div>
			</div>
			
			<div class="d-flex justify-content-between mt-5 mb-5">
				<a href="./products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-success" value="수정" />
			</div>
		
		</form> 
	
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" /> 
	<script>
		
    // 서버에서 가져온 상태값을 JS 변수로 설정
    let condition = "<%= product.getCondition() %>";
    
    // 상태 라디오 버튼 중 해당하는 값 체크
    let radioCondition = document.querySelector('[name="condition"][value="' + condition + '"]');
    if (radioCondition) {
        radioCondition.checked = true;
    }

    function checkProduct() {
        return true;
    }
		
		
	</script>	
	

</body>
</html>
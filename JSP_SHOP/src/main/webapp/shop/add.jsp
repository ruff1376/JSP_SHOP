<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add</title>
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<jsp:include page="/layout/header.jsp"/>
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 등록</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
		</div>
	</div>
	
	<!-- 상품 등록 입력 화면 -->
	<div class="container shop">
		<!-- [NEW] enctype 추가 -->
		<form name="product" action="./add_pro.jsp" onsubmit="return checkProduct()" method="post" enctype="multipart/form-data">
			
			<!-- [NEW] 파일 입력 추가 -->
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 이미지</label>
				<input type="file" class="form-control col-md-10" name="file">
			</div>	
		
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품 코드</label>
				<input type="text" class="form-control col-md-10" name="productId">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">상품명</label>
				<input type="text" class="form-control col-md-10" name="name">
			</div>
			
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">가격</label>
				<input type="number" class="form-control col-md-10" name="unitPrice">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text w-100" id="">상세 정보</label>
				<textarea class="form-control" name="description" 
						  style="height: 200px !important;"></textarea>
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">제조사</label>
				<input type="text" class="form-control col-md-10" name="manufacturer">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">분류</label>
				<input type="text" class="form-control col-md-10" name="category">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label>
				<input type="number" class="form-control col-md-10" name="unitsInStock">
			</div>
			<div class="input-group mb-3 row">
				<div class="col-md-2 p-0">
					<label class="input-group-text" id="">상태</label>
				</div>
				<div class="col-md-10 d-flex align-items-center">
					<div class="radio-box d-flex">
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input" name="condition" value="NEW" id="condition-new"> 
							<label for="condition-new">신규 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input " name="condition" value="OLD" id="condition-old"> 
							<label for="condition-old">중고 제품</label>
						</div>
						
						<div class="radio-item mx-5">
							<input type="radio" class="form-check-input " name="condition" value="RE" id="condition-re"> 
							<label for="condition-re">재생 제품</label>
						</div>
					</div>
				</div>
			</div>
			
			<div class="d-flex justify-content-between mt-5 mb-5">
				<a href="./products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-primary" value="등록" />
			</div>
		
		</form> 
	
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
	<script src="/static/js/validation.js"></script>
	<script>
		function checkProduct() {
			let form = document.product;
		
			let productId = form.productId;
			let name = form.name;
			let unitPrice = form.unitPrice;
			let unitsInStock = form.unitsInStock;
			let description = form.description;
			let manufacturer = form.manufacturer;
			let category = form.category;
			let condition = form.condition;
		
			let msg = '';
		
			// 상품 아이디 체크 - P숫자 6자리
			let productIdCheck = /^P[0-9]{6}$/;
			msg = '상품 아이디는 "P6자리" 로 입력해주세요';
			if (!check(productIdCheck, productId, msg)) return false;
		
			// 상품명 체크 - 2글자 이상 20글자 이하
			let nameCheck = /^.{2,20}$/;
			msg = '상품명은 2~20자 이내로 입력해주세요';
			if (!check(nameCheck, name, msg)) return false;
		
			// 가격 체크 - 숫자로 1글자 이상
			let priceCheck = /^\d{1,}$/;
			msg = '가격은 1글자 이상의 숫자로 입력해주세요';
			if (!check(priceCheck, unitPrice, msg)) return false;
		
			// 재고 체크 - 숫자로 1글자 이상
			let stockCheck = /^\d{1,}$/;
			msg = '재고는 1글자 이상의 숫자로 입력해주세요';
			if (!check(stockCheck, unitsInStock, msg)) return false;
		
			// 상세 정보 체크 - 5자 이상 필수
			if (description.value.trim().length < 1) {
				alert('상세 정보는 1자 이상 입력해주세요');
				description.focus();
				return false;
			}
		
			// 제조사 체크 - 공백불가, 2~30자
			let manufacturerCheck = /^.{2,30}$/;
			msg = '제조사는 2~30자 이내로 입력해주세요';
			if (!check(manufacturerCheck, manufacturer, msg)) return false;
		
			// 분류 체크 - 공백불가, 2~30자
			let categoryCheck = /^.{2,30}$/;
			msg = '분류는 2~30자 이내로 입력해주세요';
			if (!check(categoryCheck, category, msg)) return false;
		
			// 상태 체크 - 라디오 버튼 선택 여부
			let conditionChecked = false;
			for (let i = 0; i < condition.length; i++) {
				if (condition[i].checked) {
					conditionChecked = true;
					break;
				}
			}
			if (!conditionChecked) {
				alert('제품 상태를 선택해주세요');
				return false;
			}
		
			return true;
		}
		
		// 공통 체크 함수 (기존 validation.js에 있음)
		function check(regExp, input, msg) {
			if (!regExp.test(input.value)) {
				alert(msg);
				input.focus();
				return false;
			}
			return true;
		}
</script>
	
	

</body>
</html>
/**
 *  유효성 검사 
 */
function checkProduct() {
	let form = document.product
	let productId = form.productId
	let name = form.name
	let unitPrice = form.unitPrice
	let unitsInStock = form.unitsInStock
	
	let msg = ''
	
	// 상품아이디 체크
	// - P숫자 6자리
	let productIdCheck = /^P[0-9]{6}$/
	msg = '상품 아이디는 "P6자리" 로 입력해주세요' 
	if( !check(productIdCheck, productId, msg) ) return false
	
	// 상품명 체크
	// - 2글자 이상 20글자 이하
	let nameCheck = /^.{2,20}$/
	msg = '상품명은 2~20자 이내로 입력해주세요'
	if( !check(nameCheck, name, msg) ) return false
	
	// 가격 체크
	// - 숫자로 1글자 이상
	let priceCheck = /^\d{1,}$/
	msg = '가격은 1글자 이상의 숫자로 입력해주세요'
	if( !check(priceCheck, unitPrice, msg) ) return false
	
	// 재고 체크
	// - 숫자로 1글자 이상
	let stockCheck = /^\d{1,}$/
	msg = '재고는 1글자 이상의 숫자로 입력해주세요'
	if( !check(stockCheck, unitsInStock, msg) ) return false
	
	return true
}

// 정규표현식 유효성 검사 함수
function check(regExp, element, msg) {
	
	if( regExp.test(element.value) ) {
		return true
	}
	alert(msg)
	element.select()
	element.focus()
	return false
}

// 회원가입 아이디, 비밀번호, 비밀번호 확인, 이름 유효성 검사 함수
function checkJoin() {
	console.log("checkJoin 호출");
	let form = document.joinForm
	
	// 아이디 : 첫 글자가 영문자 또는 한글
	let idCheck = /^[가-힣a-zA-Z][a-zA-Z0-9_]{4,19}$/
	if (!idCheck.test(form.id.value)) {
		alert("아이디는 첫글자는 영문자 또는 한글만 가능합니다. (영문자, 한글, 숫자 조합 가능)")
		form.id.select()
		form.id.focus()
		return false
	}
	
	// 비밀번호 : 영문자, 숫자, 특수문자가 반드시 포함되고 특수문자는 반드시 1개이상 포함, 전체 글자수는 6글자 이상
	let pwCheck = /^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{6,}$/
	if (!pwCheck.test(form.pw.value)) {
		alert("비밀번호는 영문자, 숫자, 특수문자가 반드시 포함되고 특수문자는 반드시 1개이상 포함하여 전체 글자수가 6글자 이상이어야합니다.")
		form.pw.select()
		form.pw.focus()
		return false
	}
	
	// 비밀번호 확인
	if (form.pw.value !== form.pw_confirm.value) {
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
		form.pw_confirm.select()
		form.pw_confirm.focus()
		return false
	}

	// 이름 : 한글로만 2글자 이상
	let nameCheck = /^[가-힣]{2,20}$/
	if (!nameCheck.test(form.name.value)) {
		alert("이름은 한글로만 2글자 이상으로 작성해야합니다.")
		form.name.select()
		form.name.focus()
		return false
	}
	
	// 통과
	return true
}
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 사이트 맵 -->
<link rel="sitemap" href="/static/sitemap.xml">
    
<!-- bootstrap lib -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<!-- Noto Sans font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans:400,700&display=swap">

<!-- material design icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link href="/static/css/style.css" rel="stylesheet" />
</head>
<body>   
		<jsp:include page="/layout/header.jsp" />
	
	<div class="row m-0 mypage">
		<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
			<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary">
			    <ul class="nav nav-pills flex-column mb-auto">
			      <!-- 로그인 시 -->
			      
			      <li class="nav-item">
			        <a href="/user/index.jsp" class="nav-link link-body-emphasis">
			          마이 페이지
			        </a>
			      </li>
			      <li class="nav-item">
			        <a href="/user/update.jsp" class="nav-link link-body-emphasis">
			          회원정보 수정
			        </a>
			      </li>
			      
			      
			      <li>
			        <a href="#" class="nav-link active" aria-current="page" >
			          주문내역
			        </a>
			      </li>
			    </ul>
			    <hr>
			  </div>
		</div>
		
		<div class="col-md-9 ms-sm-auto col-lg-10 p-0 m-0">
			<div class="px-4 py-3 my-3 text-center">
				<h1 class="display-5 fw-bold text-body-emphasis">주문 내역</h1>
				<div class="col-lg-6 mx-auto">
					
				</div>
			</div>
			
			<!-- 주문 내역 영역 -->
			<div class="container shop m-auto mb-5">
					<form action="/user/order_pro.jsp" method="post">
					
					</form>
				
				<!-- 주문 내역 목록 -->
				<table class="table table-striped table-hover table-bordered text-center align-middle">
					<thead>
						<tr class="table-primary">
							<th>주문번호</th>
							<th>상품</th>
							<th>가격</th>
							<th>수량</th>
							<th>소계</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						
						<tr>
							<td>7</td>			
							<td>오라클 데이터베이스</td>			
							<td>20000</td>			
							<td>1</td>			
							<td>20000</td>			
							<td></td>			
						</tr>
						
						<tr>
							<td>7</td>			
							<td>JSP</td>			
							<td>80000</td>			
							<td>1</td>			
							<td>80000</td>			
							<td></td>			
						</tr>
						
						<tr>
							<td>8</td>			
							<td>HTML CSS JAVASCRIPT</td>			
							<td>15000</td>			
							<td>1</td>			
							<td>15000</td>			
							<td></td>			
						</tr>
						
						<tr>
							<td>8</td>			
							<td>자바 프로그래밍</td>			
							<td>50000</td>			
							<td>1</td>			
							<td>50000</td>			
							<td></td>			
						</tr>
						
						<tr>
							<td>9</td>			
							<td>고지민</td>			
							<td>2000000</td>			
							<td>1</td>			
							<td>2000000</td>			
							<td></td>			
						</tr>
						
						<tr>
							<td>9</td>			
							<td>HTML CSS JAVASCRIPT</td>			
							<td>15000</td>			
							<td>1</td>			
							<td>15000</td>			
							<td></td>			
						</tr>
						
					</tbody>
					<tfoot>
						
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td id="cart-sum">2180000</td>
							<td></td>
						</tr>
						
					</tfoot>
				</table>
				
				
			</div>
			
			

		</div>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" /> 

	<script>
		
		let form = document.updateForm
		
		// 성별 선택
		let tempGender = document.getElementById('temp-gender')
		let radioFemale = document.getElementById('gender-female')
		let radioMale = document.getElementById('gender-male')
		// alert(tempGender.value)
		if( tempGender.value == '남' )		radioMale.checked = true
		if( tempGender.value == '여' )		radioFemale.checked = true
		
		
		// 생일 월 (select) 선택
		let tempMonth = document.getElementById('temp-month')
		let selectMonth = form.month
		selectMonth.value = tempMonth.value
		
		
		// 메일 도메인 (select) 선택
		let tempEmail2 = document.getElementById('temp-email2')
		let selectEmail2 = form.email2
		selectEmail2.value = tempEmail2.value
		
		
		// 탈퇴 체크
		function alertDel() {

			let form = document.updateForm

			let check = confirm('정말 탈퇴하시겠습니까?')

			if( check ) {
				form.action = 'delete.jsp'
				form.submit()
			}

		}
	
	</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%@ page import="java.util.UUID, shop.dto.Order" %>

<%
    // 주문번호 생성
    String orderNo = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();

    // 배송지 추출
    Order order = (Order) session.getAttribute("order");
    String address = (order != null) ? order.getAddress() : "배송지 정보 없음";

    // 세션 정리 (선택적으로 처리 가능)
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
		
		        <div class="btn-box d-flex justify-content-center">
		            <a href="/user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
		        </div>
		    </div>
		</div>
	
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
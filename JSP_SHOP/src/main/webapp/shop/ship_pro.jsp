<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dto.Order" %>
    
<%	
	request.setCharacterEncoding("UTF-8");
	
	// 배송 정보를 Order 객체에 담기
	Order order = new Order();
	order.setCartId(request.getParameter("cartId"));
	order.setShipName(request.getParameter("name"));
	order.setDate(request.getParameter("shippingDate"));
	order.setCountry(request.getParameter("country"));
	order.setZipCode(request.getParameter("zipCode"));
	order.setAddress(request.getParameter("address"));
	order.setPhone(request.getParameter("phone"));
	
	 // 예: 세션에 저장 후 다음 페이지로 이동
    session.setAttribute("order", order);
	 
    response.sendRedirect("order.jsp"); // 다음 페이지로 이동
	
%>
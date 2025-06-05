<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp"%>
<%
	// 비회원 주문 내역 세션에 등록 처리
	request.setCharacterEncoding("UTF-8");

    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");

 	// 기존 세션값 제거
 	session.removeAttribute("orderList");
 	session.removeAttribute("orderPhone");
 	session.removeAttribute("orderPw");

 	if (phone != null && orderPw != null && !phone.isEmpty() && !orderPw.isEmpty()) {
 		OrderRepository orderDAO = new OrderRepository();
 		List<Product> orderList = orderDAO.list(phone, orderPw);

 		if (orderList != null && !orderList.isEmpty()) {
 			session.setAttribute("orderList", orderList);
 		}
 		session.setAttribute("orderPhone", phone);  // 조회 여부 플래그
 		session.setAttribute("orderPw", orderPw);
 	}
		
	response.sendRedirect(root + "/user/order.jsp");
%>

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

    OrderRepository orderDAO = new OrderRepository();
    List<Product> orderList = orderDAO.list(phone, orderPw);

    if (orderList != null && !orderList.isEmpty()) {
        session.setAttribute("orderList", orderList); // 주문 내역 저장
        session.setAttribute("orderPhone", phone);    // 조회 확인을 위한 플래그
        session.setAttribute("orderPw", orderPw);
    } else {
        session.removeAttribute("orderList");
        session.setAttribute("orderPhone", phone);
        session.setAttribute("orderPw", orderPw);
    }
		
	response.sendRedirect(root + "/user/order.jsp");

%>
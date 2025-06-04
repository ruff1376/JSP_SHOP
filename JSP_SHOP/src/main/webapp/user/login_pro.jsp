<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	
	UserRepository userDAO = new  UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	// 로그인 실패
	if (loginUser == null) {
		response.sendRedirect("login.jsp?error=0");
		return;
	}
	
	// 로그인 성공
	session.setAttribute("loginId", loginUser.getId());
	
	// - 세션에 아이디 등록
	
	// 아이디 저장
	String rememberId = request.getParameter("remember-id");
	if ("on".equals(rememberId)) {
		Cookie rememberCookie = new Cookie("rememberId", URLEncoder.encode(id, "UTF-8"));
		rememberCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 유지
		response.addCookie(rememberCookie);
	} else {
		Cookie rememberCookie = new Cookie("rememberId", "");
		rememberCookie.setMaxAge(0);
		response.addCookie(rememberCookie);
	}
	
	// 자동 로그인
	
	// 쿠키 전달
	
	// 로그인 성공 페이지로 이동
	response.sendRedirect("complete.jsp?msg=0");		

%>






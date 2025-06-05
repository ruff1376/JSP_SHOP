<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//세션에서 로그인 ID 가져오기
	String loginId = (String) session.getAttribute("loginId");
	
	if (loginId == null || loginId.isEmpty()) {
	    // 로그인하지 않은 사용자는 홈으로 이동
	    response.sendRedirect(request.getContextPath() + "/");
	    return;
	}
	
	// 사용자 삭제
	UserRepository userDAO = new UserRepository();
	int result = userDAO.delete(loginId);
	
	if (result > 0) {
	    // 세션 무효화 (로그아웃)
	    session.invalidate();
	
	    // 탈퇴 완료 페이지로 리다이렉트 (msg=3)
	    response.sendRedirect(request.getContextPath() + "/user/complete.jsp?msg=3");
	} else {
	    // 실패 시 에러 페이지나 이전 페이지로 리다이렉트
	    response.sendRedirect(request.getContextPath() + "/user/update.jsp?error=delete");
	}
%>

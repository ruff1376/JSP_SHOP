<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<%	
	// 자동 로그인, 토큰 쿠키 삭제
	Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("autoLoginToken".equals(cookie.getName())) {
                cookie.setMaxAge(0);  // 삭제
                cookie.setPath("/");  // 경로 일치 필요
                response.addCookie(cookie);
            }
        }
    }
    
	// 세션 무효화
	session.invalidate();
	
	// 쿠키 전달
	for (Cookie cookie : cookies) {
        if ("rememberId".equals(cookie.getName())) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }
    }
	
	response.sendRedirect(root);
%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 회원 정보 수정 처리
	String id = request.getParameter("id");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");

    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String birth = (year != null && month != null && day != null) ? year + "-" + month + "-" + day : "";

    String email1 = request.getParameter("email1");
    String email2 = request.getParameter("email2");
    String email = (email1 != null && email2 != null) ? email1 + "@" + email2 : "";

    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    User user = new User();
    user.setId(id);
    user.setName(name);
    user.setGender(gender);
    user.setBirth(birth);
    user.setMail(email);
    user.setPhone(phone);
    user.setAddress(address);
	
	UserRepository userDAO = new UserRepository();
    int result = userDAO.update(user);
    
    if (result > 0) {
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }

%>

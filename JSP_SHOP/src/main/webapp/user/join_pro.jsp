<!-- 
	회원 가입 처리
 -->
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "-" + month + "-" + day;
	
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String mail = email1 + "@" + email2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	String registDay = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

	User user = new User();
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	user.setAddress(address);
	user.setRegistDay(registDay);
	
	UserRepository userDAO = UserRepository.getInstance();
	int result = userDAO.insert(user);

	if (result > 0) {
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	} else {
		out.println("<script>alert('회원가입 실패!'); history.back();</script>");
	}
%>
    
    

    
    
    
    
    
    
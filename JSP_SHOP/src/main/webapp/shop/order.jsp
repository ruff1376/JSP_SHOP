<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/layout/meta.jsp" %>
<%@ page import="shop.dto.Order, shop.dto.Product, java.util.*" %>
<%
    Order order = (Order) session.getAttribute("order");
    if (order == null) {
        out.println("<script>alert('주문 정보가 없습니다.'); location.href='ship.jsp';</script>");
        return;
    }

    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    String cartId = session.getId();

    String userId = (String) session.getAttribute("loginId");
    boolean isMember = (userId != null && !userId.trim().isEmpty());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 정보</title>
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
<jsp:include page="/layout/header.jsp"/>

<div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
</div>

<div class="container order mb-5">
    <form action="complete.jsp" method="post">
        <!-- 배송정보 -->
        <div class="ship-box">
            <table class="table">
                <tr>
                    <td>주문 형태 :</td>
                    <td><%= isMember ? "회원" : "비회원 주문" %></td>
                </tr>
                <tr><td>성 명 :</td><td><%= order.getShipName() %></td></tr>
                <tr><td>우편번호 :</td><td><%= order.getZipCode() %></td></tr>
                <tr><td>주소 :</td><td><%= order.getAddress() %></td></tr>
                <tr><td>배송일 :</td><td><%= order.getDate() %></td></tr>
                <tr><td>전화번호 :</td><td><%= order.getPhone() %></td></tr>

                <% if (!isMember) { %>
                <tr>
                    <td>주문 비밀번호 :</td>
                    <td><input type="password" class="form-control" name="orderPw" required></td>
                </tr>
                <% } %>
            </table>
        </div>

        <!-- 주문목록 -->
        <div class="cart-box">
            <table class="table table-striped table-hover table-bordered text-center align-middle">
                <thead>
                    <tr class="table-primary">
                        <th>상품</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>소계</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int total = 0, count = 0;
                        if (cartList != null && !cartList.isEmpty()) {
                            for (Product p : cartList) {
                                int subtotal = p.getQuantity() * p.getUnitPrice();
                                total += subtotal;
                                count += p.getQuantity();
                    %>
                    <tr>
                        <td><%= p.getName() %></td>
                        <td><%= p.getUnitPrice() %> 원</td>
                        <td><%= p.getQuantity() %></td>
                        <td><%= subtotal %> 원</td>
                        <td></td>
                    </tr>
                    <%      }
                        } else { %>
                    <tr><td colspan="5">추가된 상품이 없습니다.</td></tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <% if (cartList != null && !cartList.isEmpty()) { %>
                    <tr class="table-secondary">
                        <td colspan="2">총 수량</td>
                        <td><strong><%= count %></strong></td>
                        <td colspan="2"><strong><%= total %></strong> 원</td>
                    </tr>
                    <% } %>
                </tfoot>
            </table>
        </div>

        <!-- 숨겨진 필드 -->
        <% if (isMember) { %>
            <input type="hidden" name="userId" value="<%= userId %>" />
        <% } else { %>
            <input type="hidden" name="phone" value="<%= order.getPhone() %>" />
        <% } %>

        <!-- 버튼 -->
        <div class="d-flex justify-content-between mt-5 mb-5">
            <div class="item">
                <a href="ship.jsp" class="btn btn-lg btn-success">이전</a>
                <a href="<%= root %>" class="btn btn-lg btn-danger">취소</a>
            </div>
            <div class="item">
                <input type="submit" class="btn btn-lg btn-primary" value="주문완료" />
            </div>
        </div>
    </form>
</div>

<jsp:include page="/layout/footer.jsp" />
<jsp:include page="/layout/script.jsp" />
</body>
</html>

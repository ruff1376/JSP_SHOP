<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, shop.dto.Product" %>
<%@ include file="/layout/meta.jsp"%>
<%
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    String cartId = session.getId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList</title>
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <jsp:include page="/layout/header.jsp"/>
    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">장바구니 목록 입니다.</p>
        </div>
    </div>
    <div class="container order">
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
                int total = 0;
                int count = 0;
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
                    <td>
                        <!-- 개별 삭제: cartId(세션ID)와 상품ID 전달 -->
                        <a href="deleteCart.jsp?cartId=<%= cartId %>&productId=<%= p.getProductId() %>" class="btn btn-sm btn-danger">삭제</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="5">추가된 상품이 없습니다.</td>
                </tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <%
                if (cartList != null && !cartList.isEmpty()) {
            %>
                <tr class="table-secondary">
                    <td colspan="2">총 수량</td>
                    <td><strong><%= count %></strong></td>
                    <td colspan="2">
                        <strong id="cartList-sum"><%= total %></strong> 원
                    </td>
                </tr>
            <%
                }
            %>
            </tfoot>
        </table>
        <div class="d-flex justify-content-between align-items-center p-3">
            <!-- 전체 삭제: cartId(세션ID)만 전달 -->
            <a href="deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-lg btn-danger">전체삭제</a>
            <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
        </div>
    </div>
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" /> 
    <script>
        let cartId = '<%= cartId %>';
        let cartListCount = '<%= count %>';
        let cartListSum = document.getElementById('cartList-sum');
        function order() {
            if (cartListCount == 0) {
                alert('장바구니에 담긴 상품이 없습니다.');
                return;
            }
            let msg = '총 ' + cartListCount + '개의 상품을 주문합니다. \n총 주문금액 : ' + cartListSum.textContent;
            let check = confirm(msg);
            if (check) {
                location.href = 'ship.jsp?cartId=' + cartId;
            }
        }
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/view/include/top.jsp" />
<link rel="stylesheet" href="${path}/resources/css/purchase.css">

<section id="purchase_list_main">
    <div class="list_header_area">
        <h2>나의 주문 내역</h2>
        <p>최근 주문하신 내역을 확인하실 수 있습니다.</p>
    </div>

    <table class="purchase_list_table">
        <thead>
            <tr>
                <th>주문번호</th>
                <th>주문날짜</th>
                <th>주문상품</th>
                <th>결제금액</th>
                <th>주문상태</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty purchaseList}">
                    <c:forEach var="row" items="${purchaseList}">
                        <tr>
                            <td>${row.orderCode}</td>
                            <td>${row.orderDate}</td>
                            <td class="product_name_cell">
                                <c:choose>
                                    <c:when test="${row.totalCount > 1}">
                                        ${row.productName} <strong>외 ${row.totalCount - 1}건</strong>
                                    </c:when>
                                    <c:otherwise>
                                        ${row.productName}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="list_price_bold">
                                <fmt:formatNumber value="${row.paidAmount}" type="number"/>원
                            </td>
                            <td class="status_complete">${row.orderStatus}</td>
                            <td>
                                <input type="button" class="btn_list_view" 
                                       onclick="location.href='${path}/purchase/purchaseListOne.do?orderCode=${row.orderCode}'" 
                                       value="조회">
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="6" class="list_no_data">주문 내역이 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="list_bottom_area">
        <input type="button" class="btn_list_home" onclick="location.href='<c:url value="/index.do"/>'" value="쇼핑 계속하기">
    </div>
</section>

<c:import url="/WEB-INF/view/include/bottom.jsp" />
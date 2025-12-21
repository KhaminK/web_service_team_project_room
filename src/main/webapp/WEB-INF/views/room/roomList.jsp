<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">
        <c:if test="${not empty param.keyword}">
            '<span class="text-primary">${param.keyword}</span>' 검색 결과
        </c:if>
        <c:if test="${empty param.keyword}">
            등록된 방
        </c:if>
    </h3>
    <a href="${pageContext.request.contextPath}/room/write" class="btn btn-primary rounded-pill px-4" style="padding: 12px 24px;">
        <i class="bi bi-plus-lg me-1"></i> 방 내놓기
    </a>
</div>

<div class="row mb-5">
    <div class="col-12">
        <div class="bg-white p-3 rounded-4 shadow-sm d-flex align-items-center flex-wrap gap-2" style="min-height: 70px;">

            <div class="d-flex align-items-center me-3">
                <i class="bi bi-filter-circle-fill text-primary fs-4 me-2"></i>
                <span class="fw-bold">필터</span>
            </div>

            <div class="d-flex align-items-center gap-2">
                <a href="${pageContext.request.contextPath}/room/list?type=all&sort=${currentSort}&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == 'all' ? 'btn-dark' : 'btn-light text-secondary'}">전체</a>

                <a href="${pageContext.request.contextPath}/room/list?type=원룸&sort=${currentSort}&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '원룸' ? 'btn-dark' : 'btn-light text-secondary'}">원룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=투룸&sort=${currentSort}&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '투룸' ? 'btn-dark' : 'btn-light text-secondary'}">투룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=미니투룸&sort=${currentSort}&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '미니투룸' ? 'btn-dark' : 'btn-light text-secondary'}">미니투룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=쉐어하우스&sort=${currentSort}&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '쉐어하우스' ? 'btn-dark' : 'btn-light text-secondary'}">쉐어하우스</a>
            </div>

            <div class="vr mx-2" style="height: 24px; opacity: 0.2;"></div>

            <div class="d-flex align-items-center gap-2">
                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=latest&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'latest' ? 'btn-primary' : 'btn-gray'}">최신순</a>

                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=price_asc&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'price_asc' ? 'btn-primary' : 'btn-gray'}">낮은 가격순</a>

                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=price_desc&keyword=${param.keyword}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'price_desc' ? 'btn-primary' : 'btn-gray'}">높은 가격순</a>
            </div>

            <form action="${pageContext.request.contextPath}/room/list" method="get" class="ms-auto position-relative" style="width: 280px;">
                <input type="hidden" name="type" value="${currentType}">
                <input type="hidden" name="sort" value="${currentSort}">

                <i class="bi bi-search position-absolute text-muted small" style="left: 15px; top: 50%; transform: translateY(-50%);"></i>
                <input type="text" name="keyword"
                       class="form-control form-control-sm border-0 bg-light rounded-pill"
                       placeholder="건물명, 지역 검색"
                       value="${param.keyword}"
                       style="padding-left: 40px; height: 38px;">
            </form>

        </div>
    </div>
</div>

<div class="row g-4">
    <c:forEach var="room" items="${roomList}">
        <div class="col-md-4 col-sm-6">
            <a href="${pageContext.request.contextPath}/room/detail?id=${room.roomNo}" class="text-decoration-none text-dark">
                <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden action-card" style="transition: transform 0.2s;">
                    <div style="height: 200px; background-color: #f8f9fa; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                        <c:choose>
                            <c:when test="${not empty room.filename1}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${room.filename1}" class="w-100 h-100" style="object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-house-door text-secondary opacity-25" style="font-size: 4rem;"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-2 py-1">${room.roomType}</span>
                            <span class="text-muted small"><fmt:formatDate value="${room.createdAt}" pattern="MM/dd" /></span>
                        </div>
                        <h5 class="fw-bold mb-1 text-truncate">${room.title}</h5>
                        <h5 class="fw-bold text-primary mt-2">
                            월 <fmt:formatNumber value="${room.price / 10000}" pattern="#,###" />만원
                            <span class="text-dark fs-6 fw-normal">
                                / 보증금 <fmt:formatNumber value="${room.deposit / 10000}" pattern="#,###" />만원
                            </span>
                        </h5>
                        <p class="text-muted small mb-0 mt-3 text-truncate">
                            <i class="bi bi-geo-alt-fill text-danger"></i> ${room.address}
                        </p>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>

    <c:if test="${empty roomList}">
        <div class="col-12 text-center py-5">
            <div class="p-5 bg-light rounded-4">
                <i class="bi bi-search fs-1 text-muted mb-3"></i>
                <p class="text-muted fs-5 fw-bold">검색 결과가 없어요.</p>
                <a href="${pageContext.request.contextPath}/room/list" class="btn btn-outline-secondary rounded-pill mt-2">전체 목록 보기</a>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../include/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">등록된 방</h3>
    <a href="${pageContext.request.contextPath}/room/write" class="btn btn-primary rounded-pill px-4" style="padding: 12px 24px;"><i class="bi bi-plus-lg me-1"></i> 방 내놓기</a>
</div>

<div class="row mb-5">
    <div class="col-12">
        <div class="bg-white p-3 rounded-4 shadow-sm d-flex align-items-center" style="overflow-x: auto; white-space: nowrap;">
            <i class="bi bi-filter-circle-fill text-primary fs-4 ms-2 me-3"></i>
            <span class="fw-bold me-3">필터</span>

            <div class="d-flex align-items-center gap-2">
                <a href="${pageContext.request.contextPath}/room/list?type=all&sort=${currentSort}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == 'all' ? 'btn-dark' : 'btn-light text-secondary'}">전체</a>

                <a href="${pageContext.request.contextPath}/room/list?type=원룸&sort=${currentSort}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '원룸' ? 'btn-dark' : 'btn-light text-secondary'}">원룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=투룸&sort=${currentSort}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '투룸' ? 'btn-dark' : 'btn-light text-secondary'}">투룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=미니투룸&sort=${currentSort}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '미니투룸' ? 'btn-dark' : 'btn-light text-secondary'}">미니투룸</a>

                <a href="${pageContext.request.contextPath}/room/list?type=쉐어하우스&sort=${currentSort}"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentType == '쉐어하우스' ? 'btn-dark' : 'btn-light text-secondary'}">쉐어하우스</a>

                <div class="vr mx-2" style="height: 38px; opacity: 0.2;"></div>

                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=latest"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'latest' ? 'btn-primary' : 'btn-gray'}">최신순</a>

                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=price_asc"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'price_asc' ? 'btn-primary' : 'btn-gray'}">낮은 가격순</a>

                <a href="${pageContext.request.contextPath}/room/list?type=${currentType}&sort=price_desc"
                   class="btn btn-sm rounded-pill px-3 fw-bold ${currentSort == 'price_desc' ? 'btn-primary' : 'btn-gray'}">높은 가격순</a>
            </div>
        </div>
    </div>
</div>

<div class="row g-4">
    <c:forEach var="room" items="${roomList}">
        <div class="col-md-4 col-sm-6">
            <a href="${pageContext.request.contextPath}/room/detail?id=${room.roomNo}" class="text-decoration-none text-dark">
                <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden" style="transition: transform 0.2s;">

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
                            <span class="text-muted small"><fmt:formatDate value="${room.createdAt}" pattern="MM/dd hh:mm" /></span>
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
                <i class="bi bi-emoji-dizzy fs-1 text-muted mb-3"></i>
                <p class="text-muted fs-5 fw-bold">조건에 맞는 방이 없어요.</p>
                <a href="${pageContext.request.contextPath}/room/list" class="btn btn-outline-secondary rounded-pill mt-2">전체 목록 보기</a>
            </div>
        </div>
    </c:if>
</div>

<script>
    // 카드 호버 효과
    document.querySelectorAll('.card').forEach(card => {
        card.addEventListener('mouseover', () => card.style.transform = 'translateY(-5px)');
        card.addEventListener('mouseout', () => card.style.transform = 'translateY(0)');
    });
</script>

<%@ include file="../include/footer.jsp" %>
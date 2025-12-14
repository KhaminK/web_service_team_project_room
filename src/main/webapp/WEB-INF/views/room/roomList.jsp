<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold">등록된 자취방</h3>
    <a href="/room/write" class="btn btn-primary rounded-pill px-4"><i class="bi bi-plus-lg me-1"></i> 방 내놓기</a>
</div>

<div class="row mb-5">
    <div class="col-12">
        <div class="bg-white p-3 rounded-4 shadow-sm d-flex gap-2 align-items-center">
            <i class="bi bi-filter-circle-fill text-primary fs-4 ms-2"></i>
            <span class="fw-bold me-3">필터</span>
            <button class="btn btn-light rounded-pill btn-sm fw-bold text-secondary">최신순</button>
            <button class="btn btn-light rounded-pill btn-sm fw-bold text-secondary">가격순</button>
        </div>
    </div>
</div>

<div class="row g-4">
    <c:forEach var="room" items="${roomList}">
        <div class="col-md-4 col-sm-6">
            <a href="/room/detail?id=${room.roomNo}" class="text-decoration-none text-dark">
                <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden" style="transition: transform 0.2s;">
                    <div style="height: 200px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center; color: #adb5bd;">
                        <i class="bi bi-house-door fs-1"></i>
                    </div>

                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-2 py-1">${room.roomType}</span>
                            <span class="text-muted small"><i class="bi bi-clock"></i> 1일전</span>
                        </div>
                        <h5 class="fw-bold mb-1 text-truncate">${room.title}</h5>
                        <h5 class="fw-bold text-primary mt-2">
                            월 ${room.price} <span class="text-dark fs-6 fw-normal">/ 보증금 0</span>
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
            <p class="text-muted fs-4">아직 등록된 매물이 없습니다 😢</p>
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
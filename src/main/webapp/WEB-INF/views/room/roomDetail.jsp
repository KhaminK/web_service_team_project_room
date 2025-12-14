<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="row">
    <div class="col-lg-7 mb-4">
        <div class="bg-light rounded-4 d-flex align-items-center justify-content-center overflow-hidden shadow-sm" style="height: 450px;">
            <i class="bi bi-image text-secondary" style="font-size: 5rem; opacity: 0.3;"></i>
        </div>
    </div>

    <div class="col-lg-5">
        <div class="custom-card h-100 p-4 pt-5">
            <div class="mb-3">
                <span class="badge bg-primary rounded-pill px-3 py-2">${room.roomType}</span>
                <span class="badge bg-success rounded-pill px-3 py-2 ms-1">거래가능</span>
            </div>

            <h2 class="fw-bold mb-3" style="word-break: keep-all;">${room.title}</h2>

            <h3 class="text-primary fw-bold mb-4">월 ${room.price}원</h3>

            <hr style="opacity:0.1">

            <div class="vstack gap-3 my-4">
                <div class="d-flex">
                    <i class="bi bi-geo-alt-fill text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">주소</span>
                        <span class="text-muted small">${room.address} ${room.addressDetail}</span>
                    </div>
                </div>
                <div class="d-flex">
                    <i class="bi bi-bus-front-fill text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">버정 거리</span>
                        <span class="text-muted small">${room.busDistance}</span>
                    </div>
                </div>
                <div class="d-flex">
                    <i class="bi bi-person-circle text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">작성자</span>
                        <span class="text-muted small">${room.writerName} (인증됨)</span>
                    </div>
                </div>
            </div>

            <div class="mt-auto d-grid gap-2">
                <button class="btn btn-primary btn-lg">연락하기 (010-****-****)</button>

                <c:if test="${sessionScope.loginUser.userNo == room.writerId}">
                    <div class="row g-2 mt-2">
                        <div class="col-6">
                            <a href="/room/edit?id=${room.roomNo}" class="btn btn-light border w-100 fw-bold">수정</a>
                        </div>
                        <div class="col-6">
                            <a href="/room/delete?id=${room.roomNo}" onclick="return confirm('정말 삭제하시겠습니까?')" class="btn btn-light border w-100 fw-bold text-danger">삭제</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-12">
        <div class="custom-card">
            <h4 class="fw-bold mb-4">상세 설명</h4>
            <p class="text-muted" style="line-height: 1.8; white-space: pre-wrap;">${room.content}</p>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>
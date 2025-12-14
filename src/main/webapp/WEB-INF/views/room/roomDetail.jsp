<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="row">
    <div class="col-lg-7 mb-4">
        <div class="bg-light rounded-4 overflow-hidden shadow-sm position-relative" style="height: 450px;">
            <c:choose>
                <c:when test="${not empty room.filename1 or not empty room.filename2 or not empty room.filename3}">
                    <div id="roomCarousel" class="carousel slide h-100" data-bs-ride="carousel">
                        <div class="carousel-inner h-100">
                            <c:if test="${not empty room.filename1}">
                                <div class="carousel-item active h-100">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename1}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                            <c:if test="${not empty room.filename2}">
                                <div class="carousel-item h-100 ${empty room.filename1 ? 'active' : ''}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename2}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                            <c:if test="${not empty room.filename3}">
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename3}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#roomCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#roomCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <i class="bi bi-image text-secondary" style="font-size: 5rem; opacity: 0.3;"></i>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="col-lg-5">
        <div class="custom-card h-100 p-4 pt-5">
            <div class="mb-3 d-flex align-items-center gap-2">
                <span class="badge bg-primary rounded-pill px-3 py-2">${room.roomType}</span>
                <span class="badge bg-success rounded-pill px-3 py-2">거래가능</span>

                <span class="ms-auto text-muted small"><i class="bi bi-eye-fill"></i> ${room.viewCount}</span>
            </div>

            <h2 class="fw-bold mb-3" style="word-break: keep-all;">${room.title}</h2>

            <div class="d-flex flex-wrap align-items-center mb-4 gap-2">
                <h3 class="text-primary fw-bold mb-0">
                    보증금 <fmt:formatNumber value="${room.deposit / 10000}" pattern="#,###" />
                    / 월 <fmt:formatNumber value="${room.price / 10000}" pattern="#,###" />
                </h3>
                <span class="text-dark fw-bold fs-4">만원</span>

                <button type="button" class="btn btn-link text-muted p-0 ms-1"
                        data-bs-toggle="popover" data-bs-trigger="focus" data-bs-title="가격 정보"
                        data-bs-content="월세엔 관리비가 포함되어 있습니다. 공과금은 별도입니다.">
                    <i class="bi bi-info-circle-fill fs-5" style="color: #adb5bd;"></i>
                </button>
            </div>

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
                        <span class="d-block fw-bold text-dark">버스 정류장</span>
                        <span class="text-muted small">${room.busDistance}</span>
                    </div>
                </div>

                <div class="d-flex">
                    <i class="bi bi-person-circle text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">작성자</span>
                        <span class="text-muted small d-flex align-items-center">
                            <c:choose>
                                <c:when test="${room.writerGender == 'M'}">
                                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary ms-2" style="font-size: 0.75rem;">남성</span>
                                </c:when>
                                <c:when test="${room.writerGender == 'F'}">
                                    <span class="badge bg-danger bg-opacity-10 text-danger border border-danger ms-2" style="font-size: 0.75rem;">여성</span>
                                </c:when>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>

            <div class="mt-auto d-grid gap-2">
                <button class="btn btn-primary btn-lg">연락하기</button>
                <c:if test="${sessionScope.loginUser.userNo == room.writerId}">
                    <div class="row g-2 mt-2">
                        <div class="col-6">
                            <a href="${pageContext.request.contextPath}/room/edit?id=${room.roomNo}" class="btn btn-light border w-100 fw-bold">수정</a>
                        </div>
                        <div class="col-6">
                            <a href="${pageContext.request.contextPath}/room/delete?id=${room.roomNo}" onclick="return confirm('정말 삭제하시겠습니까?')" class="btn btn-light border w-100 fw-bold text-danger">삭제</a>
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

<script>
    document.addEventListener("DOMContentLoaded", function(){
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl)
        })
    });
</script>

<%@ include file="../include/footer.jsp" %>
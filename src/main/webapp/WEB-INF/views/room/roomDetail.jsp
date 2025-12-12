<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="row">
    <div class="col-lg-7 mb-4">
        <div class="bg-light rounded-4 overflow-hidden shadow-sm position-relative" style="height: 450px;">
            <c:choose>
                <%-- 이미지가 하나라도 있으면 슬라이드 시작 --%>
                <c:when test="${not empty room.filename1 or not empty room.filename2 or not empty room.filename3}">
                    <div id="roomCarousel" class="carousel slide h-100" data-bs-ride="carousel">
                        <div class="carousel-inner h-100">

                                <%-- 첫 번째 사진 --%>
                            <c:if test="${not empty room.filename1}">
                                <div class="carousel-item active h-100">
                                    <img src="/resources/upload/${room.filename1}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>

                                <%-- 두 번째 사진 (첫번째가 없으면 이게 active가 되어야 하는 예외처리는 복잡해서, 보통 1번은 필수라고 가정하거나 JS로 처리하지만 여기선 c:if로 단순화) --%>
                            <c:if test="${not empty room.filename2}">
                                <div class="carousel-item h-100 ${empty room.filename1 ? 'active' : ''}">
                                    <img src="/resources/upload/${room.filename2}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>

                                <%-- 세 번째 사진 --%>
                            <c:if test="${not empty room.filename3}">
                                <div class="carousel-item h-100">
                                    <img src="/resources/upload/${room.filename3}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                        </div>

                            <%-- 좌우 컨트롤 버튼 (사진이 2장 이상일 때만 표시) --%>
                        <button class="carousel-control-prev" type="button" data-bs-target="#roomCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#roomCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </button>
                    </div>
                </c:when>

                <%-- 이미지가 아예 없으면 기본 아이콘 --%>
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
            <div class="mb-3">
                <span class="badge bg-primary rounded-pill px-3 py-2">${room.roomType}</span>
                <span class="badge bg-success rounded-pill px-3 py-2 ms-1">거래가능</span>
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
                    <i class="bi bi-person-circle text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">작성자</span>
                        <span class="text-muted small">${room.writerName} (인증됨)</span>
                    </div>
                </div>
            </div>

            <div class="mt-auto d-grid gap-2">
                <button class="btn btn-primary btn-lg">연락하기</button>
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

<script>
    document.addEventListener("DOMContentLoaded", function(){
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl)
        })
    });
</script>

<%@ include file="../include/footer.jsp" %>
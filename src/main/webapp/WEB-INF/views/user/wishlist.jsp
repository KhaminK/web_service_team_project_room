<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/header.jsp" />

<style>
    /* Toss Style Colors (기존 프로필 스타일 유지) */
    :root {
        --primary-color: #3182F6;
        --secondary-color: #E8F3FF;
        --text-gray: #8B95A1;
        --border-color: #F2F4F6;
    }

    .profile-container {
        display: flex;
        /* [수정] 1200px -> 1000px (프로필 페이지와 동일하게 맞춤) */
        max-width: 1000px;
        margin: 40px auto;
        padding: 0 20px;
        gap: 40px;
    }

    /* [추가] 카드 이미지가 1000px에서도 예쁘게 보이도록 높이 조정 */
    .room-img-box {
        height: 160px; /* 기존 180px에서 살짝 줄임 */
        background-color: #f8f9fa;
        position: relative;
    }

    /* 사이드바 스타일 (동일) */
    .sidebar { flex: 0 0 220px; }
    .sidebar-title { font-size: 24px; font-weight: 800; margin-bottom: 20px; }
    .sidebar-menu { list-style: none; padding: 0; }
    .sidebar-item {
        display: block; padding: 12px 16px; margin-bottom: 4px;
        border-radius: 12px; font-size: 16px; font-weight: 500;
        color: #4E5968; text-decoration: none; transition: 0.2s;
    }
    .sidebar-item:hover { background-color: var(--secondary-color); color: var(--primary-color); }

    /* Active 상태 스타일 */
    .sidebar-item.active { background-color: var(--secondary-color); color: var(--primary-color); font-weight: 700; }

    .sidebar-item.logout { color: #F04452; }
    .sidebar-item.logout:hover { background-color: #FEF2F2; color: #F04452; }

    /* 콘텐츠 영역 스타일 */
    .content-area { flex: 1; }
    .content-header { margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
    .content-header h2 { font-size: 22px; font-weight: 700; margin: 0; }

    /* 카드 스타일 (roomList.jsp에서 가져옴) */
    .custom-card-link { text-decoration: none; color: inherit; }
    .room-card {
        height: 100%;
        border: none;
        border-radius: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        overflow: hidden;
        transition: transform 0.2s;
        background: white;
    }
    .room-card:hover { transform: translateY(-5px); }

    .room-img-box {
        height: 180px;
        background-color: #f8f9fa;
        position: relative;
    }
    .room-img { width: 100%; height: 100%; object-fit: cover; }

    .card-body { padding: 20px; }
    .badge-custom { background-color: rgba(49, 130, 246, 0.1); color: var(--primary-color); font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 6px; }
</style>

<div class="profile-container">
    <aside class="sidebar">
        <div class="sidebar-title">프로필</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/user/profile" class="sidebar-item">내 정보</a></li>
            <li><a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-item active">찜한 목록</a></li>
            <li><a href="${pageContext.request.contextPath}/user/myrooms" class="sidebar-item">작성한 글</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout" class="sidebar-item logout">로그아웃</a></li>
        </ul>
    </aside>

    <main class="content-area">
        <div class="content-header">
            <h2>내가 찜한 방 (${fn:length(wishList)})</h2>
        </div>

        <div class="row g-3"> <c:forEach var="room" items="${wishList}">

            <div class="col-lg-6">
                <a href="${pageContext.request.contextPath}/room/detail?id=${room.roomNo}" class="custom-card-link">
                    <div class="room-card">
                        <div class="room-img-box">
                            <c:choose>
                                <c:when test="${not empty room.filename1}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename1}" class="room-img" alt="방 이미지">
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex align-items-center justify-content-center h-100">
                                        <i class="bi bi-house-door text-secondary opacity-25" style="font-size: 3rem;"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="badge-custom">${room.roomType}</span>
                                <span class="text-muted small">
                                    <fmt:formatDate value="${room.createdAt}" pattern="MM.dd" />
                                </span>
                            </div>

                            <h5 class="fw-bold mb-1 text-truncate" style="font-size: 16px;">${room.title}</h5>

                            <div class="mt-2">
                                <span class="fw-bold text-primary">월 <fmt:formatNumber value="${room.price / 10000}" pattern="#,###"/>만</span>
                                <span class="text-secondary small">/ <fmt:formatNumber value="${room.deposit / 10000}" pattern="#,###"/>만</span>
                            </div>

                            <p class="text-muted small mb-0 mt-2 text-truncate">
                                <i class="bi bi-geo-alt-fill text-danger"></i> ${room.address}
                            </p>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>

            <c:if test="${empty wishList}">
                <div class="col-12 py-5 text-center">
                    <div class="p-5 bg-light rounded-4" style="border: 1px dashed #ced4da;">
                        <i class="bi bi-heart-break fs-1 text-muted mb-3" style="display:block;"></i>
                        <span class="text-muted fw-bold">아직 찜한 방이 없어요.</span><br>
                        <a href="${pageContext.request.contextPath}/room/list" class="btn btn-sm btn-primary mt-3 rounded-pill px-3">방 구경하러 가기</a>
                    </div>
                </div>
            </c:if>
        </div>
    </main>
</div>

<jsp:include page="../include/footer.jsp" />
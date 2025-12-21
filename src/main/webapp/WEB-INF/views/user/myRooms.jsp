<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/header.jsp" />

<style>
    /* [공통 스타일] profile.jsp와 동일 (네비게이션 고정용) */
    :root {
        --primary-color: #3182F6;
        --secondary-color: #E8F3FF;
        --text-gray: #8B95A1;
        --border-color: #F2F4F6;
    }

    .profile-container {
        display: flex;
        max-width: 1000px;
        margin: 40px auto;
        padding: 0 20px;
        gap: 40px;
    }

    /* 사이드바 */
    .sidebar { flex: 0 0 220px; }
    .sidebar-title { font-size: 24px; font-weight: 800; margin-bottom: 20px; }
    .sidebar-menu { list-style: none; padding: 0; }
    .sidebar-item {
        display: block; padding: 12px 16px; margin-bottom: 4px;
        border-radius: 12px; font-size: 16px; font-weight: 500;
        color: #4E5968; text-decoration: none; transition: 0.2s;
    }
    .sidebar-item:hover { background-color: var(--secondary-color); color: var(--primary-color); }
    .sidebar-item.active { background-color: var(--secondary-color); color: var(--primary-color); font-weight: 700; }
    .sidebar-item.logout { color: #F04452; }
    .sidebar-item.logout:hover { background-color: #FEF2F2; color: #F04452; }

    /* 콘텐츠 영역 */
    .content-area { flex: 1; }
    .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .content-header h2 { font-size: 22px; font-weight: 700; margin: 0; }

    /* [카드 스타일 수정됨] */
    .room-card {
        display: flex;
        border: 1px solid var(--border-color);
        border-radius: 20px;
        background-color: white;
        margin-bottom: 20px;
        overflow: hidden;
        transition: transform 0.2s, box-shadow 0.2s;
        height: 180px; /* 높이 고정 (선택사항, 깔끔함을 위해 추천) */
    }
    .room-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.06);
    }

    /* 카드 왼쪽 이미지 */
    .room-img-box {
        width: 180px;
        height: 100%; /* 카드 높이 꽉 채움 */
        position: relative;
        background-color: #f9f9f9;
        flex-shrink: 0; /* 이미지 영역 줄어들지 않게 */
    }
    .room-img-box img {
        width: 100%; height: 100%; object-fit: cover; position: absolute;
    }
    .room-img-placeholder {
        width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;
        color: #ddd; font-size: 40px;
    }

    /* 카드 중간 정보 영역 (레이아웃 재배치) */
    .room-info {
        flex: 1;
        padding: 20px 24px;
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* 상-하 분산 배치 */
        min-width: 0; /* flex 자식 text-truncate 작동 필수 */
    }

    /* 상단 메타 정보 (타입, 날짜, 조회수) */
    .room-info-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 8px;
    }
    .room-type {
        font-size: 12px; color: var(--primary-color);
        background-color: var(--secondary-color); padding: 4px 8px; border-radius: 6px; font-weight: 700;
    }
    .room-meta-right {
        font-size: 13px; color: var(--text-gray); font-weight: 500;
        display: flex; align-items: center; gap: 12px;
    }
    .view-count-box {
        display: flex; align-items: center; gap: 4px;
    }

    /* 타이틀 및 가격 */
    .room-main-content {
        flex: 1; /* 남은 공간 차지 */
        display: flex; flex-direction: column; justify-content: center;
    }
    .room-title {
        font-size: 18px; font-weight: 700; color: #333; margin-bottom: 6px;
        white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block;
        text-decoration: none;
    }
    .room-price { font-size: 18px; font-weight: 800; color: #333; }
    .room-price span { font-size: 14px; font-weight: 500; color: #4e5968; margin-left: 2px; }

    /* 하단 주소 (일자 배치) */
    .room-address-line {
        font-size: 14px; color: var(--text-gray);
        display: flex; align-items: center; gap: 6px;
        white-space: nowrap; overflow: hidden; text-overflow: ellipsis; /* 한 줄 말줄임 */
        margin-top: 8px;
        padding-top: 12px;
        border-top: 1px solid #f2f4f6; /* 구분선 추가로 깔끔하게 */
    }

    /* 오른쪽 버튼 그룹 */
    .room-actions {
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 8px;
        padding-right: 20px;
        border-left: 1px solid #f2f4f6;
        padding-left: 20px;
        min-width: 130px;
    }
    .action-btn {
        display: flex; align-items: center; justify-content: center;
        width: 100%; padding: 10px 0; border-radius: 12px;
        font-size: 14px; font-weight: 700; text-decoration: none; transition: 0.2s; border: none; cursor: pointer;
    }
    .btn-blue { background-color: var(--secondary-color); color: var(--primary-color); }
    .btn-blue:hover { background-color: #dbeaff; }
    .btn-red { background-color: #FEF2F2; color: #F04452; }
    .btn-red:hover { background-color: #fee2e2; }

    /* Empty State */
    .empty-state { text-align: center; padding: 80px 0; border: 1px dashed var(--border-color); border-radius: 24px; }
    .empty-icon { font-size: 48px; color: #ddd; margin-bottom: 16px; }
    .empty-text { font-size: 18px; font-weight: 700; color: #4e5968; margin-bottom: 8px; }
    .btn-write-main {
        background-color: var(--primary-color); color: white; padding: 12px 24px; border-radius: 12px;
        text-decoration: none; font-weight: 700; display: inline-block; margin-top: 16px; transition: 0.2s;
    }
    .btn-write-main:hover { background-color: #1b64da; color: white; }
    .btn-write-small {
        background-color: var(--primary-color); color: white; padding: 8px 16px; border-radius: 8px;
        text-decoration: none; font-size: 14px; font-weight: 700;
    }
</style>

<div class="profile-container">
    <aside class="sidebar">
        <div class="sidebar-title">프로필</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/user/profile" class="sidebar-item">내 정보</a></li>
            <li><a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-item">찜한 목록</a></li>
            <li><a href="#" class="sidebar-item active">작성한 글</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout" class="sidebar-item logout">로그아웃</a></li>
        </ul>
    </aside>

    <main class="content-area">
        <div class="content-header">
            <h2>내가 쓴 방 관리</h2>
            <c:if test="${not empty myRoomList}">
                <a href="${pageContext.request.contextPath}/room/write" class="btn-write-small">
                    + 방 내놓기
                </a>
            </c:if>
        </div>

        <c:if test="${empty myRoomList}">
            <div class="empty-state">
                <i class="bi bi-house-dash empty-icon"></i>
                <div class="empty-text">아직 올린 방이 없어요</div>
                <div style="color: var(--text-gray); font-size: 14px;">새로운 자취방을 등록해보세요!</div>
                <a href="${pageContext.request.contextPath}/room/write" class="btn-write-main">
                    첫 게시글 작성하기
                </a>
            </div>
        </c:if>

        <c:if test="${not empty myRoomList}">
            <c:forEach var="room" items="${myRoomList}">
                <div class="room-card">
                    <div class="room-img-box">
                        <c:choose>
                            <c:when test="${not empty room.filename1}">
                                <img src="${pageContext.request.contextPath}/resources/upload/${room.filename1}" alt="방 이미지">
                            </c:when>
                            <c:otherwise>
                                <div class="room-img-placeholder"><i class="bi bi-image"></i></div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="room-info">
                        <div class="room-info-top">
                            <span class="room-type">${room.roomType}</span>
                            <div class="room-meta-right">
                                <span><fmt:formatDate value="${room.createdAt}" pattern="yyyy.MM.dd"/></span>
                                <div class="view-count-box">
                                    <i class="bi bi-eye-fill"></i>
                                    <span>${room.viewCount}</span>
                                </div>
                            </div>
                        </div>

                        <div class="room-main-content">
                            <a href="${pageContext.request.contextPath}/room/detail?id=${room.roomNo}" class="room-title">
                                    ${room.title}
                            </a>
                            <div class="room-price">
                                보증금 <fmt:formatNumber value="${room.deposit/10000}" pattern="#,###"/>
                                / 월 <fmt:formatNumber value="${room.price/10000}" pattern="#,###"/>
                                <span>만원</span>
                            </div>
                        </div>

                        <div class="room-address-line">
                            <i class="bi bi-geo-alt-fill"></i>
                                ${room.address} ${room.addressDetail}
                        </div>
                    </div>

                    <div class="room-actions">
                        <button type="button"
                                onclick="location.href='${pageContext.request.contextPath}/room/edit?id=${room.roomNo}'"
                                class="action-btn btn-blue">
                            <i class="bi bi-pencil-square" style="margin-right: 6px;"></i> 수정
                        </button>
                        <button type="button"
                                onclick="confirmDelete('${room.roomNo}')"
                                class="action-btn btn-red">
                            <i class="bi bi-trash" style="margin-right: 6px;"></i> 삭제
                        </button>
                    </div>
                </div>
            </c:forEach>
        </c:if>

    </main>
</div>

<script>
    function confirmDelete(roomNo) {
        if(confirm("정말로 이 게시글을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
            location.href = '${pageContext.request.contextPath}/room/delete?id=' + roomNo;
        }
    }
</script>

<jsp:include page="../include/footer.jsp" />
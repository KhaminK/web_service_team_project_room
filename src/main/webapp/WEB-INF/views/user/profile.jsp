<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../include/header.jsp" />

<style>
    /* Toss Style Colors */
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

    /* 사이드바 스타일 */
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

    /* 콘텐츠 영역 스타일 */
    .content-area { flex: 1; }
    .content-header h2 { font-size: 22px; font-weight: 700; margin-bottom: 20px; }

    /* 프로필 카드 스타일 */
    .profile-card {
        border: 1px solid var(--border-color);
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        background-color: white;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    /* 프로필 이미지 박스 */
    .profile-avatar-box {
        width: 100px; height: 100px; border-radius: 50%; overflow: hidden;
        margin-bottom: 16px; border: 1px solid rgba(0,0,0,0.08);
        display: flex; align-items: center; justify-content: center; background-color: #fff;
    }
    .profile-avatar-box img { width: 100%; height: 100%; object-fit: cover; }
    .profile-avatar-text {
        width: 100%; height: 100%; background-color: var(--secondary-color);
        color: var(--primary-color); display: flex; align-items: center;
        justify-content: center; font-size: 40px; font-weight: 700;
    }

    .profile-name { font-size: 20px; font-weight: 700; margin-bottom: 4px; }
    .profile-meta { color: var(--text-gray); font-size: 14px; margin-bottom: 30px; }

    /* 정보 리스트 스타일 */
    .info-list { width: 100%; text-align: left; border-top: 1px solid var(--border-color); padding-top: 20px; }
    .info-item { display: flex; justify-content: space-between; padding: 14px 0; border-bottom: 1px solid var(--border-color); font-size: 15px; }
    .info-label { font-weight: 600; color: #333; }
    .info-value { color: #6B7684; }

    /* [수정됨] 링크 버튼 스타일 (a태그용) */
    .btn-edit {
        display: block; /* 꽉 차게 */
        width: 100%;
        text-align: center;
        text-decoration: none; /* 밑줄 제거 */
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 16px 20px;
        border-radius: 16px;
        font-weight: 700;
        font-size: 16px;
        margin-top: 30px;
        transition: 0.2s;
    }
    .btn-edit:hover { background-color: #1b64da; color: white; }
</style>

<div class="profile-container">
    <aside class="sidebar">
        <div class="sidebar-title">프로필</div>
        <ul class="sidebar-menu">
            <li><a href="#" class="sidebar-item active">내 정보</a></li>
            <li><a href="#" class="sidebar-item">찜한 목록</a></li>
            <li><a href="#" class="sidebar-item">작성한 글</a></li>
            <li><a href="/user/logout" class="sidebar-item logout">로그아웃</a></li>
        </ul>
    </aside>

    <main class="content-area">
        <div class="content-header">
            <h2>내 정보 관리</h2>
        </div>

        <div class="profile-card">
            <div class="profile-avatar-box">
                <c:choose>
                    <c:when test="${not empty loginUser.profileImg}">
                        <img src="${pageContext.request.contextPath}/resources/upload/${loginUser.profileImg}" alt="프로필 사진">
                    </c:when>
                    <c:otherwise>
                        <div class="profile-avatar-text">
                                ${fn:substring(loginUser.name, 0, 1)}
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-name">${loginUser.name}</div>
            <div class="profile-meta">
                ${loginUser.studentId} ·
                <c:choose>
                    <c:when test="${loginUser.auth}">인증됨</c:when>
                    <c:otherwise>미인증</c:otherwise>
                </c:choose>
            </div>

            <div class="info-list">
                <div class="info-item">
                    <span class="info-label">학번</span>
                    <span class="info-value">${loginUser.studentId}</span>
                </div>

                <div class="info-item">
                    <span class="info-label">전화번호</span>
                    <span class="info-value">
                        <c:out value="${loginUser.phone}" default="미등록" />
                    </span>
                </div>

                <div class="info-item">
                    <span class="info-label">성별</span>
                    <span class="info-value">${loginUser.gender}</span>
                </div>

                <div class="info-item">
                    <span class="info-label">나이</span>
                    <span class="info-value">${loginUser.age}세</span>
                </div>

                <div class="info-item">
                    <span class="info-label">사용 언어</span>
                    <span class="info-value">
                        <c:out value="${loginUser.language}" default="미지정" />
                    </span>
                </div>

                <div class="info-item">
                    <span class="info-label">가입일</span>
                    <span class="info-value">
                        <fmt:formatDate value="${loginUser.createdAt}" pattern="yyyy년 MM월 dd일" />
                    </span>
                </div>

                <div class="info-item">
                    <span class="info-label">계정 상태</span>
                    <span class="info-value">
                         <c:choose>
                             <c:when test="${loginUser.auth}">
                                 <span style="color:var(--primary-color); font-weight:bold;">한동인 인증 완료</span>
                             </c:when>
                             <c:otherwise>
                                 <span style="color:#F04452;">미인증</span>
                             </c:otherwise>
                         </c:choose>
                    </span>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/user/edit" class="btn-edit">
                정보 수정하기
            </a>

        </div>
    </main>
</div>

<jsp:include page="../include/footer.jsp" />
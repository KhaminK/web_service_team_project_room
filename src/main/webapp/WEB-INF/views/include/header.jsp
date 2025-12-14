<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>한방 - 한동인을 위한 자취방</title>

    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        /* [Design System] 전역 변수 설정 */
        :root {
            --bg-color: #F9FAFB;
            --text-main: #191F28;
            --text-sub: #8B95A1;
            --primary: #3182F6;
            --primary-hover: #1b64da;
            --input-bg: #F2F4F6;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            --radius-lg: 24px;
            --radius-md: 14px;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            padding-top: 80px;
            word-break: keep-all;
            overflow-y: scroll;
        }

        /* 네비게이션 바 */
        .navbar {
            background-color: rgba(255, 255, 255, 0.9) !important;
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(0,0,0,0.05);
            height: 70px;
            padding: 0;
        }

        .navbar .container {
            height: 100%;
            display: flex;
            align-items: center;
        }

        /* 로고 스타일 */
        .navbar-brand {
            font-weight: 800;
            color: var(--text-main) !important;
            font-size: 26px !important;
            letter-spacing: -0.5px;
            margin-right: 30px;
            padding: 0;
            line-height: 1;
        }

        .nav-link {
            font-weight: 600;
            color: var(--text-sub) !important;
            font-size: 16px;
            transition: color 0.2s;
        }
        .nav-link:hover { color: var(--primary) !important; }

        /* 공통 요소 스타일 */
        .custom-card {
            background: white;
            border-radius: var(--radius-lg);
            border: none;
            box-shadow: var(--card-shadow);
            padding: 40px;
        }

        .form-control, .form-select {
            background-color: var(--input-bg);
            border: 2px solid transparent;
            border-radius: var(--radius-md);
            padding: 16px;
            font-size: 1rem;
            color: var(--text-main);
        }
        .form-control:focus, .form-select:focus {
            background-color: #fff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(49, 130, 246, 0.1);
        }
        .form-label { font-weight: 700; margin-bottom: 8px; color: #4E5968; font-size: 0.95rem; }

        /* 버튼 스타일 */
        .btn-primary {
            background-color: var(--primary);
            border: none;
            border-radius: var(--radius-md);
            padding: 12px 20px;
            font-weight: 700;
        }
        .btn-primary:hover { background-color: var(--primary-hover); }

        /* 로그아웃 버튼 스타일 */
        .btn-logout {
            background-color: var(--input-bg) !important;
            color: #4E5968 !important;
            border: none;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .btn-logout:hover {
            background-color: #e1e4e8 !important;
            color: var(--text-main) !important;
        }
        .btn-secondary:hover { background-color: #dbeaff; color: var(--primary-hover); }

        /* 프로필 링크 스타일 */
        .profile-link {
            text-decoration: none;
            color: var(--text-main);
            transition: all 0.2s;
            display: inline-flex;  /* flex 대신 inline-flex로 변경하여 영역 잡기 */
            align-items: center;
            cursor: pointer !important; /* 강제로 손가락 모양 나오게 함 */
            padding: 5px 10px;    /* 클릭 영역 넓히기 */
            border-radius: 30px;  /* 둥글게 */
        }

        /* 마우스 올렸을 때 확실하게 티나도록 배경색 추가 */
        .profile-link:hover {
            background-color: rgba(0,0,0,0.05);
            color: var(--primary); /* 글자색 파랗게 변함 */
        }

        /* 프로필 아바타 이미지 */
        .profile-avatar {
            width: 32px;
            height: 32px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #ddd; /* 테두리 살짝 추가 */
            margin-right: 8px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">HanBang</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${sessionScope.loginUser.role != 'ADMIN'}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/room/list">방 구하기</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/room/write">방 내놓기</a></li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <c:if test="${empty sessionScope.loginUser}">
                    <a href="${pageContext.request.contextPath}/user/login" class="text-decoration-none text-muted fw-bold me-3" style="font-size: 15px;">로그인</a>
                    <a href="${pageContext.request.contextPath}/user/signup" class="btn btn-primary btn-sm px-4 rounded-pill">회원가입</a>
                </c:if>

                <c:if test="${not empty sessionScope.loginUser}">
<%-- [통합된 코드] 프로필 UI + 관리자 버튼 + 경로 자동 보정 --%>

<a href="${pageContext.request.contextPath}/user/profile" class="profile-link me-3">
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser.profileImg}">
            <img src="${pageContext.request.contextPath}/resources/upload/${sessionScope.loginUser.profileImg}"
                 alt="프로필"
                 class="profile-avatar">
        </c:when>
        <c:otherwise>
            <div class="profile-avatar" style="display:inline-flex; align-items:center; justify-content:center; background-color:#E8F3FF; color:#3182F6; font-weight:700;">
                ${fn:substring(sessionScope.loginUser.name, 0, 1)}
            </div>
        </c:otherwise>
    </c:choose>

    <span style="font-size:0.95rem; font-weight: 700;">
        ${sessionScope.loginUser.name}님
    </span>
</a>

<c:if test="${sessionScope.loginUser.role == 'ADMIN'}">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-dark rounded-pill btn-sm px-3 me-2 fw-bold">
        <i class="bi bi-gear-fill"></i> 관리
    </a>
</c:if>

<a href="${pageContext.request.contextPath}/user/logout" class="btn btn-light btn-sm text-secondary rounded-pill border px-3">로그아웃</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="container py-4">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        /* [Design System] Home.jsp와 동일한 변수 및 스타일 */
        :root {
            --bg-color: #F9FAFB;
            --text-main: #191F28;
            --text-sub: #8B95A1;
            --primary: #3182F6;
            --primary-hover: #1b64da;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            --radius-lg: 24px;
            --radius-md: 16px;
            --input-bg: #F2F4F6;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            padding-top: 80px; /* 헤더 공간 확보 */
            word-break: keep-all;
            overflow-y: scroll; /* 스크롤바 고정 (흔들림 방지) */
        }

        /* 네비게이션 (헤더) */
        .navbar {
            background-color: rgba(255, 255, 255, 0.8) !important;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(0,0,0,0.05);
            height: 70px;
            padding: 0;
        }

        .navbar .container {
            height: 100%;
            display: flex;
            align-items: center;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            letter-spacing: -0.5px;
            color: var(--text-main) !important;
            margin-right: 30px;
        }

        .nav-link {
            font-weight: 600;
            color: var(--text-sub) !important;
            transition: color 0.2s;
        }
        .nav-link:hover { color: var(--primary) !important; }

        /* 공통 요소 */
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
            border-radius: 50px; /* 검색창 스타일 통일 */
            padding: 16px 24px;
            font-size: 1rem;
            color: var(--text-main);
        }
        .form-control:focus, .form-select:focus {
            background-color: #fff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(49, 130, 246, 0.1);
        }
        .form-label { font-weight: 700; margin-bottom: 8px; color: #4E5968; font-size: 0.95rem; }

        /* 버튼 스타일 (Home.jsp 그대로 적용) */
        .btn-primary {
            background-color: var(--primary);
            border: none;
            /* border-radius는 HTML의 rounded-pill 클래스가 처리함 */
            padding: 10px 20px; /* 상하 패딩 약간 조정 */
            font-weight: 700;
            transition: background 0.2s;
        }
        .btn-primary:hover { background-color: var(--primary-hover); }

        .btn-secondary {
            background-color: #E8F3FF;
            color: var(--primary);
            border: none;
            font-weight: 700;
        }
        .btn-secondary:hover { background-color: #dbeaff; color: var(--primary-hover); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="/">HanBang</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/room/list">방 구하기</a></li>
                <li class="nav-item"><a class="nav-link" href="/room/write">방 내놓기</a></li>
            </ul>

            <div class="d-flex align-items-center gap-3">
                <c:if test="${empty sessionScope.loginUser}">
                    <a href="/user/login" class="text-decoration-none text-muted fw-bold" style="font-size: 0.95rem;">로그인</a>
                    <a href="/user/signup" class="btn btn-primary rounded-pill px-4 fw-bold">회원가입</a>
                </c:if>
                <c:if test="${not empty sessionScope.loginUser}">
                    <span class="text-muted me-2"><b>${sessionScope.loginUser.name}</b>님</span>
                    <a href="/user/logout" class="btn btn-secondary rounded-pill btn-sm px-3">로그아웃</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="container py-4">
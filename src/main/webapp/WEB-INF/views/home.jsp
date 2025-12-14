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
        /* [Design System] Toss & Apple Style */
        :root {
            --bg-color: #F9FAFB;       /* 아주 연한 회색 배경 */
            --text-main: #191F28;      /* 진한 검정 (Toss Black) */
            --text-sub: #8B95A1;       /* 연한 회색 (Toss Gray) */
            --primary: #3182F6;        /* Toss Blue */
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); /* 부드러운 그림자 */
            --radius-lg: 24px;         /* 큰 둥근 모서리 */
            --radius-md: 16px;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            word-break: keep-all; /* 한글 줄바꿈 교정 */
        }

        /* 네비게이션 커스텀 (헤더) */
        .navbar {
            background-color: rgba(255, 255, 255, 0.8) !important;
            backdrop-filter: blur(10px); /* 애플 스타일 블러 효과 */
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; letter-spacing: -0.5px; }

        /* 메인 히어로 섹션 */
        .hero-section {
            background-color: #fff;
            padding: 120px 0 80px;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            text-align: center;
        }

        .hero-title { font-size: 3.5rem; font-weight: 800; margin-bottom: 10px; line-height: 1.2; letter-spacing: -1px; }
        .hero-subtitle { font-size: 1.25rem; color: var(--text-sub); margin-bottom: 40px; font-weight: 500; }

        /* 검색창 커스텀 */
        .search-container {
            max-width: 600px;
            margin: 0 auto;
            position: relative;
        }
        .search-input {
            width: 100%;
            padding: 20px 30px;
            border-radius: 50px;
            border: 2px solid transparent;
            background-color: #F2F4F6;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: var(--card-shadow);
        }
        .search-input:focus {
            background-color: #fff;
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 4px rgba(49, 130, 246, 0.1);
        }
        .search-btn {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 50%;
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s;
        }
        .search-btn:hover { background-color: #1b64da; }

        /* 카드 섹션 */
        .card-container { margin-top: -40px; position: relative; z-index: 10; padding-bottom: 60px; }

        .action-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: 40px 30px;
            height: 100%;
            border: none;
            box-shadow: var(--card-shadow);
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .card-icon {
            width: 60px; height: 60px;
            background-color: #E8F3FF;
            color: var(--primary);
            border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            font-size: 24px; margin-bottom: 20px;
        }
        .card-title { font-size: 1.5rem; font-weight: 700; margin-bottom: 10px; }
        .card-desc { color: var(--text-sub); font-size: 1rem; line-height: 1.5; }

        /* 배지 스타일 */
        .badge-custom {
            background-color: rgba(49, 130, 246, 0.1);
            color: var(--primary);
            padding: 8px 16px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="/">HanBang</a>

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
</nav>

<section class="hero-section">
    <div class="container">
        <span class="badge-custom">한동대학교 전용</span>
        <h1 class="hero-title">
            학교 앞 자취방,<br>
            가장 쉽게 구하는 방법
        </h1>
        <p class="hero-subtitle">
            에브리타임보다 빠르고, 직방보다 정확해요.<br>
            한동인을 위한 안전한 매물을 확인해보세요.
        </p>

        <div class="search-container mt-5">
            <input type="text" class="search-input" placeholder="건물명, 지역(예: 평해길) 검색">
            <button class="search-btn"><i class="bi bi-search"></i></button>
        </div>
    </div>
</section>

<div class="container card-container">
    <div class="row g-4">
        <div class="col-md-6">
            <a href="/room/list" class="action-card">
                <div>
                    <div class="card-icon">
                        <i class="bi bi-house-door-fill"></i>
                    </div>
                    <h3 class="card-title">자취방 구경하기</h3>
                    <p class="card-desc">
                        학교 근처 원룸부터 쉐어하우스까지.<br>
                        지도와 필터로 원하는 방을 찾아보세요.
                    </p>
                </div>
                <div class="text-end text-primary fw-bold mt-3">
                    매물 전체보기 <i class="bi bi-arrow-right"></i>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <a href="/room/write" class="action-card" style="background-color: #E8F3FF;">
                <div>
                    <div class="card-icon" style="background-color: #fff;">
                        <i class="bi bi-upload"></i>
                    </div>
                    <h3 class="card-title" style="color: #191F28;">내 방 양도하기</h3>
                    <p class="card-desc" style="color: #4E5968;">
                        남은 계약 기간 때문에 고민이신가요?<br>
                        한동 학우들에게 간편하게 양도하세요.
                    </p>
                </div>
                <div class="text-end text-primary fw-bold mt-3">
                    매물 등록하기 <i class="bi bi-arrow-right"></i>
                </div>
            </a>
        </div>
    </div>

    <div class="row mt-5 text-center">
        <div class="col-4">
            <h2 class="fw-bold">150+</h2>
            <p class="text-muted">등록된 매물</p>
        </div>
        <div class="col-4">
            <h2 class="fw-bold">0원</h2>
            <p class="text-muted">중개 수수료</p>
        </div>
        <div class="col-4">
            <h2 class="fw-bold">100%</h2>
            <p class="text-muted">한동인 인증</p>
        </div>
    </div>
</div>

<footer class="text-center py-4 text-muted" style="font-size: 0.85rem;">
    <p class="mb-0">© 2025 HanBang Project. Handong Global University.</p>
</footer>

</body>
</html>
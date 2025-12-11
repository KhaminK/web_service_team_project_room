<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>한방 - 한동인을 위한 자취방</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; padding-top: 70px; }
        .navbar-brand { font-weight: bold; color: #0d6efd !important; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top border-bottom">
    <div class="container">
        <a class="navbar-brand" href="/">🏠 한방 (HanBang)</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/room/list">방 찾기</a></li>
                <li class="nav-item"><a class="nav-link" href="#">지도 보기</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:if test="${empty sessionScope.loginUser}">
                    <li class="nav-item"><a class="btn btn-outline-primary btn-sm me-2" href="/user/login">로그인</a></li>
                    <li class="nav-item"><a class="btn btn-primary btn-sm" href="/user/signup">회원가입</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.loginUser}">
                    <li class="nav-item"><span class="nav-link">Hi, <b>${sessionScope.loginUser.name}</b>님</span></li>
                    <li class="nav-item"><a class="btn btn-outline-secondary btn-sm" href="/user/logout">로그아웃</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-4">
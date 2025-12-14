<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center align-items-center" style="min-height: 75vh;">
    <div class="col-md-5 col-lg-4">

        <div class="custom-card p-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-2">로그인</h2>
                <p class="text-muted" style="font-size: 0.95rem;">한동인을 위한 안전한 자취방 플랫폼</p>
            </div>

            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="mb-3">
                    <label class="form-label">학번</label>
                    <input type="text" name="studentId" class="form-control" placeholder="학번을 입력해주세요 (예: 22200xxx)" required>
                </div>

                <div class="mb-5">
                    <label class="form-label">비밀번호</label>
                    <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-4" style="padding: 16px; font-size: 1.1rem;">
                    로그인하기
                </button>

                <div class="text-center">
                    <span class="text-muted small">아직 계정이 없으신가요?</span>
                    <a href="${pageContext.request.contextPath}/user/signup" class="text-decoration-none fw-bold ms-2" style="color:var(--primary)">회원가입</a>
                </div>
            </form>

            <c:if test="${param.error == 'true'}">
                <div class="alert alert-danger mt-4 text-center small border-0 bg-danger bg-opacity-10 text-danger fw-bold rounded-3">
                    학번 또는 비밀번호가 올바르지 않습니다.
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>
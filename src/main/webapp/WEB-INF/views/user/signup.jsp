<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center my-4">
    <div class="col-md-8 col-lg-6">
        <div class="custom-card">
            <h2 class="fw-bold text-center mb-5">회원가입</h2>

            <form action="/user/signup" method="post">
                <h5 class="fw-bold mb-3 ms-1">기본 정보</h5>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <input type="text" name="name" class="form-control" placeholder="실명을 입력해주세요">
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">학번 (ID)</label>
                        <input type="text" name="studentId" class="form-control" placeholder="예: 22200123">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">비밀번호</label>
                        <input type="password" name="password" class="form-control" placeholder="비밀번호">
                    </div>
                </div>

                <hr class="my-4" style="opacity:0.1">

                <h5 class="fw-bold mb-3 ms-1">상세 정보</h5>
                <div class="mb-3">
                    <label class="form-label">연락처</label>
                    <input type="text" name="phone" class="form-control" placeholder="010-0000-0000">
                </div>
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">성별</label>
                        <select name="gender" class="form-select">
                            <option value="M">남성</option>
                            <option value="F">여성</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">나이</label>
                        <input type="number" name="age" class="form-control" value="20">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 btn-lg">가입 완료</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>
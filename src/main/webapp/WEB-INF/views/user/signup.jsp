<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center my-4">
    <div class="col-md-8 col-lg-6">
        <div class="custom-card">
            <h2 class="fw-bold text-center mb-5">회원가입</h2>

            <form action="/user/signup" method="post" enctype="multipart/form-data">

                <h5 class="fw-bold mb-3 ms-1">프로필 사진</h5>
                <div class="mb-4 text-center p-4" style="background: #f8f9fa; border-radius: 12px;">

                    <div style="width: 120px; height: 120px; background: #ddd; border-radius: 50%; margin: 0 auto 20px; overflow: hidden; display: flex; justify-content: center; align-items: center; border: 2px solid #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1);">

                        <span id="defaultIcon" style="font-size: 40px; color: white;">?</span>

                        <img id="previewImg" src="#" alt="미리보기" style="width: 100%; height: 100%; object-fit: cover; display: none;">
                    </div>

                    <input type="file" name="file" id="fileInput" class="form-control" accept="image/*" onchange="readURL(this);">
                    <div class="form-text mt-2">이미지 파일(jpg, png 등)만 업로드 가능합니다.</div>
                </div>

                <hr class="my-4" style="opacity:0.1">

                <h5 class="fw-bold mb-3 ms-1">기본 정보</h5>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <input type="text" name="name" class="form-control" placeholder="실명을 입력해주세요" required>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">학번 (ID)</label>
                        <input type="text" name="studentId" class="form-control" placeholder="예: 22200123" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">비밀번호</label>
                        <input type="password" name="password" class="form-control" placeholder="비밀번호" required>
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

<script>
    function readURL(input) {
        // 파일을 선택했는지 확인
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            // 파일을 다 읽었으면 실행할 함수
            reader.onload = function(e) {
                // 1. 물음표 숨기기
                document.getElementById('defaultIcon').style.display = 'none';

                // 2. 이미지 태그 보이게 하기
                var img = document.getElementById('previewImg');
                img.style.display = 'block';

                // 3. 이미지 소스에 읽은 파일 내용(데이터) 넣기
                img.src = e.target.result;
            };

            // 파일 읽기 시작
            reader.readAsDataURL(input.files[0]);
        } else {
            // 취소했을 경우 다시 초기화
            document.getElementById('defaultIcon').style.display = 'block';
            document.getElementById('previewImg').style.display = 'none';
        }
    }
</script>

<%@ include file="../include/footer.jsp" %>
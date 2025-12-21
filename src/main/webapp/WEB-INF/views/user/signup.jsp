<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center my-4">
    <div class="col-md-8 col-lg-6">
        <div class="custom-card">
            <h2 class="fw-bold text-center mb-5">회원가입</h2>

            <form action="${pageContext.request.contextPath}/user/signup" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

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
                    <input type="text" name="name" id="userName" class="form-control" placeholder="실명을 입력해주세요" required oninput="checkName()">
                    <div id="nameError" class="text-danger small mt-1" style="display:none; font-weight: bold;">
                        * 이름은 한글 또는 영문만 입력 가능합니다.
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">학번 (ID)</label>
                        <input type="text" name="studentId" id="studentId" class="form-control" placeholder="예: 22200123" maxlength="8" required oninput="checkStudentId()">
                        <div id="studentIdError" class="text-danger small mt-1" style="display:none; font-weight: bold;">
                            * 학번은 8자리 숫자만 가능합니다.
                        </div>
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
                    <input type="text" name="phone" id="userPhone" class="form-control" placeholder="010-0000-0000" oninput="checkPhone()">
                    <div id="phoneError" class="text-danger small mt-1" style="display:none; font-weight: bold;">
                        * 전화번호 형식을 지켜주세요 (예: 010-1234-5678)
                    </div>
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
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('defaultIcon').style.display = 'none';
                var img = document.getElementById('previewImg');
                img.style.display = 'block';
                img.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById('defaultIcon').style.display = 'block';
            document.getElementById('previewImg').style.display = 'none';
        }
    }

    // 이름 유효성 검사
    function checkName() {
        var nameInput = document.getElementById('userName');
        var errorMsg = document.getElementById('nameError');
        var regex = /^[가-힣a-zA-Z]+$/;

        if (nameInput.value.length > 0 && !regex.test(nameInput.value)) {
            errorMsg.style.display = 'block';
            return false;
        } else {
            errorMsg.style.display = 'none';
            return true;
        }
    }

    // [추가됨] 학번 유효성 검사 (숫자 8자리)
    function checkStudentId() {
        var idInput = document.getElementById('studentId');
        var errorMsg = document.getElementById('studentIdError');

        // 입력값에서 숫자가 아닌 문자가 들어오면 바로 삭제 (사용자 편의)
        idInput.value = idInput.value.replace(/[^0-9]/g, '');

        // 정규식: 숫자(\d)가 정확히 8개({8})여야 함
        var regex = /^\d{8}$/;

        // 값이 있는데 8자리가 아니면 에러 표시
        if (idInput.value.length > 0 && !regex.test(idInput.value)) {
            errorMsg.style.display = 'block';
            return false;
        } else {
            errorMsg.style.display = 'none';
            return true;
        }
    }

    // 전화번호 유효성 검사
    function checkPhone() {
        var phoneInput = document.getElementById('userPhone');
        var errorMsg = document.getElementById('phoneError');
        var regex = /^010-\d{4}-\d{4}$/;

        if (phoneInput.value.length > 0 && !regex.test(phoneInput.value)) {
            errorMsg.style.display = 'block';
            return false;
        } else {
            errorMsg.style.display = 'none';
            return true;
        }
    }

    // 폼 제출 전 최종 확인
    function validateForm() {
        var isNameValid = checkName();
        var isPhoneValid = checkPhone();
        var isIdValid = checkStudentId(); // 학번 체크 추가

        if (!isNameValid) {
            alert("이름 형식을 확인해주세요.");
            document.getElementById('userName').focus();
            return false;
        }
        if (!isIdValid) {
            alert("학번은 8자리 숫자여야 합니다.");
            document.getElementById('studentId').focus();
            return false;
        }
        if (!isPhoneValid) {
            alert("전화번호 형식을 확인해주세요.");
            document.getElementById('userPhone').focus();
            return false;
        }

        return true;
    }
</script>

<%@ include file="../include/footer.jsp" %>
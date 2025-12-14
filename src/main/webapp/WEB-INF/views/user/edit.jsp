<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../include/header.jsp" />

<style>
    :root {
        --primary-color: #3182F6;
        --secondary-color: #E8F3FF;
        --input-bg: #F2F4F6;
        --text-color: #333;
    }

    .edit-container {
        max-width: 600px;
        margin: 60px auto;
        padding: 40px;
        background: white;
        border-radius: 24px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    }

    .edit-header { text-align: center; margin-bottom: 40px; }
    .edit-header h2 { font-weight: 800; color: #191F28; }

    /* 폼 스타일 */
    .form-group { margin-bottom: 24px; }
    .form-label { font-weight: 700; display: block; margin-bottom: 8px; color: #4E5968; }

    .form-control {
        width: 100%;
        padding: 16px;
        border-radius: 12px;
        border: 2px solid transparent;
        background-color: var(--input-bg);
        font-size: 16px;
        transition: 0.2s;
    }
    .form-control:focus {
        background-color: #fff;
        border-color: var(--primary-color);
        outline: none;
    }
    .form-control[readonly] { background-color: #f9f9f9; color: #999; cursor: not-allowed; }

    /* 사진 업로드 미리보기 */
    .profile-preview-box {
        text-align: center;
        margin-bottom: 30px;
    }
    .preview-img {
        width: 100px; height: 100px;
        border-radius: 50%;
        object-fit: cover;
        border: 1px solid #ddd;
        margin-bottom: 10px;
    }
    .file-input-btn {
        display: inline-block;
        padding: 8px 16px;
        background-color: var(--secondary-color);
        color: var(--primary-color);
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        font-size: 14px;
    }

    .btn-submit {
        width: 100%;
        padding: 18px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 16px;
        font-size: 18px;
        font-weight: 700;
        cursor: pointer;
        margin-top: 10px;
        transition: 0.2s;
    }
    .btn-submit:hover { background-color: #1b64da; }

    .btn-cancel {
        display: block;
        width: 100%;
        text-align: center;
        padding: 16px;
        color: #8B95A1;
        text-decoration: none;
        font-weight: 600;
        margin-top: 10px;
    }
</style>

<div class="edit-container">
    <div class="edit-header">
        <h2>내 정보 수정</h2>
    </div>

    <form action="/user/update" method="post" enctype="multipart/form-data">

        <div class="profile-preview-box">
            <c:choose>
                <c:when test="${not empty loginUser.profileImg}">
                    <img id="preview" src="${pageContext.request.contextPath}/resources/upload/${loginUser.profileImg}" class="preview-img">
                </c:when>
                <c:otherwise>
                    <img id="preview" src="https://dummyimage.com/100x100/eee/aaa&text=User" class="preview-img">
                </c:otherwise>
            </c:choose>
            <br>
            <label for="fileInput" class="file-input-btn">사진 변경하기</label>
            <input type="file" id="fileInput" name="file" style="display:none;" accept="image/*" onchange="readURL(this);">
            <input type="hidden" name="originalProfileImg" value="${loginUser.profileImg}">
        </div>

        <div class="form-group">
            <label class="form-label">학번</label>
            <input type="text" class="form-control" value="${loginUser.studentId}" readonly>
        </div>
        <div class="form-group">
            <label class="form-label">이름</label>
            <input type="text" class="form-control" value="${loginUser.name}" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">전화번호</label>
            <input type="text" name="phone" class="form-control" value="${loginUser.phone}">
        </div>

        <div class="row">
            <div class="col-6 form-group">
                <label class="form-label">나이</label>
                <input type="number" name="age" class="form-control" value="${loginUser.age}">
            </div>
            <div class="col-6 form-group">
                <label class="form-label">성별</label>
                <select name="gender" class="form-control">
                    <option value="남" ${loginUser.gender eq '남' ? 'selected' : ''}>남성</option>
                    <option value="여" ${loginUser.gender eq '여' ? 'selected' : ''}>여성</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">사용 언어</label>
            <input type="text" name="language" class="form-control" value="${loginUser.language}" placeholder="예: Korean, English, Khmer">
        </div>

        <button type="submit" class="btn-submit">수정 완료</button>
        <a href="/user/profile" class="btn-cancel">취소하고 돌아가기</a>
    </form>
</div>

<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('preview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

<jsp:include page="../include/footer.jsp" />
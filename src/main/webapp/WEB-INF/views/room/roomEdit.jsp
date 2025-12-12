<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="custom-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold">내 방 정보 수정하기</h3>
                <span class="badge bg-secondary">No. ${room.roomNo}</span>
            </div>

            <form action="/room/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="roomNo" value="${room.roomNo}">

                <div class="mb-4">
                    <label class="form-label">제목</label>
                    <input type="text" name="title" class="form-control" value="${room.title}" required>
                </div>

                <div class="mb-4">
                    <label class="form-label d-block">방 사진 (클릭하여 수정)</label>
                    <div class="row g-2">
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview1" src="${not empty room.filename1 ? '/resources/upload/'.concat(room.filename1) : ''}"
                                     class="w-100 h-100" style="object-fit: cover; display: ${not empty room.filename1 ? 'block' : 'none'};">

                                <div id="placeholder1" class="position-absolute top-50 start-50 translate-middle text-center text-muted"
                                     style="display: ${not empty room.filename1 ? 'none' : 'block'};">
                                    <i class="bi bi-camera fs-3"></i><br><small>사진 1</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview1', 'placeholder1')">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview2" src="${not empty room.filename2 ? '/resources/upload/'.concat(room.filename2) : ''}"
                                     class="w-100 h-100" style="object-fit: cover; display: ${not empty room.filename2 ? 'block' : 'none'};">

                                <div id="placeholder2" class="position-absolute top-50 start-50 translate-middle text-center text-muted"
                                     style="display: ${not empty room.filename2 ? 'none' : 'block'};">
                                    <i class="bi bi-plus-lg fs-3"></i><br><small>사진 2</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview2', 'placeholder2')">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview3" src="${not empty room.filename3 ? '/resources/upload/'.concat(room.filename3) : ''}"
                                     class="w-100 h-100" style="object-fit: cover; display: ${not empty room.filename3 ? 'block' : 'none'};">

                                <div id="placeholder3" class="position-absolute top-50 start-50 translate-middle text-center text-muted"
                                     style="display: ${not empty room.filename3 ? 'none' : 'block'};">
                                    <i class="bi bi-plus-lg fs-3"></i><br><small>사진 3</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview3', 'placeholder3')">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">보증금</label>
                        <div class="input-group">
                            <input type="number" name="deposit" class="form-control" value="${room.deposit}">
                            <span class="input-group-text bg-light border-0">원</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">월세</label>
                        <div class="input-group">
                            <input type="number" name="price" class="form-control" value="${room.price}">
                            <span class="input-group-text bg-light border-0">원</span>
                        </div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">방 구조</label>
                        <select name="roomType" class="form-select">
                            <option value="원룸" ${room.roomType == '원룸' ? 'selected' : ''}>원룸</option>
                            <option value="투룸" ${room.roomType == '투룸' ? 'selected' : ''}>투룸</option>
                            <option value="미니투룸" ${room.roomType == '미니투룸' ? 'selected' : ''}>미니투룸</option>
                            <option value="쉐어하우스" ${room.roomType == '쉐어하우스' ? 'selected' : ''}>쉐어하우스</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">버스정류장 거리</label>
                        <select name="busDistance" class="form-select">
                            <option value="도보 5분 이내" ${room.busDistance == '도보 5분 이내' ? 'selected' : ''}>도보 5분 이내</option>
                            <option value="도보 10분 이내" ${room.busDistance == '도보 10분 이내' ? 'selected' : ''}>도보 10분 이내</option>
                            <option value="도보 15분 이상" ${room.busDistance == '도보 15분 이상' ? 'selected' : ''}>도보 15분 이상</option>
                            <option value="차량 이동 필요" ${room.busDistance == '차량 이동 필요' ? 'selected' : ''}>차량 이동 필요</option>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">주소</label>
                    <input type="text" name="address" class="form-control mb-2" value="${room.address}" required>
                    <input type="text" name="addressDetail" class="form-control" value="${room.addressDetail}">
                </div>

                <div class="mb-4">
                    <label class="form-label">상세 설명</label>
                    <textarea name="content" class="form-control" rows="8">${room.content}</textarea>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="/room/detail?id=${room.roomNo}" class="btn btn-secondary text-white text-decoration-none">취소</a>
                    <button type="submit" class="btn btn-primary px-5">수정 완료</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function previewImage(input, imgId, placeholderId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var img = document.getElementById(imgId);
                img.src = e.target.result;
                img.style.display = 'block';
                document.getElementById(placeholderId).style.display = 'none';
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

<%@ include file="../include/footer.jsp" %>
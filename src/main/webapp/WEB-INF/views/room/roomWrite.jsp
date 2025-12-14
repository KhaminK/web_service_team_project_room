<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="custom-card">
            <h3 class="fw-bold mb-4">내 방 내놓기</h3>

            <form action="${pageContext.request.contextPath}/room/write" method="post" enctype="multipart/form-data">
                <div class="mb-4">
                    <label class="form-label">제목</label>
                    <input type="text" name="title" class="form-control" placeholder="예: 벧엘관 3분거리 깨끗한 원룸 양도해요" required>
                </div>

                <div class="mb-4">
                    <label class="form-label d-block">방 사진 (최대 3장)</label>
                    <div class="row g-2">
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview1" src="" class="w-100 h-100" style="object-fit: cover; display: none;">
                                <div id="placeholder1" class="position-absolute top-50 start-50 translate-middle text-center text-muted">
                                    <i class="bi bi-camera fs-3"></i><br><small>사진 1</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview1', 'placeholder1')">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview2" src="" class="w-100 h-100" style="object-fit: cover; display: none;">
                                <div id="placeholder2" class="position-absolute top-50 start-50 translate-middle text-center text-muted">
                                    <i class="bi bi-plus-lg fs-3"></i><br><small>사진 2</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview2', 'placeholder2')">
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="border rounded-3 overflow-hidden position-relative bg-light" style="height: 150px;">
                                <img id="preview3" src="" class="w-100 h-100" style="object-fit: cover; display: none;">
                                <div id="placeholder3" class="position-absolute top-50 start-50 translate-middle text-center text-muted">
                                    <i class="bi bi-plus-lg fs-3"></i><br><small>사진 3</small>
                                </div>
                                <input type="file" name="photos" class="position-absolute top-0 start-0 w-100 h-100 opacity-0 cursor-pointer"
                                       accept="image/*" onchange="previewImage(this, 'preview3', 'placeholder3')">
                            </div>
                        </div>
                    </div>
                    <div class="form-text mt-2">클릭하여 사진을 추가하세요. 첫 번째 사진이 대표 이미지가 됩니다.</div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">보증금 (원)</label>
                        <div class="input-group">
                            <input type="number" name="deposit" class="form-control" placeholder="3000000">
                            <span class="input-group-text bg-light border-0">원</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">월세 (관리비 포함)</label>
                        <div class="input-group">
                            <input type="number" name="price" class="form-control" placeholder="350000">
                            <span class="input-group-text bg-light border-0">원</span>
                        </div>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">방 구조</label>
                        <select name="roomType" class="form-select">
                            <option value="원룸">원룸</option>
                            <option value="투룸">투룸</option>
                            <option value="미니투룸">미니투룸</option>
                            <option value="쉐어하우스">쉐어하우스</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">버스정류장 거리</label>
                        <select name="busDistance" class="form-select">
                            <option value="도보 5분 이내">도보 5분 이내</option>
                            <option value="도보 10분 이내">도보 10분 이내</option>
                            <option value="도보 15분 이상">도보 15분 이상</option>
                            <option value="차량 이동 필요">차량 이동 필요</option>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">주소</label>
                    <input type="text" name="address" class="form-control mb-2" placeholder="도로명 주소" required>
                    <input type="text" name="addressDetail" class="form-control" placeholder="상세 주소">
                </div>

                <div class="mb-4">
                    <label class="form-label">상세 설명</label>
                    <textarea name="content" class="form-control" rows="8" placeholder="상세 내용을 입력해주세요."></textarea>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/room/list" class="btn btn-secondary px-5 text-decoration-none">취소</a>
                    <button type="submit" class="btn btn-primary px-5">등록하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 이미지 미리보기 함수
    function previewImage(input, imgId, placeholderId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                // 이미지 보이기
                var img = document.getElementById(imgId);
                img.src = e.target.result;
                img.style.display = 'block';
                // 아이콘 숨기기
                document.getElementById(placeholderId).style.display = 'none';
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            // 파일 선택 취소 시 초기화
            document.getElementById(imgId).style.display = 'none';
            document.getElementById(placeholderId).style.display = 'block';
        }
    }
</script>

<%@ include file="../include/footer.jsp" %>
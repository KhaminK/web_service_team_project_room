<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="custom-card">
            <h3 class="fw-bold mb-4">📝 내 방 내놓기</h3>

            <form action="/room/write" method="post" enctype="multipart/form-data">
                <div class="mb-4">
                    <label class="form-label">제목</label>
                    <input type="text" name="title" class="form-control" placeholder="예: 벧엘관 3분거리 깨끗한 원룸 양도해요" required>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">가격 (월세/관리비 포함)</label>
                        <div class="input-group">
                            <input type="number" name="price" class="form-control" placeholder="350000">
                            <span class="input-group-text bg-light border-0">원</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">방 구조</label>
                        <select name="roomType" class="form-select">
                            <option value="원룸">원룸</option>
                            <option value="투룸">투룸</option>
                            <option value="미니투룸">미니투룸</option>
                            <option value="쉐어하우스">쉐어하우스</option>
                        </select>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">주소</label>
                    <input type="text" name="address" class="form-control mb-2" placeholder="도로명 주소 (예: 흥해읍 한동로...)" required>
                    <input type="text" name="addressDetail" class="form-control" placeholder="상세 주소 (예: 101동 202호)">
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">학교 버스정류장 거리</label>
                        <select name="busDistance" class="form-select">
                            <option value="도보 5분 이내">도보 5분 이내</option>
                            <option value="도보 10분 이내">도보 10분 이내</option>
                            <option value="도보 15분 이상">도보 15분 이상</option>
                            <option value="차량 이동 필요">차량 이동 필요</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">방 상태 점수 (5점 만점)</label>
                        <input type="number" name="conditionScore" class="form-control" min="1" max="5" value="5">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">상세 설명</label>
                    <textarea name="content" class="form-control" rows="8" placeholder="옵션(에어컨, 세탁기 등), 입주 가능일, 장단점 등을 자유롭게 적어주세요."></textarea>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="/room/list" class="btn btn-secondary text-white text-decoration-none">취소</a>
                    <button type="submit" class="btn btn-primary px-5">등록하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>
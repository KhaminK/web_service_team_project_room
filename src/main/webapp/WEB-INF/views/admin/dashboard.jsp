<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    .stat-card {
        background: white; border-radius: 20px; padding: 30px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.03); height: 100%;
        display: flex; justify-content: space-between; align-items: center;
    }
    .stat-icon {
        width: 60px; height: 60px; background: #F2F4F6; border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        color: var(--primary); font-size: 1.8rem;
    }
    .chart-container {
        background: white; border-radius: 20px; padding: 20px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.03); margin-bottom: 20px;
    }
    .table-custom th { background-color: #F9FAFB; border-bottom: none; color: #8B95A1; padding: 15px; font-weight: 600; }
    .table-custom td { padding: 15px; vertical-align: middle; border-bottom: 1px solid #f1f3f5; }

    /* 탭 버튼 스타일 */
    .nav-pills .nav-link {
        background-color: white;
        color: #8B95A1;
        border: 1px solid #e9ecef;
        padding: 15px;
        font-size: 1.1rem;
        transition: all 0.2s;
    }

    /* 활성화된 탭 글자색 흰색으로 강제 고정 */
    .nav-pills .nav-link.active {
        background-color: var(--primary);
        color: #ffffff !important;
        border-color: var(--primary);
        box-shadow: 0 4px 10px rgba(49, 130, 246, 0.3);
        transform: translateY(-2px);
    }
</style>

<div class="row g-4">
    <div class="col-lg-3">
        <div class="custom-card p-4 h-100">
            <h4 class="fw-bold mb-4 ps-2">관리자 메뉴</h4>
            <div class="list-group list-group-flush">
                <a href="#" class="list-group-item list-group-item-action border-0 rounded-3 active fw-bold mb-2" style="background-color: var(--primary); color: white;">
                    <i class="bi bi-grid-fill me-2"></i> 대시보드
                </a>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action border-0 rounded-3 text-muted">
                    <i class="bi bi-house-door me-2"></i> 메인으로 돌아가기
                </a>
            </div>

            <div class="mt-5 p-3 bg-light rounded-4">
                <p class="mb-1 text-muted small fw-bold">관리자 계정</p>
                <div class="d-flex align-items-center gap-2">
                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width:32px; height:32px;">A</div>
                    <span class="fw-bold">${sessionScope.loginUser.name}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-9">

        <div class="row g-4 mb-4">
            <div class="col-md-6">
                <div class="stat-card">
                    <div>
                        <p class="text-muted mb-1 fw-bold">총 회원 수</p>
                        <h2 class="fw-bold mb-0">${totalUsers}명</h2>
                    </div>
                    <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="stat-card">
                    <div>
                        <p class="text-muted mb-1 fw-bold">등록된 매물</p>
                        <h2 class="fw-bold mb-0">${totalRooms}개</h2>
                    </div>
                    <div class="stat-icon"><i class="bi bi-house-check-fill"></i></div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <div class="chart-container">
                    <h6 class="fw-bold mb-3 ms-2">📊 회원 증가 추이 (최근 3개월)</h6>
                    <canvas id="userChart"></canvas>
                </div>
            </div>
            <div class="col-md-6">
                <div class="chart-container">
                    <h6 class="fw-bold mb-3 ms-2">📈 매물 등록 추이 (최근 3개월)</h6>
                    <canvas id="roomChart"></canvas>
                </div>
            </div>
        </div>

        <ul class="nav nav-pills nav-fill mb-4 gap-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active rounded-4 fw-bold" id="pills-users-tab" data-bs-toggle="pill" data-bs-target="#pills-users" type="button">
                    <i class="bi bi-person-gear me-2"></i> 회원 관리
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link rounded-4 fw-bold" id="pills-rooms-tab" data-bs-toggle="pill" data-bs-target="#pills-rooms" type="button">
                    <i class="bi bi-houses me-2"></i> 매물 관리
                </button>
            </li>
        </ul>

        <div class="tab-content custom-card p-0 overflow-hidden" id="pills-tabContent">

            <div class="tab-pane fade show active" id="pills-users">
                <div class="table-responsive">
                    <table class="table table-custom mb-0 w-100">
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>이름</th>
                            <th>학번</th>
                            <th>전화번호</th>
                            <th>가입일</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="user" items="${userList}" varStatus="status">
                            <tr>
                                <td class="fw-bold text-primary">${status.count}</td>
                                <td class="fw-bold">${user.name}</td>
                                <td>${user.studentId}</td>
                                <td>${user.phone}</td>
                                <td><fmt:formatDate value="${user.createdAt}" pattern="yyyy.MM.dd"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete?id=${user.userNo}" onclick="return confirm('이 회원을 탈퇴시키시겠습니까?')" class="btn btn-sm btn-danger rounded-pill fw-bold px-3">탈퇴</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tab-pane fade" id="pills-rooms">
                <div class="table-responsive">
                    <table class="table table-custom mb-0 w-100">
                        <thead>
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>가격</th>
                            <th>등록일</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="room" items="${roomList}" varStatus="status">
                            <tr>
                                <td class="fw-bold text-primary">${status.count}</td>
                                <td><a href="${pageContext.request.contextPath}/room/detail?id=${room.roomNo}" class="text-dark fw-bold text-decoration-none">${room.title}</a></td>
                                <td>${room.writerName}</td>
                                <td><fmt:formatNumber value="${room.price}" pattern="#,###"/>원</td>
                                <td><fmt:formatDate value="${room.createdAt}" pattern="yyyy.MM.dd"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/room/delete?id=${room.roomNo}" onclick="return confirm('이 매물을 강제 삭제하시겠습니까?')" class="btn btn-sm btn-danger rounded-pill fw-bold px-3">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 차트 데이터 (Controller에서 전달받음)
    new Chart(document.getElementById('userChart'), {
        type: 'line',
        data: {
            labels: [${userLabels}],
            datasets: [{
                label: '신규 회원',
                data: [${userCounts}],
                borderColor: '#3182F6',
                backgroundColor: 'rgba(49, 130, 246, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
    });

    new Chart(document.getElementById('roomChart'), {
        type: 'bar',
        data: {
            labels: [${roomLabels}],
            datasets: [{
                label: '신규 매물',
                data: [${roomCounts}],
                backgroundColor: ['#FF6B6B', '#FFD93D', '#6BCB77'],
                borderRadius: 5
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
    });
</script>

<%@ include file="../include/footer.jsp" %>
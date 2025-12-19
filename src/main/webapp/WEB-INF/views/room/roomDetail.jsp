<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

<div class="row align-items-center mb-4">

    <div class="col-lg-7">
        <div class="bg-light rounded-4 overflow-hidden shadow-sm position-relative" style="height: 450px;">
            <c:choose>
                <c:when test="${not empty room.filename1 or not empty room.filename2 or not empty room.filename3}">
                    <div id="roomCarousel" class="carousel slide h-100" data-bs-ride="carousel">
                        <div class="carousel-inner h-100">
                            <c:if test="${not empty room.filename1}">
                                <div class="carousel-item active h-100">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename1}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                            <c:if test="${not empty room.filename2}">
                                <div class="carousel-item h-100 ${empty room.filename1 ? 'active' : ''}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename2}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                            <c:if test="${not empty room.filename3}">
                                <div class="carousel-item h-100">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${room.filename3}" class="d-block w-100 h-100" style="object-fit: cover;">
                                </div>
                            </c:if>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#roomCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#roomCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex align-items-center justify-content-center h-100">
                        <i class="bi bi-image text-secondary" style="font-size: 5rem; opacity: 0.3;"></i>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="col-lg-5">
        <div class="custom-card h-100 p-4 pt-5">
            <div class="mb-3 d-flex align-items-center gap-2">
                <span class="badge bg-primary rounded-pill px-3 py-2">${room.roomType}</span>
                <span class="badge bg-success rounded-pill px-3 py-2">거래가능</span>

                <span class="ms-auto text-muted small"><i class="bi bi-eye-fill"></i> ${room.viewCount}</span>
            </div>

            <h2 class="fw-bold mb-3" style="word-break: keep-all;">${room.title}</h2>

            <div class="d-flex flex-wrap align-items-center mb-4 gap-2">
                <h3 class="text-primary fw-bold mb-0">
                    보증금 <fmt:formatNumber value="${room.deposit / 10000}" pattern="#,###" />
                    / 월 <fmt:formatNumber value="${room.price / 10000}" pattern="#,###" />
                </h3>
                <span class="text-dark fw-bold fs-4">만원</span>

                <button type="button" class="btn btn-link text-muted p-0 ms-1"
                        data-bs-toggle="popover" data-bs-trigger="focus" data-bs-title="가격 정보"
                        data-bs-content="월세엔 관리비가 포함되어 있습니다. 공과금은 별도입니다.">
                    <i class="bi bi-info-circle-fill fs-5" style="color: #adb5bd;"></i>
                </button>
            </div>

            <hr style="opacity:0.1">

            <div class="vstack gap-3 my-4">
                <div class="d-flex">
                    <i class="bi bi-geo-alt-fill text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">주소</span>
                        <span class="text-muted small">${room.address} ${room.addressDetail}</span>
                    </div>
                </div>
                <div class="d-flex">
                    <i class="bi bi-bus-front-fill text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">버스 정류장</span>
                        <span class="text-muted small">${room.busDistance}</span>
                    </div>
                </div>

                <div class="d-flex">
                    <i class="bi bi-person-circle text-muted me-3 fs-5"></i>
                    <div>
                        <span class="d-block fw-bold text-dark">작성자</span>
                        <span class="text-muted small d-flex align-items-center">
                            ${room.writerName}
                            <c:choose>
                                <c:when test="${room.writerGender == 'M'}">
                                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary ms-2" style="font-size: 0.75rem;">남성</span>
                                </c:when>
                                <c:when test="${room.writerGender == 'F'}">
                                    <span class="badge bg-danger bg-opacity-10 text-danger border border-danger ms-2" style="font-size: 0.75rem;">여성</span>
                                </c:when>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>

            <div class="mt-auto">
                <div class="d-flex gap-2">
                    <button class="btn btn-primary btn-lg flex-grow-1 shadow-sm">연락하기</button>

                    <button type="button" class="btn btn-outline-danger btn-lg" onclick="toggleWish()">
                        <i class="bi ${isWished ? 'bi-heart-fill' : 'bi-heart'}" id="wishIcon"></i>
                    </button>
                </div>

                <c:if test="${sessionScope.loginUser.userNo == room.writerId}">
                    <div class="row g-2 mt-2">
                        <div class="col-6">
                            <a href="${pageContext.request.contextPath}/room/edit?id=${room.roomNo}"
                               class="btn btn-outline-secondary w-100 fw-bold">
                                <i class="bi bi-pencil-square"></i> 수정
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="${pageContext.request.contextPath}/room/delete?id=${room.roomNo}"
                               onclick="return confirm('정말로 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.')"
                               class="btn btn-outline-danger w-100 fw-bold">
                                <i class="bi bi-trash"></i> 삭제
                            </a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-12">
        <div class="custom-card p-4">
            <div class="d-flex mb-3">
                <i class="bi bi-map-fill text-muted me-3 fs-5"></i>
                <div class="w-100">
                    <span class="d-block fw-bold text-dark mb-2">위치 정보</span>
                    <span class="text-muted small mb-3 d-block">${room.address} ${room.addressDetail}</span>
                    <div id="map" style="width:100%; height:350px; border-radius: 12px; border:1px solid #eee;"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-12">
        <div class="custom-card p-4">
            <h4 class="fw-bold mb-4">상세 설명</h4>
            <p class="text-muted" style="line-height: 1.8; white-space: pre-wrap;">${room.content}</p>
        </div>
    </div>
</div>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=a9c5fde88c6c3ba7021a5c783419cfb1&libraries=services&autoload=false"></script>

<script>
    document.addEventListener("DOMContentLoaded", function(){
        // 1. 팝오버 초기화
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl)
        })

        // 2. 카카오맵 로드
        kakao.maps.load(function() {
            var mapContainer = document.getElementById('map');
            var mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 데이터 준비
            var mainAddr = '${room.address}'.trim();
            var detailAddr = '${room.addressDetail}'.trim();
            var fullAddr = mainAddr + " " + detailAddr;

            var ps = new kakao.maps.services.Places();
            var geocoder = new kakao.maps.services.Geocoder();

            // [1단계] 주소 + 상세주소 (장소 검색)
            ps.keywordSearch(fullAddr, function(data, status) {
                if (status === kakao.maps.services.Status.OK) {
                    displayMarker(data[0].y, data[0].x);
                } else {
                    runStep2();
                }
            });

            // [2단계] 기본 주소 (장소 검색)
            function runStep2() {
                ps.keywordSearch(mainAddr, function(data, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        displayMarker(data[0].y, data[0].x);
                    } else {
                        runStep3();
                    }
                });
            }

            // [3단계] 기본 주소 (주소 검색)
            function runStep3() {
                geocoder.addressSearch(mainAddr, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        displayMarker(result[0].y, result[0].x);
                    } else {
                        showErrorDisplay();
                    }
                });
            }

            function showErrorDisplay() {
                mapContainer.style.backgroundColor = "#f8f9fa";
                mapContainer.style.display = "flex";
                mapContainer.style.flexDirection = "column";
                mapContainer.style.alignItems = "center";
                mapContainer.style.justifyContent = "center";
                mapContainer.innerHTML = `
                    <div class="text-center text-secondary">
                        <i class="bi bi-geo-alt-fill" style="font-size: 3rem; color: #dee2e6;"></i>
                        <h5 class="fw-bold mt-3">위치 정보를 표시할 수 없습니다.</h5>
                    </div>
                `;
            }

            function displayMarker(lat, lng) {
                var coords = new kakao.maps.LatLng(lat, lng);
                var marker = new kakao.maps.Marker({ map: map, position: coords });

                var displayText = detailAddr ? detailAddr : mainAddr;
                var iwContent = '<div style="padding:5px; width:150px; text-align:center; font-size:12px;">' + displayText + '</div>';

                var infowindow = new kakao.maps.InfoWindow({ content : iwContent });
                infowindow.open(map, marker);
                map.setCenter(coords);
            }
        });
    });

    // 3. 찜하기 기능 (복구됨)
    function toggleWish() {
        // 로그인 체크
        <c:if test="${empty sessionScope.loginUser}">
        if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/user/login";
        }
        return;
        </c:if>

        const roomNo = '${room.roomNo}';
        const icon = document.getElementById('wishIcon');

        // 서버에 찜 요청
        fetch('${pageContext.request.contextPath}/room/like', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ roomNo: parseInt(roomNo) })
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    if (data.liked) {
                        // 찜 성공 -> 꽉 찬 하트로 변경
                        icon.classList.remove('bi-heart');
                        icon.classList.add('bi-heart-fill');
                    } else {
                        // 찜 해제 -> 빈 하트로 변경
                        icon.classList.remove('bi-heart-fill');
                        icon.classList.add('bi-heart');
                    }
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("오류가 발생했습니다.");
            });
    }
</script>

<%@ include file="../include/footer.jsp" %>
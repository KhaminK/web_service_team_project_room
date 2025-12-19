package com.handong.web.room.service;

import com.handong.web.room.dao.RoomDao;
import com.handong.web.room.vo.RoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomService {

    @Autowired
    private RoomDao roomDao;

    // 1. 방 등록
    public void addRoom(RoomVO vo) {
        roomDao.insertRoom(vo);
    }

    // 2. 방 전체 목록 조회
    public List<RoomVO> getRoomList(String roomType, String sort) {
        return roomDao.selectRoomList(roomType, sort);
    }

    public List<RoomVO> getRoomList() {
        // 아무 조건이 없으면 -> "전체(all)"를 "최신순(latest)"으로 가져오라고 시킴
        return getRoomList("all", "latest");
    }

    // 3. 방 상세 정보 조회 (조회수 증가 포함)
    public RoomVO getRoomDetail(int roomNo) {
        // 상세 페이지를 볼 때마다 조회수를 1 올림
        roomDao.increaseViewCount(roomNo);
        return roomDao.selectRoomDetail(roomNo);
    }

    // 4. 방 삭제
    public void removeRoom(int roomNo) {
        roomDao.deleteRoom(roomNo);
    }

    public void updateRoom(RoomVO vo) {
        roomDao.updateRoom(vo);
    }

    // 관리자용: 총 매물 수
    public int countRooms() {
        return roomDao.countAllRooms();
    }


    public boolean isWished(int userNo, int roomNo) {
        return roomDao.checkWish(userNo, roomNo) > 0;
    }

    // 2. 찜 토글 (버튼 클릭 시: 찜 했으면 취소, 안 했으면 추가)
    public boolean toggleWish(int userNo, int roomNo) {
        int count = roomDao.checkWish(userNo, roomNo);

        if (count > 0) {
            // 이미 찜 상태 -> 삭제
            roomDao.removeWish(userNo, roomNo);
            return false; // 결과: 찜 해제됨 (빈 하트)
        } else {
            // 찜 안 된 상태 -> 추가
            roomDao.addWish(userNo, roomNo);
            return true;  // 결과: 찜 됨 (꽉 찬 하트)
        }
    }
}
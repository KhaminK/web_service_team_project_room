package com.handong.web.room.dao;

import com.handong.web.room.vo.RoomVO;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Repository
public interface RoomDao {

    // 1. 매물 등록 (Mapper ID: insertRoom)
    void insertRoom(RoomVO vo);

    // 2. 매물 전체 목록 조회 (Mapper ID: selectRoomList)
    List<RoomVO> selectRoomList(@Param("roomType") String roomType, @Param("sort") String sort);

    // 3. 매물 상세 조회 (Mapper ID: selectRoomDetail)
    RoomVO selectRoomDetail(int roomNo);

    // 4. 조회수 증가 (Mapper ID: increaseViewCount)
    void increaseViewCount(int roomNo);

    // 5. 매물 삭제 (Mapper ID: deleteRoom)
    void deleteRoom(int roomNo);

    void updateRoom(RoomVO vo);

    int countAllRooms();

    // 1. 찜 여부 확인 (있으면 1, 없으면 0)
    int checkWish(@Param("userNo") int userNo, @Param("roomNo") int roomNo);

    // 2. 찜 추가
    void addWish(@Param("userNo") int userNo, @Param("roomNo") int roomNo);

    // 3. 찜 삭제
    void removeWish(@Param("userNo") int userNo, @Param("roomNo") int roomNo);
}
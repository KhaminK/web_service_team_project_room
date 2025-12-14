package com.handong.web.room.dao;

import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public interface AdminDao {
    // 맵(Map) 형태로 {period='12월', count=5} 이런 데이터를 리스트로 반환
    List<Map<String, Object>> selectRecentUserStats();
    List<Map<String, Object>> selectRecentRoomStats();
}
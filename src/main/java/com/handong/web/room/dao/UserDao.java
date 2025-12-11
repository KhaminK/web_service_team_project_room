package com.handong.web.room.dao;

import com.handong.web.room.vo.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {
    // 회원가입
    void insertUser(UserVO vo);

    // 로그인
    UserVO loginUser(UserVO vo);

    // 아이디 중복 확인
    int checkStudentId(String studentId);
}
package com.handong.web.room.dao;

import com.handong.web.room.vo.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {

    // 1. 회원가입 (Mapper ID: insertUser)
    void insertUser(UserVO vo);

    // 2. 로그인 (Mapper ID: loginUser)
    UserVO loginUser(UserVO vo);

    // 3. 아이디 중복 체크 (선택 사항, Mapper ID: checkStudentId)
    int checkStudentId(String studentId);
}
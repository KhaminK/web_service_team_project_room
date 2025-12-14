package com.handong.web.room.dao;

import com.handong.web.room.vo.UserVO;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserDao {

    // 1. 회원가입 (일반 유저)
    void insertUser(UserVO vo);

    // 2. 로그인 (권한 정보 포함 조회)
    UserVO loginUser(UserVO vo);

    // 3. 아이디 중복 체크
    int checkStudentId(String studentId);

    // ▼▼▼ [관리자 기능 추가] ▼▼▼

    // 4. 전체 유저 목록 조회 (관리자 대시보드용)
    List<UserVO> selectAllUsers();

    // 5. 유저 강제 탈퇴 (관리자용)
    void deleteUser(int userNo);
    // 4. 프로필 이미지 업데이트
    void updateProfileImg(UserVO vo);

    // 아래 두 줄을 인터페이스 안에 추가하세요
    public void updateUser(UserVO vo);
    public UserVO getUser(int userNo);
}
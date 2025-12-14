package com.handong.web.room.service;

import com.handong.web.room.dao.UserDao;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    // 회원가입 처리
    public void signup(UserVO vo) {
        userDao.insertUser(vo);
    }

    // 로그인 처리
    public UserVO login(UserVO vo) {
        return userDao.loginUser(vo);
    }

    // 관리자용: 전체 유저 목록
    public List<UserVO> getAllUsers() {
        return userDao.selectAllUsers();
    }
    // 관리자용: 유저 삭제
    public void deleteUser(int userNo) {
        userDao.deleteUser(userNo);
    // 프로필 이미지 수정 (사진만 바꿀 때)
    public void updateProfileImg(UserVO vo) {
        userDao.updateProfileImg(vo);
    }

    // 회원 정보 전체 수정 (사진, 전화번호, 나이 등 포함)
    public void updateUser(UserVO vo) {
        userDao.updateUser(vo);
    }

    // 회원 정보 1개 가져오기 (수정 후 세션 갱신용)
    public UserVO getUser(int userNo) {
        return userDao.getUser(userNo);
    }
}
package com.handong.web.room.service;

import com.handong.web.room.dao.UserDao;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    // 회원가입 처리
    public void signup(UserVO vo) {
        userDao.insertUser(vo);
    }

    // 로그인 처리 (성공하면 세션에 정보 저장, 실패하면 null 리턴)
    public UserVO login(UserVO vo) {
        return userDao.loginUser(vo);
    }
}
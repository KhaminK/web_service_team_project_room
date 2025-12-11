package com.handong.web.room.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HanController {

    // 메인 페이지 (http://localhost:8080/)
    @RequestMapping("/")
    public String home() {
        return "home"; // views/home.jsp를 찾아감
    }

    // 상세 페이지 테스트용 (http://localhost:8080/room/detail)
    @RequestMapping("/room/detail")
    public String roomDetail() {
        return "room/roomDetail"; // views/room/roomDetail.jsp를 찾아감
    }
}
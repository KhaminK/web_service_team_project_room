package com.handong.web.room.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HanController {

    // 메인 페이지만 담당
    @RequestMapping("/")
    public String home() {
        return "home";
    }
}
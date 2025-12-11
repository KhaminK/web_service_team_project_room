package com.handong.web.room.controller;

import com.handong.web.room.service.UserService;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 1. 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "user/signup";
    }

    // 2. 회원가입 처리
    @PostMapping("/signup")
    public String signupProcess(UserVO vo) {
        userService.signup(vo);
        return "redirect:/user/login";
    }

    // 3. 로그인 페이지
    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    // 4. 로그인 처리
    @PostMapping("/login")
    public String loginProcess(UserVO vo, HttpSession session, RedirectAttributes rttr) {
        UserVO loginUser = userService.login(vo);
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return "redirect:/"; // 메인으로 이동
        } else {
            rttr.addAttribute("error", "true");
            return "redirect:/user/login";
        }
    }

    // 5. 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
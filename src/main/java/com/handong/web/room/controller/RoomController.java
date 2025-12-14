package com.handong.web.room.controller;

import com.handong.web.room.service.RoomService;
import com.handong.web.room.vo.RoomVO;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    // 1. 방 목록 페이지 (방 구하기 버튼 클릭 시)
    @GetMapping("/list")
    public String roomList(Model model) {
        List<RoomVO> list = roomService.getRoomList();
        model.addAttribute("roomList", list);
        return "room/roomList"; // views/room/roomList.jsp 이동
    }

    // 2. 방 내놓기 페이지 (로그인 체크)
    @GetMapping("/write")
    public String roomWritePage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/user/login"; // 로그인 안했으면 로그인 창으로
        }
        return "room/roomWrite";
    }

    // 3. 방 등록 처리 (DB 저장)
    @PostMapping("/write")
    public String roomWriteProcess(RoomVO vo, HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            vo.setWriterId(loginUser.getUserNo());
            roomService.addRoom(vo);
        }
        return "redirect:/room/list";
    }

    // 4. 상세 페이지
    @GetMapping("/detail")
    public String roomDetail(@RequestParam("id") int roomNo, Model model) {
        RoomVO room = roomService.getRoomDetail(roomNo);
        model.addAttribute("room", room);
        return "room/roomDetail";
    }

    // 5. 삭제 기능
    @GetMapping("/delete")
    public String deleteRoom(@RequestParam("id") int roomNo) {
        roomService.removeRoom(roomNo);
        return "redirect:/room/list";
    }
}
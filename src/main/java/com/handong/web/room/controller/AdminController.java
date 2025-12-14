package com.handong.web.room.controller;

import com.handong.web.room.dao.AdminDao;
import com.handong.web.room.service.RoomService;
import com.handong.web.room.service.UserService;
import com.handong.web.room.vo.RoomVO;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private AdminDao adminDao; // [추가] 차트 데이터용

    private boolean isAdmin(HttpSession session) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        return loginUser != null && "ADMIN".equals(loginUser.getRole());
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/";

        // 1. 기존 데이터 (목록 및 총계)
        List<UserVO> userList = userService.getAllUsers();
        List<RoomVO> roomList = roomService.getRoomList();
        model.addAttribute("userList", userList);
        model.addAttribute("roomList", roomList);
        model.addAttribute("totalUsers", userList.size());
        model.addAttribute("totalRooms", roomService.countRooms());

        // 2. [추가] 차트 데이터 가공 (List<Map> -> JSON 형태의 문자열)
        List<Map<String, Object>> userStats = adminDao.selectRecentUserStats();
        List<Map<String, Object>> roomStats = adminDao.selectRecentRoomStats();

        // 2-1. 회원 차트용 라벨/데이터 분리
        String userLabels = userStats.stream().map(m -> "'" + m.get("period") + "'").collect(Collectors.joining(","));
        String userCounts = userStats.stream().map(m -> String.valueOf(m.get("count"))).collect(Collectors.joining(","));

        // 2-2. 매물 차트용 라벨/데이터 분리
        String roomLabels = roomStats.stream().map(m -> "'" + m.get("period") + "'").collect(Collectors.joining(","));
        String roomCounts = roomStats.stream().map(m -> String.valueOf(m.get("count"))).collect(Collectors.joining(","));

        // 만약 데이터가 하나도 없으면 기본값 넣어주기 (차트 깨짐 방지)
        if (userLabels.isEmpty()) { userLabels = "'데이터 없음'"; userCounts = "0"; }
        if (roomLabels.isEmpty()) { roomLabels = "'데이터 없음'"; roomCounts = "0"; }

        model.addAttribute("userLabels", userLabels); // 예: '10월','11월','12월'
        model.addAttribute("userCounts", userCounts); // 예: 10, 5, 12
        model.addAttribute("roomLabels", roomLabels);
        model.addAttribute("roomCounts", roomCounts);

        return "admin/dashboard";
    }

    // (삭제 관련 메서드들은 그대로 유지...)
    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("id") int userNo, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        userService.deleteUser(userNo);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/room/delete")
    public String deleteRoom(@RequestParam("id") int roomNo, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/";
        roomService.removeRoom(roomNo);
        return "redirect:/admin/dashboard";
    }
}
package com.handong.web.room.controller;

import com.handong.web.room.service.RoomService;
import com.handong.web.room.vo.RoomVO;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/list")
    public String roomList(
            @RequestParam(value = "type", required = false, defaultValue = "all") String roomType,
            @RequestParam(value = "sort", required = false, defaultValue = "latest") String sort,
            Model model) {

        List<RoomVO> list = roomService.getRoomList(roomType, sort);

        model.addAttribute("roomList", list);
        model.addAttribute("currentType", roomType); // 현재 선택된 필터 유지용
        model.addAttribute("currentSort", sort);     // 현재 선택된 정렬 유지용

        return "room/roomList";
    }

    @GetMapping("/write")
    public String roomWritePage(HttpSession session) {
        if (session.getAttribute("loginUser") == null) return "redirect:/user/login";
        return "room/roomWrite";
    }

    @PostMapping("/write")
    public String roomWriteProcess(RoomVO vo,
                                   @RequestParam("photos") List<MultipartFile> photos,
                                   HttpSession session) throws IOException {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/user/login";

        String realPath = session.getServletContext().getRealPath("/resources/upload");
        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        for (int i = 0; i < photos.size(); i++) {
            MultipartFile file = photos.get(i);
            if (file.isEmpty()) continue;

            String originalFileName = file.getOriginalFilename();
            String savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;
            file.transferTo(new File(realPath, savedFileName));

            if (i == 0) vo.setFilename1(savedFileName);
            else if (i == 1) vo.setFilename2(savedFileName);
            else if (i == 2) vo.setFilename3(savedFileName);
        }

        vo.setWriterId(loginUser.getUserNo());
        roomService.addRoom(vo);

        return "redirect:/room/list";
    }

    @GetMapping("/detail")
    public String roomDetail(@RequestParam("id") int roomNo, Model model, HttpSession session) {
        RoomVO room = roomService.getRoomDetail(roomNo);
        model.addAttribute("room", room);

        // 로그인한 사용자인 경우, 찜 여부 확인
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        boolean isWished = false;

        if (loginUser != null) {
            isWished = roomService.isWished(loginUser.getUserNo(), roomNo);
        }

        model.addAttribute("isWished", isWished); // JSP로 전달

        return "room/roomDetail";
    }

    // ▼▼▼ [추가됨] 찜 토글 기능 (AJAX 요청 처리) ▼▼▼
    @ResponseBody
    @PostMapping("/like")
    public Map<String, Object> toggleLike(@RequestBody Map<String, Integer> params, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 1. 비로그인 처리
        if (loginUser == null) {
            result.put("status", "fail");
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        // 2. 파라미터 받기
        int roomNo = params.get("roomNo");
        int userNo = loginUser.getUserNo();

        // 3. 서비스 호출 (true:찜됨, false:해제됨)
        boolean liked = roomService.toggleWish(userNo, roomNo);

        result.put("status", "success");
        result.put("liked", liked);

        return result;
    }

    // ▼▼▼ [추가] 수정 페이지 이동 (GET) ▼▼▼
    @GetMapping("/edit")
    public String roomEditPage(@RequestParam("id") int roomNo, HttpSession session, Model model) {
        RoomVO room = roomService.getRoomDetail(roomNo);
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 비로그인이거나, 작성자가 아니면 수정 불가 (리스트로 튕겨냄)
        if (loginUser == null || room.getWriterId() != loginUser.getUserNo()) {
            return "redirect:/room/list";
        }

        model.addAttribute("room", room);
        return "room/roomEdit";
    }

    // ▼▼▼ [추가] 수정 처리 (POST) ▼▼▼
    @PostMapping("/edit")
    public String roomEditProcess(RoomVO vo,
                                  @RequestParam(value="photos", required=false) List<MultipartFile> photos,
                                  HttpSession session) throws IOException {

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/user/login";

        // 1. 기존 데이터 조회 (기존 파일명 유지를 위해)
        RoomVO oldRoom = roomService.getRoomDetail(vo.getRoomNo());

        // 작성자 본인 확인 (보안)
        if (oldRoom.getWriterId() != loginUser.getUserNo()) {
            return "redirect:/room/list";
        }

        // 2. 기본적으로 기존 파일명 유지 설정
        vo.setFilename1(oldRoom.getFilename1());
        vo.setFilename2(oldRoom.getFilename2());
        vo.setFilename3(oldRoom.getFilename3());

        // 3. 새 파일이 업로드 되었다면 덮어쓰기
        String realPath = session.getServletContext().getRealPath("/resources/upload");

        if (photos != null && !photos.isEmpty()) {
            for (int i = 0; i < photos.size(); i++) {
                MultipartFile file = photos.get(i);
                if (file.isEmpty()) continue; // 파일 없으면 스킵

                // 새 파일 저장
                String originalFileName = file.getOriginalFilename();
                String savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;
                file.transferTo(new File(realPath, savedFileName));

                // 인덱스에 맞춰 파일명 교체
                if (i == 0) vo.setFilename1(savedFileName);
                else if (i == 1) vo.setFilename2(savedFileName);
                else if (i == 2) vo.setFilename3(savedFileName);
            }
        }

        // 4. DB 업데이트 호출
        roomService.updateRoom(vo);

        return "redirect:/room/detail?id=" + vo.getRoomNo();
    }

    @GetMapping("/delete")
    public String deleteRoom(@RequestParam("id") int roomNo) {
        roomService.removeRoom(roomNo);
        return "redirect:/room/list";
    }
}
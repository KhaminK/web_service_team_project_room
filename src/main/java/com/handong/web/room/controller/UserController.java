package com.handong.web.room.controller;

import com.handong.web.room.service.RoomService;
import com.handong.web.room.service.UserService;
import com.handong.web.room.vo.RoomVO;
import com.handong.web.room.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoomService roomService;

    // 1. 회원가입 페이지
    @GetMapping("/signup")
    public String signupPage() {
        return "user/signup";
    }

    // 2. 회원가입 처리 (수정됨: 프로필 사진 업로드 기능 추가)
    // 2. 회원가입 처리 (수정됨: 알림창 띄우고 이동하기)
    @PostMapping("/signup")
    public void signupProcess(UserVO vo,
                              @RequestParam("file") MultipartFile file,
                              HttpSession session,
                              HttpServletResponse response) throws IOException {

        // 1. 파일 업로드 로직 (기존과 동일)
        if (file != null && !file.isEmpty()) {
            try {
                String path = session.getServletContext().getRealPath("/resources/upload");
                File dir = new File(path);
                if (!dir.exists()) dir.mkdirs();

                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                file.transferTo(new File(path, fileName));
                vo.setProfileImg(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // 2. 회원가입 시도 (DB 저장)
            userService.signup(vo);

            // 3. 성공 시: 알림창 띄우고 로그인 페이지로 이동
            out.println("<script>");
            out.println("alert('회원가입이 정상적으로 완료되었습니다.\\n로그인 페이지로 이동합니다.');");
            out.println("location.href='login';");
            out.println("</script>");

        } catch (DuplicateKeyException e) {
            // 4. 실패 시 (중복된 학번일 경우): 알림창 띄우고 뒤로가기
            out.println("<script>");
            out.println("alert('이미 가입된 학번(ID)입니다.\\n다른 학번을 사용하거나 로그인을 해주세요.');");
            out.println("history.back();"); // 이전 페이지(회원가입 폼)로 돌려보냄
            out.println("</script>");
        } catch (Exception e) {
            // 5. 그 외 알 수 없는 에러 처리
            e.printStackTrace();
            out.println("<script>");
            out.println("alert('회원가입 중 오류가 발생했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }

        out.flush();
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

    // 6. 마이페이지
    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        // 혹시 로그인이 풀렸거나, 주소창에 바로 치고 들어온 경우 대비
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/user/login";
        }
        // views/user/profile.jsp 로 이동
        return "user/profile";
    }

    // 7. 프로필 사진 업로드 처리
    @PostMapping("/updateProfileImage")
    public String updateProfileImage(HttpSession session,
                                     @RequestParam("file") MultipartFile file) {

        // 1. 현재 로그인한 사용자 정보 가져오기
        UserVO user = (UserVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login"; // 로그인 안 했으면 튕김

        // 2. 파일이 비어있지 않은 경우에만 처리
        if (!file.isEmpty()) {
            try {
                // 저장할 경로 설정 (webapp/resources/upload 폴더)
                String path = session.getServletContext().getRealPath("/resources/upload");

                // 폴더가 없으면 생성
                File dir = new File(path);
                if (!dir.exists()) dir.mkdirs();

                // 파일명 중복 방지를 위해 UUID 사용 (예: sd8f7s9_myphoto.jpg)
                String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

                // 실제 파일 저장
                file.transferTo(new File(path, fileName));

                // 3. DB 업데이트 (파일 이름 저장)
                user.setProfileImg(fileName);
                userService.updateProfileImg(user);

                // 4. 세션 정보 업데이트 (중요!)
                session.setAttribute("loginUser", user);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 처리가 끝나면 다시 프로필 페이지로 돌아감
        return "redirect:/user/profile";
    }

    @GetMapping("/edit")
    public String editForm() {
        // views/user/edit.jsp 로 이동
        return "user/edit";
    }

    @PostMapping("/update")
    public String updateUser(UserVO userVO,
                             @RequestParam("file") MultipartFile file,
                             HttpSession session,
                             HttpServletRequest request) {

        // 1. 세션에서 현재 로그인된 사용자 정보 가져오기 (기존 파일명 확인용)
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 2. 파일 저장 경로 설정 (webapp/resources/upload)
        String realPath = request.getSession().getServletContext().getRealPath("/resources/upload");

        // 디렉토리가 없으면 생성
        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        // 3. 새 파일이 업로드 되었는지 확인
        if (!file.isEmpty()) {
            String originalFileName = file.getOriginalFilename();
            // 파일명 중복 방지를 위해 UUID 사용
            String savedFileName = UUID.randomUUID().toString() + "_" + originalFileName;

            // ==========================================
            // [중요] 기존 파일 삭제 로직
            // ==========================================
            String oldFileName = loginUser.getProfileImg();
            if (oldFileName != null && !oldFileName.isEmpty()) {
                File oldFile = new File(realPath + "/" + oldFileName);
                if (oldFile.exists()) {
                    if (oldFile.delete()) {
                        System.out.println("기존 프로필 사진 삭제 성공: " + oldFileName);
                    } else {
                        System.out.println("기존 프로필 사진 삭제 실패");
                    }
                }
            }
            // ==========================================

            // 4. 새 파일 저장
            try {
                file.transferTo(new File(realPath + "/" + savedFileName));
                // VO에 새 파일명 세팅
                userVO.setProfileImg(savedFileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 새 파일이 없으면 기존 파일명 유지
            userVO.setProfileImg(loginUser.getProfileImg());
        }

        // 5. DB 업데이트 (Service 호출)
        // userVO에는 form에서 넘어온 phone, age, gender, language 등이 들어있음
        // PK인 userNo나 id는 loginUser에서 가져와서 세팅해야 안전함
        userVO.setUserNo(loginUser.getUserNo());
        userVO.setStudentId(loginUser.getStudentId()); // 학번 등 변경 불가 항목 유지

        userService.updateUser(userVO);

        // 6. 세션 정보 갱신 (중요: 그래야 수정 후 바로 반영됨)
        // DB에서 다시 조회해오는 것이 가장 확실함
        UserVO updatedUser = userService.getUser(loginUser.getUserNo());
        session.setAttribute("loginUser", updatedUser);

        return "redirect:/user/profile";
    }

    @GetMapping("/wishlist")
    public String wishlist(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/user/login";

        // 찜한 방 목록 가져오기 (Service에 메서드 추가 필요)
        List<RoomVO> wishList = userService.getWishList(loginUser.getUserNo());

        model.addAttribute("wishList", wishList);
        return "user/wishlist"; // 아래에서 만들 JSP 파일명
    }

    // UserController.java (또는 RoomController)

    @RequestMapping("/myrooms")
    public String myRooms(HttpSession session, Model model) {
        // 1. 로그인한 사용자 정보 가져오기
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");

        // 로그인이 안 되어 있다면 로그인 페이지로 튕겨내기
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        // 2. 이 사람이 쓴 방 목록 DB에서 가져오기
        List<RoomVO> myRoomList = roomService.getRoomsByWriter(loginUser.getUserNo());

        // 3. 화면(JSP)으로 리스트 전달하기
        model.addAttribute("myRoomList", myRoomList);

        // 4. JSP 페이지 열기
        return "user/myRooms"; // 파일 경로에 맞춰 수정 (views/user/myRooms.jsp 등)
    }

}
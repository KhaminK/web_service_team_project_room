package com.handong.web.room.vo;

import lombok.Data;
import java.util.Date;

@Data
public class UserVO {
    private int userNo;          // user_no (PK)
    private String studentId;    // student_id
    private String name;         // name
    private String phone;        // phone
    private String password;     // password
    private String gender;       // gender
    private int age;             // age
    private String language;     // language
    private boolean isAuth;      // is_auth (DB는 0/1이지만 자바는 boolean 사용 가능)
    private Date createdAt;      // created_at
    private String profileImg;   // profile_img
}
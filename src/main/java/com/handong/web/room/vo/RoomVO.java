package com.handong.web.room.vo;

import lombok.Data;
import java.util.Date;

@Data
public class RoomVO {
    private int roomNo;          // room_no (PK)
    private int writerId;        // writer_id (FK -> UserVO.userNo)
    private String title;        // title
    private String address;      // address
    private String addressDetail;// address_detail
    private int price;           // price
    private int deposit;         // deposit
    private String roomType;     // room_type
    private String busDistance;  // bus_distance
    private int conditionScore;  // condition_score
    private String content;      // content
    private int viewCount;       // view_count
    private String status;       // status
    private Date createdAt;      // created_at
    private String filename1;    //room_image
    private String filename2;
    private String filename3;
    private String writerName;   // 작성자 이름 (tb_user와 조인해서 가져올 예정)
    private String writerGender;
    private String writerPhone;
    private String writerProfileImg;
}
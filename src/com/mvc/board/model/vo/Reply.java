package com.mvc.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int rowNum;
	private int comment_Num;
	private String comment_Contents;
	private Date comment_EnrollTime;
	private String comment_Remove;
	private String comment_MemberId;
	private int comment_EnrollNum;
	private String comment_MemberNickname;
	private String post_Title;
	private String board_Name;
}

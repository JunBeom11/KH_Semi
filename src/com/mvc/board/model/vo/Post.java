package com.mvc.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Post {
	private int post_Num;
	private String post_Title;
	private String post_Content;
	private String post_File;
	private Date EnrollTime;
	private int post_Views;
	private char post_Remove;
	private String board_Num;
	private String post_MemberId;
	private String post_LocationNum;
}

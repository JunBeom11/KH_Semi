package com.mvc.member.model.vo;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private String memberId; 			//아이디
	private String memberPw;			//비밀번호
	private String memberNickName;		//닉네임
	private String memberEmail;			//이메일
	private String memberEnrollDate;	//가입일
	private String memberBirth;			//생년월일
	private String memberLocationNum;	//지역번호
	
}

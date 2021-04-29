package com.mvc.member.model.vo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private String member_Id; 			//아이디
	private String member_Pw;			//비밀번호
	private String member_NickName;		//닉네임
	private String member_Email;		//이메일
	private String member_EnrollDate;	//가입일
	private String member_Birth;		//생년월일
	private String member_LocationNum;	//지역번호
	private String member_role; 		//회원구분
	private String member_status; 		//탈퇴여부
	public int getNo() {
		// TODO Auto-generated method stub
		return 0;
	}
	
}

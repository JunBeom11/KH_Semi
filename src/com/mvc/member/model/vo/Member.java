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
	
	public Member(Member member) {
		this.member_Id = member.getMember_Id();
		this.member_Pw = member.getMember_Pw();
		this.member_NickName = member.getMember_NickName();
		this.member_Email = member.getMember_Email();
		this.member_EnrollDate = member.getMember_EnrollDate();
		this.member_Birth = member.getMember_Birth();
		this.member_LocationNum = member.getMember_LocationNum();
		this.member_role = member.getMember_role();
		this.member_status = member.getMember_status();
	}
	
}

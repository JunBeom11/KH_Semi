package com.mvc.member.model.service;

import java.sql.Connection;

import com.mvc.member.model.dao.MemberDAO;
import com.mvc.member.model.vo.Member;
import static com.mvc.common.jdbc.JDBCTemplate.*;

public class MemberService {
	private MemberDAO dao = new MemberDAO();
	
	public int enrollMember(Member member) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.enrollMember(connection, member);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public Member loginMember(String Member_Id, String Member_Pw) {
		Connection connection = getConnection();
		
		Member member = dao.loginMember(connection, Member_Id);
		
		close(connection);
		
		if(member != null && member.getMember_Pw().equals(Member_Pw)) {
			return member;
		}else {
			return null;
		}
		
	}

	public boolean isIdDuplicated(String userId) {
		Connection conn = getConnection();
		
		Member member = dao.loginMember(conn, userId);
		
		close(conn);
		
		return member != null;
	}

	public boolean isNickNameDuplicated(String userNickname) {
		Connection conn = getConnection();
		
		Member member = dao.checkNickname(conn, userNickname);
		
		close(conn);
		
		return member != null;
	}

}

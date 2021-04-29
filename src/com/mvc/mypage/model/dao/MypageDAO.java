package com.mvc.mypage.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mvc.member.model.vo.Member;
import static com.mvc.common.jdbc.JDBCTemplate.*;


public class MypageDAO {

	public int updateMypage(Connection connection, Member member, String loginId) {
		int result =0;
		PreparedStatement pstmt = null;
		String query = null;
		System.out.println(member+ loginId);
		try {
		query = "UPDATE MEMBER SET MEMBER_ID=?, MEMBER_PW=?, MEMBER_NICKNAME=?, MEMBER_EMAIL=?, MEMBER_BIRTH=?, MEMBER_LOCATIONNUM=? WHERE MEMBER_ID=?";
		pstmt = connection.prepareStatement(query);
		
		pstmt.setString(1, member.getMember_Id());
		pstmt.setString(2, member.getMember_Pw());
		pstmt.setString(3, member.getMember_NickName());
		pstmt.setString(4, member.getMember_Email());
		pstmt.setString(5, member.getMember_Birth());
		pstmt.setString(6, member.getMember_LocationNum());
		pstmt.setString(7, loginId);
	
		
		
		
		result = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Member checkNickname(Connection connection, String userNickname) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			query= "SELECT * FROM MEMBER WHERE MEMBER_NICKNAME=? ";
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, userNickname);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				member = new Member();
				member.setMember_Id(rs.getString("MEMBER_ID"));
				member.setMember_Pw(rs.getString("MEMBER_PW"));
				member.setMember_NickName(rs.getString("MEMBER_NICKNAME"));
				member.setMember_Email(rs.getString("MEMBER_EMAIL"));
				member.setMember_EnrollDate(rs.getString("MEMBER_ENROLLDATE"));
				member.setMember_Birth(rs.getString("MEMBER_BIRTH"));
				member.setMember_LocationNum(rs.getString("MEMBER_LOCATIONNUM"));
				member.setMember_role(rs.getString("MEMBER_ROLE"));
				member.setMember_status(rs.getString("MEMBER_STATUS"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			close(rs);
			close(pstmt);
		}
		return member;
	}

	

	public int updateStatus(Connection connection, String member_Id, String string) {
	
		int result =0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
		query = "UPDATE MEMBER SET MEMBER_STATUS=? WHERE MEMBER_ROLE='USER' AND MEMBER_Id=?";
		pstmt = connection.prepareStatement(query);
		
		pstmt.setString(1, "Y");
		pstmt.setString(2, member_Id);
		
		result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int enrollMember(Connection connection, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
			query = "INSERT INTO MEMBER VALUES(?,?,?,?,DEFAULT,?,?,DEFAULT,DEFAULT)";
			pstmt = connection.prepareStatement(query);
			System.out.println();
			
			pstmt.setString(1, member.getMember_Id());
			pstmt.setString(2, member.getMember_Pw());
			pstmt.setString(3, member.getMember_NickName());
			pstmt.setString(4, member.getMember_Email());
			//pstmt.setString(5, member.getMember_EnrollDate());
			pstmt.setString(5, member.getMember_Birth());
			pstmt.setString(6, member.getMember_LocationNum());
			//pstmt.setString(8, member.getMember_role());
			//pstmt.setString(9, member.getMember_status());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
}

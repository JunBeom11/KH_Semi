package com.mvc.mypage.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.mvc.board.model.vo.Post;
import com.mvc.board.model.vo.Reply;
import com.mvc.common.jdbc.JDBCTemplate;
import com.mvc.common.util.PageInfo;
import com.mvc.member.model.vo.Member;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class MypageDAO {

	public int updateMypage(Connection connection, Member member, String loginId) {
			int result =0;
			PreparedStatement pstmt = null;
			String query = null;
			System.out.println(member+ loginId);
			try {
				query = "UPDATE MEMBER SET MEMBER_PW=?, MEMBER_NICKNAME=?, MEMBER_EMAIL=?, MEMBER_BIRTH=?, MEMBER_LOCATIONNUM=? WHERE MEMBER_ID=?";
				pstmt = connection.prepareStatement(query);
	
				pstmt.setString(1, member.getMember_Pw());
				pstmt.setString(2, member.getMember_NickName());
				pstmt.setString(3, member.getMember_Email());
				pstmt.setString(4, member.getMember_Birth());
				pstmt.setString(5, member.getMember_LocationNum());
				pstmt.setString(6, loginId);
	
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

	public int getPostCount(Connection connection, String loginId, String role) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_MEMBERID=?";

		try {
			if(role.equals("USER")) {
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, loginId);
			}else {
				query = query.replace(" AND POST_MEMBERID=?", "");
				pstmt = connection.prepareStatement(query);
			}

			rs = pstmt.executeQuery();

			if(rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return count;
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

	public List<Post> findPostAll(Connection connection, PageInfo pageInfo, String loginId, String role) {
		List<Post> list= new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		query="SELECT *"
				+ "FROM ("
				+ "    SELECT ROWNUM AS RNUM,POST_NUM,POST_TITLE,POST_MEMBERID,POST_ENROLLTIME,POST_FILENAME,POST_FILERENAME,POST_VIEWS,POST_REMOVE,MEMBER_NICKNAME,POST_BOARDNUM"
				+ "    FROM ("
				+ "        SELECT * FROM POST P "
				+ "				LEFT JOIN MEMBER M ON(P.POST_MEMBERID=M.MEMBER_ID) "
				+ "			WHERE P.POST_REMOVE='N' AND P.POST_MEMBERID=? ORDER BY P.POST_NUM DESC"
				+ "    )"
				+ ")"
				+ "WHERE RNUM BETWEEN ? AND ?";

		try {

			if(role.equals("USER")) {
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, loginId);
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());
			}else {
				query = query.replace(" AND P.POST_MEMBERID=?", "");
				pstmt = connection.prepareStatement(query);
				pstmt.setInt(1, pageInfo.getStartList());
				pstmt.setInt(2, pageInfo.getEndList());
			}

			rs = pstmt.executeQuery();

			while(rs.next()) {
				Post post = new Post();

				post.setPost_Num(rs.getInt("POST_NUM"));
				post.setRowNum(rs.getInt("RNUM"));
				post.setPost_MemberId(rs.getString("POST_MEMBERID"));
				post.setPost_MemberNickname(rs.getString("MEMBER_NICKNAME"));
				post.setPost_Title(rs.getString("POST_TITLE"));
				post.setEnrollTime(rs.getDate("POST_ENROLLTIME"));
				post.setPost_FileName(rs.getString("POST_FILENAME"));
				post.setPost_FileReName(rs.getString("POST_FILERENAME"));
				post.setPost_Views(rs.getInt("POST_VIEWS"));
				post.setPost_Remove(rs.getString("POST_REMOVE"));
				post.setBoard_Num(rs.getString("POST_BOARDNUM"));

				list.add(post);
				System.out.println(post);
			}

			System.out.println(list);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return list;
	}

	public int getReplyCount(Connection connection, String loginId, String role) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		query = "SELECT COUNT(*) FROM COMMENTS WHERE COMMENT_REMOVE='N' AND COMMENT_MEMBERID=?";

		try {

			if(role.equals("USER")) {
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, loginId);
			}else {
				query = query.replace(" AND COMMENT_MEMBERID=?", "");
				pstmt = connection.prepareStatement(query);
			}

			rs = pstmt.executeQuery();

			if(rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return count;
	}

	public List<Reply> findReplyAll(Connection connection, PageInfo pageInfo, String loginId, String role) {
		List<Reply> replies = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String query = null;

		query = "SELECT * "
				+ "FROM ("
				+ "    SELECT ROWNUM RNUM, COMMENT_NUM, COMMENT_CONTENTS,COMMENT_ENROLLTIME,COMMENT_REMOVE,COMMENT_MEMBERID,COMMENT_ENROLLNUM,MEMBER_NICKNAME, POST_TITLE, BOARD_NAME"
				+ "    FROM ("
				+ "        SELECT * FROM COMMENTS C "
				+ "            LEFT JOIN MEMBER M ON (C.COMMENT_MEMBERID=M.MEMBER_ID)"
				+ "            LEFT JOIN POST P ON (C.COMMENT_ENROLLNUM=P.POST_NUM)"
				+ "			   LEFT JOIN BOARD B ON (P.POST_BOARDNUM=B.BOARD_ID)"
				+ "        WHERE C.COMMENT_REMOVE='N' AND C.COMMENT_MEMBERID=? ORDER BY C.COMMENT_NUM DESC"
				+ "    )"
				+ ") WHERE RNUM BETWEEN ? AND ?";

		try{
			if(role.equals("USER")) {
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, loginId);
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());
			}else {
				query = query.replace(" AND C.COMMENT_MEMBERID=?", "");
				pstmt = connection.prepareStatement(query);
				pstmt.setInt(1, pageInfo.getStartList());
				pstmt.setInt(2, pageInfo.getEndList());
			}

			rs = pstmt.executeQuery();

			while(rs.next())
			{
				Reply reply = new Reply();

				reply.setRowNum(rs.getInt("RNUM"));
				reply.setComment_Num(rs.getInt("COMMENT_NUM"));
				reply.setComment_EnrollNum(rs.getInt("COMMENT_ENROLLNUM"));
				reply.setComment_Contents(rs.getString("COMMENT_CONTENTS"));
				reply.setComment_MemberId(rs.getString("COMMENT_MEMBERID"));
				reply.setComment_MemberNickname(rs.getString("MEMBER_NICKNAME"));
				reply.setComment_EnrollTime(rs.getDate("COMMENT_ENROLLTIME"));
				reply.setPost_Title(rs.getString("POST_TITLE"));
				reply.setBoard_Name(rs.getString("BOARD_NAME"));
				replies.add(reply);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}

		return replies;
	}

	public int updateStatus(Connection connection, int[] numList, String type) {
		int result=0;
		PreparedStatement pstmt = null;
		
		String query="UPDATE POST SET POST_REMOVE='Y', POST_TITLE='삭제된 게시글입니다.', POST_CONTENTS='삭제된 게시글입니다.' WHERE POST_NUM = ?";
		if(type.equals("COMMENTS")) query = "UPDATE COMMENTS SET COMMENT_REMOVE='Y', COMMENT_CONTENTS='삭제된 댓글입니다.' WHERE COMMENT_NUM=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			for(int i=0;i<numList.length;i++) {				

				System.out.println(numList[i]);
				pstmt.setInt(1,numList[i]);

				pstmt.addBatch();
				pstmt.clearParameters();
			}
			
			result = pstmt.executeBatch().length;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}

		return result==numList.length?result:0;
	}
}

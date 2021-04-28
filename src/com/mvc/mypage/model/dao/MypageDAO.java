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

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class MypageDAO {

	public int getPostCount(Connection connection, String loginId) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		System.out.println("getpostCont"+loginId);
		
		try {
			query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_BoardNum='1' AND POST_MEMBERID=?";
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, loginId);
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

	public List<Post> findPostAll(Connection connection, PageInfo pageInfo, String loginId) {
		List<Post> list= new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		System.out.println("findall"+loginId);
		
		try {
				
			query="SELECT RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE " 
					+"FROM( " 
					+	    "SELECT ROWNUM AS RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS,  POST_REMOVE " 
					+	   " FROM( " 
					+"	        SELECT P.post_num, P.post_title, P.post_memberid, P.post_enrolltime, P.post_filename, P.post_filerename, P.post_views, P.post_Remove "
					+"	        FROM POST P JOIN MEMBER M ON(P.post_memberid=M.Member_Id) " 
					+"	        WHERE P.POST_REMOVE='N' AND P.POST_BOARDNUM='1' AND P.POST_MEMBERID=? ORDER BY P.POST_NUM DESC " 
					+"	        ) "
					+"	    ) "
					+"	WHERE RNUM BETWEEN ? and ?"; 
			
			pstmt = connection.prepareStatement(query);
			
			// ? 값을 set하는 구문
			pstmt.setString(1, loginId);
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Post post = new Post();
				
				post.setPost_Num(rs.getInt("POST_NUM"));
				post.setRowNum(rs.getInt("RNUM"));
				post.setPost_MemberId(rs.getString("POST_MEMBERID"));
				post.setPost_Title(rs.getString("POST_TITLE"));
				post.setEnrollTime(rs.getDate("POST_ENROLLTIME"));
				post.setPost_FileName(rs.getString("POST_FILENAME"));
				post.setPost_FileReName(rs.getString("POST_FILERENAME"));
				post.setPost_Views(rs.getInt("POST_VIEWS"));
				post.setPost_Remove(rs.getString("POST_REMOVE"));				
				
				list.add(post);
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

	public int getReplyCount(Connection connection, String loginId) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		System.out.println("getpostCont"+loginId);
		
		try {
			query = "SELECT COUNT(*) FROM COMMENTS WHERE COMMENT_REMOVE='N' AND COMMENT_MEMBERID=?";
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, loginId);
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

	public List<Reply> findReplyAll(Connection connection, PageInfo pageInfo, String loginId) {
		List<Reply> replies = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String query = null;
		
		try{
			query="SELECT comment_Num, comment_Contents, Comment_EnrollTime, Comment_Remove, comment_MemberId, comment_EnrollNum "
				+	" FROM COMMENTS "
				+ 	" WHERE COMMENT_REMOVE='N' AND COMMENT_MEMBERID=? "
				+	" ORDER BY COMMENT_NUM DESC ";
			
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, loginId);
			rs = pstmt.executeQuery();

			while(rs.next())
			{
				Reply reply = new Reply();
				
				reply.setComment_Num(rs.getInt("COMMENT_NUM"));
				reply.setComment_EnrollNum(rs.getInt("COMMENT_ENROLLNUM"));
				reply.setComment_Contents(rs.getString("COMMENT_CONTENTS"));
				reply.setComment_MemberId(rs.getString("COMMENT_MEMBERID"));
				reply.setComment_EnrollTime(rs.getDate("COMMENT_ENROLLTIME"));
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

}

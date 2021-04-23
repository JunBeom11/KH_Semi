package com.mvc.board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mvc.board.model.vo.Post;
import com.mvc.board.model.vo.Reply;
import com.mvc.common.jdbc.JDBCTemplate;
import com.mvc.common.util.PageInfo;

public class BoardDAO {

	public int getBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N'";
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);			
		}

		return count;
	}

	public List<Post> findAll(Connection connection, PageInfo pageInfo) {
		List<Post> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try
		{
			query="SELECT RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE " 
					+"FROM( " 
					+	    "SELECT ROWNUM AS RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS,  POST_REMOVE " 
					+	   " FROM( " 
					+"	        SELECT P.post_num, P.post_title, P.post_memberid, P.post_enrolltime, P.post_filename, P.post_filerename, P.post_views, P.post_Remove "
					+"	        FROM POST P JOIN MEMBER M ON(P.post_memberid=M.Member_Id) " 
					+"	        WHERE P.POST_REMOVE='N' ORDER BY P.POST_NUM DESC " 
					+"	        ) "
					+"	    ) "
					+"	WHERE RNUM BETWEEN ? and ? "; 
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			rs=pstmt.executeQuery();
			

			while(rs.next())
			{
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
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	public int insertPost(Connection connection, Post post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		query = "INSERT INTO POST VALUES(SEQ_BOARD_NO.NEXTVAL,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,'1',?,'1')";
		try {
			pstmt = connection.prepareStatement(query);
			
			System.out.println(post);
			pstmt.setString(1, post.getPost_Title());
			pstmt.setString(2, post.getPost_Content());
			pstmt.setString(3, post.getPost_FileName());
			pstmt.setString(4, post.getPost_FileReName());
			pstmt.setString(5, post.getPost_MemberId());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		
		return result;
	}

	public Post findpostbyNo(Connection connection, int post_num) {
		Post post=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query = null;

		try {
			query =
					"SELECT ROWNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE, POST_CONTENTS FROM POST "
					+ "WHERE POST_REMOVE='N' AND POST_NUM=? ";
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, post_num);

			rs=pstmt.executeQuery();

			if(rs.next())
			{
				post = new Post();
				post.setRowNum(rs.getInt("ROWNUM"));
				post.setPost_Num(rs.getInt("POST_NUM"));
				post.setPost_Title(rs.getString("POST_TITLE"));
				post.setPost_MemberId(rs.getString("POST_MEMBERID"));
				post.setEnrollTime(rs.getDate("POST_ENROLLTIME"));
				post.setPost_FileName(rs.getString("POST_FILENAME"));
				post.setPost_FileReName(rs.getString("POST_FILERENAME"));
				post.setPost_Views(rs.getInt("POST_VIEWS"));
				post.setPost_Remove(rs.getString("POST_REMOVE"));
				post.setPost_Content(rs.getString("POST_CONTENTS"));
				post.setReplies(this.getRepliesByNo(connection, post_num));
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		finally
		{
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}

		
		return post;
	}

	public int updateReadCount(Connection connection, Post post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query=null;
		
		query = "UPDATE POST SET POST_VIEWS=? WHERE POST_NUM=?";
		try {
			pstmt = connection.prepareStatement(query);
			
			post.setPost_Views(post.getPost_Views()+1);
			
			pstmt.setInt(1, post.getPost_Views());
			pstmt.setInt(2, post.getPost_Num());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally
		{
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	
	}
	
	public List<Reply> getRepliesByNo(Connection connection, int post_num)
	{
		List<Reply> replies = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String query = null;
		
		try{
			System.out.println(post_num);
			System.out.println(pstmt);
			System.out.println(rs);
			System.out.println(query);
			
			query="SELECT comment_Num, comment_Contents, Comment_EnrollTime, Comment_Remove, comment_MemberId, comment_EnrollNum "
				+	" FROM COMMENTS "
				+ 	" WHERE COMMENT_REMOVE='N' AND Comment_ENROLLNUM=? "
				+	" ORDER BY COMMENT_NUM DESC ";
			
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, post_num);
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

	public int insertReply(Connection connection, Reply reply) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
			query = "INSERT INTO COMMENTS VALUES(SEQ_REPLY_NO.NEXTVAL, ?, DEFAULT, DEFAULT, ?, ?)";
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, reply.getComment_Contents());
			pstmt.setString(2, reply.getComment_MemberId());
			pstmt.setInt(3, reply.getComment_EnrollNum());
			
			result = pstmt.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	

}

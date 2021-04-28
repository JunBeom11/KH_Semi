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

	//뉴스
	public int getBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_BoardNum='1' ";
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
			query="SELECT RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE, POST_MEMBERNICKNAME " 
					+"FROM( " 
					+	    "SELECT ROWNUM AS RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS,  POST_REMOVE, POST_MEMBERNICKNAME " 
					+	   " FROM( " 
					+"	        SELECT P.post_num, P.post_title, P.post_memberid, P.post_enrolltime, P.post_filename, P.post_filerename, P.post_views, P.post_Remove, P.post_membernickname "
					+"	        FROM POST P JOIN MEMBER M ON(P.post_memberid=M.Member_Id) " 
					+"	        WHERE P.POST_REMOVE='N' AND P.POST_BOARDNUM='1' ORDER BY P.POST_NUM DESC " 
					+"	        ) "
					+"	    ) "
					+"	WHERE RNUM BETWEEN ? and ?"; 
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
				post.setPost_MemberNickname(rs.getString("POST_MEMBERNICKNAME"));
				
				
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
		
		query = "INSERT INTO POST VALUES(SEQ_BOARD_NO.NEXTVAL,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,'1',?,'1',?)";
		try {
			pstmt = connection.prepareStatement(query);
			
			System.out.println(post);
			pstmt.setString(1, post.getPost_Title());
			pstmt.setString(2, post.getPost_Content());
			pstmt.setString(3, post.getPost_FileName());
			pstmt.setString(4, post.getPost_FileReName());
			pstmt.setString(5, post.getPost_MemberId());
			pstmt.setString(6, post.getPost_MemberNickname());
			
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
					"SELECT ROWNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE, POST_CONTENTS, POST_BOARDNUM, POST_MEMBERNICKNAME FROM POST "
					+ "WHERE POST_REMOVE='N' AND POST_NUM=? AND POST_BOARDNUM =1 ";
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, post_num);

			rs=pstmt.executeQuery();

			if(rs.next())
			{
				post = new Post();
				post.setBoard_Num(rs.getString("POST_BOARDNUM"));
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
				post.setPost_MemberNickname(rs.getString("POST_MEMBERNICKNAME"));
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
			
			query="SELECT comment_Num, comment_Contents, Comment_EnrollTime, Comment_Remove, comment_MemberId, comment_EnrollNum, comment_MemberNickname "
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
				reply.setComment_MemberNickname(rs.getString("COMMENT_MEMBERNICKNAME"));
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
			query = "INSERT INTO COMMENTS VALUES(SEQ_CNO.NEXTVAL, ?, DEFAULT, DEFAULT, ?, ?, ?)";
			pstmt = connection.prepareStatement(query);
		
			pstmt.setString(1, reply.getComment_Contents());
			pstmt.setString(2, reply.getComment_MemberId());
			pstmt.setInt(3, reply.getComment_EnrollNum());
			pstmt.setString(4, reply.getComment_MemberNickname());
			result = pstmt.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	/////////////////////////////////////////////////////////////////////
	//커뮤니티
	public int getBoardCount2(Connection connection, String country) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			if(country!=null)
			{
				query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_BoardNum='2' AND POST_LOCATIONNUM=? ";
				pstmt = connection.prepareStatement(query);
				switch(country)
				{
				case "서울": pstmt.setString(1, "1");
					break;
				case "경기": pstmt.setString(1, "2");
					break;
				case "충청": pstmt.setString(1, "3");
					break;
				case "경상": pstmt.setString(1, "4");
					break;
				case "전라": pstmt.setString(1, "5");
					break;
				case "강원": pstmt.setString(1, "6");
					break;
				default :
					break;
				}
			}
			else
			{
				query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_BoardNum='2' ";
				pstmt = connection.prepareStatement(query);
			}
			
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

	public List<Post> findAll2(Connection connection, PageInfo pageInfo, String country) {
		List<Post> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		//스트링빌더
		query="SELECT RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE, POST_BOARDNUM ,POST_LOCATIONNUM, POST_MEMBERNICKNAME " 
				+" FROM( " 
				+" SELECT ROWNUM AS RNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS,  POST_REMOVE, POST_BOARDNUM, POST_LOCATIONNUM, POST_MEMBERNICKNAME " 
				+" FROM( " 
				+"	        SELECT P.post_num, P.post_title, P.post_memberid, P.post_enrolltime, P.post_filename, P.post_filerename, P.post_views, P.post_Remove, P.post_BOARDNUM, P.POST_LOCATIONNUM, P.POST_MEMBERNICKNAME "
				+"	        FROM POST P JOIN MEMBER M ON(P.post_memberid=M.Member_Id) " 
				+"	        WHERE P.POST_REMOVE='N' AND P.POST_BOARDNUM='2' " ;
		if(country!=null)
		{
			query+="AND POST_LOCATIONNUM = ? ";
		}
		query+=	"	ORDER BY P.POST_NUM DESC " 
				+"	        ) "
				+"	    ) "
				+"	WHERE RNUM BETWEEN ? and ? AND POST_BOARDNUM='2' ";
		if(country!=null)
		{
			query+= "AND POST_LOCATIONNUM = ? ";
			System.out.println(country);
		}
		
		try
		{
			pstmt = connection.prepareStatement(query);
			
			if(country==null)
			{
				pstmt.setInt(1, pageInfo.getStartList());
				pstmt.setInt(2, pageInfo.getEndList());
			}
			else
			{
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());

						
				switch(country)
				{
				case "서울": pstmt.setString(1, "1"); pstmt.setString(4, "1");
					break;
				case "경기": pstmt.setString(1, "2"); pstmt.setString(4, "2");
					break;
				case "충청": pstmt.setString(1, "3"); pstmt.setString(4, "3");
					break;
				case "경상": pstmt.setString(1, "4"); pstmt.setString(4, "4");
					break;
				case "전라": pstmt.setString(1, "5"); pstmt.setString(4, "5");
					break;
				case "강원": pstmt.setString(1, "6"); pstmt.setString(4, "6");
					break;
				default : System.out.println("없음");
					break;
				}
			}
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
				post.setPost_LocationNum(rs.getString("POST_LOCATIONNUM"));
				post.setPost_MemberNickname(rs.getString("POST_MEMBERNICKNAME"));
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

	public int insertPost2(Connection connection, Post post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		
		try {
			query = "INSERT INTO POST VALUES(SEQ_BOARD_NO.NEXTVAL,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,'2',?,?,?) ";
			pstmt = connection.prepareStatement(query);
			
			System.out.println(post);
			pstmt.setString(1, post.getPost_Title());
			pstmt.setString(2, post.getPost_Content());
			pstmt.setString(3, post.getPost_FileName());
			pstmt.setString(4, post.getPost_FileReName());
			pstmt.setString(5, post.getPost_MemberId());
			pstmt.setString(6, post.getPost_LocationNum());
			pstmt.setString(7, post.getPost_MemberNickname());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		
		return result;
	}

	public Post findpostbyNo2(Connection connection, int post_num) {
		Post post=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String query = null;

		try {
			query =
					"SELECT ROWNUM, POST_NUM, POST_TITLE, POST_MEMBERID, POST_ENROLLTIME, POST_FILENAME, POST_FILERENAME, POST_VIEWS, POST_REMOVE, POST_CONTENTS, POST_BOARDNUM, POST_MEMBERNICKNAME FROM POST "
					+ "WHERE POST_REMOVE='N' AND POST_NUM=? AND POST_BOARDNUM ='2' ";
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, post_num);

			rs=pstmt.executeQuery();

			if(rs.next())
			{
				post = new Post();
				post.setBoard_Num(rs.getString("POST_BOARDNUM"));
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
				post.setPost_MemberNickname(rs.getString("POST_MEMBERNICKNAME"));
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

	public int updateReadCount2(Connection connection, Post post) {
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
	
	public List<Reply> getRepliesByNo2(Connection connection, int post_num)
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
			
			query="SELECT comment_Num, comment_Contents, Comment_EnrollTime, Comment_Remove, comment_MemberId, comment_EnrollNum, comment_MemberNickName "
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
				reply.setComment_MemberNickname(rs.getString("COMMENT_MEMBERNICKNAME"));
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

	public int insertReply2(Connection connection, Reply reply) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
			query = "INSERT INTO COMMENTS VALUES(SEQ_CNO.NEXTVAL, ?, DEFAULT, DEFAULT, ?, ?, ?)";
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, reply.getComment_Contents());
			pstmt.setString(2, reply.getComment_MemberId());
			pstmt.setInt(3, reply.getComment_EnrollNum());
			pstmt.setString(4, reply.getComment_MemberNickname());
			
			result = pstmt.executeUpdate();	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int getBoardCount2(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			query = "SELECT COUNT(*) FROM POST WHERE POST_REMOVE='N' AND POST_BoardNum='2' ";
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

	public int updateStatus(Connection connection, int boardNo, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query=null;
		
		try {
			query="UPDATE POST SET POST_REMOVE=? WHERE POST_NUM=? " ;
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1,status);
			pstmt.setInt(2,boardNo);			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int updatePost2(Connection connection, Post post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
			query = "UPDATE POST SET POST_TITLE=?, POST_CONTENTS=?, POST_FILENAME=?, POST_FILERENAME=?, POST_LOCATIONNUM=?, POST_MEMBERNICKNAME=? WHERE POST_NUM=?";
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, post.getPost_Title());
			pstmt.setString(2, post.getPost_Content());
			pstmt.setString(3, post.getPost_FileName());
			pstmt.setString(4, post.getPost_FileReName());
			pstmt.setString(5, post.getPost_LocationNum());
			pstmt.setString(6, post.getPost_MemberNickname());
			pstmt.setInt(7, post.getPost_Num());
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int updatePost(Connection connection, Post post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = null;
		
		try {
			query = "UPDATE POST SET POST_TITLE=?, POST_CONTENTS=?, POST_FILENAME=?, POST_FILERENAME=?, POST_MEMBERNICKNAME=? WHERE POST_NUM=?";
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, post.getPost_Title());
			pstmt.setString(2, post.getPost_Content());
			pstmt.setString(3, post.getPost_FileName());
			pstmt.setString(4, post.getPost_FileReName());
			pstmt.setString(5, post.getPost_MemberNickname());
			pstmt.setInt(6, post.getPost_Num());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	
}

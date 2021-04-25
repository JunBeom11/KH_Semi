package com.mvc.board.model.service;

import java.sql.Connection;
import java.util.List;

import com.mvc.board.model.dao.BoardDAO;
import com.mvc.board.model.vo.Post;
import com.mvc.board.model.vo.Reply;
import com.mvc.common.util.PageInfo;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class BoardService {
	private BoardDAO dao= new BoardDAO();
	/////////////////////////////뉴스
	public int getBoardCount() {
		
		Connection connection = getConnection();
		int count = dao.getBoardCount(connection);
		
		close(connection);
		return count;
	}
	
	public List<Post> getBoardList(PageInfo pageInfo)
	{
		Connection connection = getConnection();
		List<Post> list = dao.findAll(connection, pageInfo);
		close(connection);
		return list;
	}

	public int save(Post post) {
		int result = 0;
		Connection connection = getConnection();
		
		if(post.getPost_Num() != 0) {
		//	result = dao.updateMember(connection, post);
		} else {
			result = dao.insertPost(connection, post);
		}
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public Post findPostbyNo(int post_num, boolean hasRead) {
		Post post=null;
		Connection connection =getConnection();
		
		post = dao.findpostbyNo(connection, post_num);
	
		if(post != null && !hasRead)
		{
			int result = dao.updateReadCount(connection,post);
			if(result>0)
			{
				commit(connection);
			}
			else
			{
				rollback(connection);
			}
		}
		close(connection);
		return post;
	}

	public int saveReply(Reply reply) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.insertReply(connection, reply);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}
	//////////////////커뮤니티
public int getBoardCount2() {
		
		Connection connection = getConnection();
		int count = dao.getBoardCount2(connection);
		
		close(connection);
		return count;
	}
	
	public List<Post> getBoardList2(PageInfo pageInfo, String country)
	{
		Connection connection = getConnection();
		List<Post> list = dao.findAll2(connection, pageInfo, country);
		close(connection);
		return list;
	}

	public int save2(Post post) {
		int result = 0;
		Connection connection = getConnection();
		
		if(post.getPost_Num() != 0) {
		//	result = dao.updateMember(connection, post);
		} else {
			result = dao.insertPost2(connection, post);
		}
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public Post findPostbyNo2(int post_num, boolean hasRead) {
		Post post=null;
		Connection connection =getConnection();
		
		post = dao.findpostbyNo2(connection, post_num);
	
		if(post != null && !hasRead)
		{
			int result = dao.updateReadCount2(connection,post);
			if(result>0)
			{
				commit(connection);
			}
			else
			{
				rollback(connection);
			}
		}
		close(connection);
		return post;
	}

	public int saveReply2(Reply reply) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.insertReply2(connection, reply);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

}

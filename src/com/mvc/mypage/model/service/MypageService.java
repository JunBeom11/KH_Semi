package com.mvc.mypage.model.service;

import java.sql.Connection;
import java.util.List;

import com.mvc.board.model.vo.Post;
import com.mvc.common.util.PageInfo;
import com.mvc.mypage.model.dao.MypageDAO;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class MypageService {
	
	private MypageDAO dao = new MypageDAO();

	public int updatePassword(String member_Id, String userPwd) {
		
		return 0;
	}

	public int getPostCount(String loginId) {
		Connection connection = getConnection();
		int count = dao.getPostCount(connection, loginId);
		
		close(connection);
		
		return count;
	}

	public List<Post> getPostList(PageInfo pageInfo, String loginId) {
		Connection connection = getConnection();
		List<Post> list = dao.findAll(connection, pageInfo, loginId);
		
		close(connection);
		
		return list;
	}

}

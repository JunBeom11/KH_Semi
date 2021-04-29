package com.mvc.mypage.model.service;

import java.sql.Connection;
import java.util.List;

import com.mvc.board.model.vo.Post;
import com.mvc.board.model.vo.Reply;
import com.mvc.common.util.PageInfo;
import com.mvc.member.model.vo.Member;
import com.mvc.mypage.model.dao.MypageDAO;

import static com.mvc.common.jdbc.JDBCTemplate.close;
import static com.mvc.common.jdbc.JDBCTemplate.commit;
import static com.mvc.common.jdbc.JDBCTemplate.getConnection;
import static com.mvc.common.jdbc.JDBCTemplate.rollback;
import static com.mvc.common.jdbc.JDBCTemplate.*;

public class MypageService {

	private MypageDAO dao = new MypageDAO();

public class MypageService {
     private MypageDAO dao = new MypageDAO();

     public int updateMypage(Member member, String loginId) {
		Connection connection = getConnection();
		int result = dao.updateMypage(connection, member, loginId);


		if(result > 0) {
			commit(connection);
		}else {
			rollback(connection);
		}

		close(connection);

    	 return result;

     }
     public boolean isNickNameDuplicated(String userNickname) {
    	 Connection conn = getConnection();

    	 Member member = dao.checkNickname(conn, userNickname);

    	 close(conn);
    	 return member != null;
     }

     public int save(Member member,String loginId) {
 		int result = 0;
 		Connection connection = getConnection();

 		if(member.getNo() != 0) {
 			result = dao.updateMypage(connection, member, loginId);
 		} else {
 			result = dao.enrollMember(connection, member);
 		}

 		if(result > 0) {
 			commit(connection);
 		} else {
 			rollback(connection);
 		}

 		close(connection);

 		return result;
 	}

	public int delete(String member_Id) {
		Connection connection = getConnection();
		int result = dao.updateStatus(connection,member_Id,"Y");

		if(result >0) {
			commit(connection);
		}else {
			rollback(connection);
		}

		close(connection);

		return result;
	}

	public int getPostCount(String loginId, String role) {
		Connection connection = getConnection();
		int count = dao.getPostCount(connection, loginId, role);

		close(connection);

		return count;
	}

	public List<Post> getPostList(PageInfo pageInfo, String loginId, String role) {
		Connection connection = getConnection();
		List<Post> list = dao.findPostAll(connection, pageInfo, loginId, role);

		close(connection);

		return list;
	}

	public int getReplyCount(String loginId, String role) {
		Connection connection = getConnection();
		int count = dao.getReplyCount(connection, loginId, role);

		close(connection);

		return count;
	}

	public List<Reply> getReplyList(PageInfo pageInfo, String loginId, String role) {
		Connection connection = getConnection();
		List<Reply> list = dao.findReplyAll(connection, pageInfo, loginId, role);

		close(connection);

		return list;
	}

	public int deleteList(int[] numList, String type) {
		int result = 0;
		Connection connection = getConnection();

		result = dao.updateStatus(connection, numList, type);

		if(result>0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		close(connection);
		return result;
	}

}

package com.mvc.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.mypage.model.service.MypageService;

@WebServlet("/mypage/myreply/delete")
public class MyReplyDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MypageService service = new MypageService();
	
    public MyReplyDeleteServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] ReplyStringList = request.getParameterValues("checkReply");
		
		int[] ReplyList = new int[ReplyStringList.length];
		
		for(int i=0;i<ReplyStringList.length;i++) {
			ReplyList[i] = Integer.parseInt(ReplyStringList[i]);
		}
		
		int result = service.deleteList(ReplyList, "COMMENTS");
		
		if(result>0) {
			request.setAttribute("msg", "댓글이 삭제되었습니다.");
			request.setAttribute("location", "/mypage/myreply");
		} else {
			request.setAttribute("msg", "댓글 삭제에 실패했습니다.");
			request.setAttribute("location", "/mypage/myreply");
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
		//response.sendRedirect("/inCorona/mypage/myreply/list");
	}

}

package com.mvc.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.mypage.model.service.MypageService;

@WebServlet("/mypage/mypost/delete")
public class MyPostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MypageService service = new MypageService();

	public MyPostDeleteServlet() {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] PostStringList = request.getParameterValues("checkPost");
		
		int[] PostList = new int[PostStringList.length];
		
		for(int i=0;i<PostStringList.length;i++) {
			PostList[i] = Integer.parseInt(PostStringList[i]);
		}
		
		int result = service.deleteList(PostList, "COMMENT");
		
		if(result>0) {
			request.setAttribute("msg", "게시글이 삭제되었습니다.");
			request.setAttribute("location", "/mypage/mypost");
		} else {
			request.setAttribute("msg", "게시글 삭제에 실패했습니다.");
			request.setAttribute("location", "/mypage/mypost");
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

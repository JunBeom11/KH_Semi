package com.mvc.mypage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.model.service.BoardService;

@WebServlet("/mypage/mypost/delete")
public class PostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BoardService service = new BoardService();

	public PostDeleteServlet() {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("delete servlet");

		String[] deletePostList = request.getParameterValues("checkPost");
		
		for(String post_Num : deletePostList) { service.delete(Integer.parseInt(post_Num)); }

		response.sendRedirect("/inCorona/mypage/mypost/list");
	}

}

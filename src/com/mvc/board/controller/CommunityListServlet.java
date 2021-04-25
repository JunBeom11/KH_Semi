package com.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.model.service.BoardService;
import com.mvc.board.model.vo.Post;
import com.mvc.common.util.PageInfo;

@WebServlet("/board/community")
public class CommunityListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service = new BoardService();  

    public CommunityListServlet() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page=0;
		int listCount=0;
		PageInfo pageInfo=null;
		List<Post> list=null;
		String country = request.getParameter("country");

		try
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		catch(NumberFormatException e)
		{
			page = 1; 
		}
		
		listCount = service.getBoardCount2();
		pageInfo = new PageInfo(page,10,listCount,10);
		list = service.getBoardList2(pageInfo,country);
		
		request.setAttribute("list", list);
		request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/board/community.jsp").forward(request, response);
	}



}

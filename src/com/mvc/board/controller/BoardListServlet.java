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

@WebServlet("/board/news")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service = new BoardService();

    public BoardListServlet() {

    }

    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page=0;
		int listCount=0;
		try
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		catch(NumberFormatException e)
		{
			page = 1; 
		}
		listCount = service.getBoardCount();
		PageInfo pageInfo = new PageInfo(page,10,listCount,10);
		List<Post> list = service.getBoardList(pageInfo);
		
		System.out.println(list);
		
		request.setAttribute("list", list);
		request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/board/news.jsp").forward(request, response);
	}

}

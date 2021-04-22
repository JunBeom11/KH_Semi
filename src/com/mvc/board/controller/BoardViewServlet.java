package com.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.model.service.BoardService;
import com.mvc.board.model.vo.Post;


@WebServlet("/board/newsview")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private BoardService service = new BoardService();
    public BoardViewServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Post post =null;
		int post_num = Integer.parseInt(request.getParameter("boardNo"));
		
		
		Cookie[] cookies = request.getCookies();
		String boardHistory = "";
		boolean hasRead = false;
		
		if(cookies != null)
		{
			String name=null;
			String value=null;
			for(Cookie cookie : cookies)
			{
				name = cookie.getName();
				value  = cookie.getValue();
				
				if("boardHistory".equals(name))
				{
					boardHistory = value;
					if(boardHistory.contains("|"+post_num+"|"))
					{
						hasRead =true;
						break;
					}
				}
			}
		}
		if(!hasRead)
		{
			Cookie cookie = new Cookie("boardHistory", boardHistory+"|"+post_num+"|");
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
		}
		
		post = service.findPostbyNo(post_num, hasRead);
		request.setAttribute("post",post);
		request.getRequestDispatcher("/views/board/newsview.jsp").forward(request, response);
	}

}

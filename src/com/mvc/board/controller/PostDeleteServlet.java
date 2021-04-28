package com.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.model.service.BoardService;


@WebServlet("/board/erase")
public class PostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private BoardService service = new BoardService();

    public PostDeleteServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo=Integer.parseInt(request.getParameter("boardNo"));
		String b_num = request.getParameter("bNum");
		int result = service.delete(boardNo);
		if(b_num.equals("1"))
		{
			if(result>0)
			{
				request.setAttribute("msg", "게시글 삭제 성공");
				request.setAttribute("location", "/board/news");		
			}
			else
			{
				request.setAttribute("msg", "게시글 삭제 실패");
				request.setAttribute("location", "/board/news");
			}
		}
		else
		{
			if(result>0)
			{
				request.setAttribute("msg", "게시글 삭제 성공");
				request.setAttribute("location", "/board/community");		
			}
			else
			{
				request.setAttribute("msg", "게시글 삭제 실패");
				request.setAttribute("location", "/board/community");
			}
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

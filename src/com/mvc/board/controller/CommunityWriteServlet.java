package com.mvc.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.board.model.service.BoardService;
import com.mvc.board.model.vo.Post;
import com.mvc.common.util.FileRename;
import com.mvc.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;


@WebServlet("/board/communitywrite")
public class CommunityWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService service = new BoardService();
    public CommunityWriteServlet() {

    }


    @Override
 	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     	HttpSession session=request.getSession(false);
 		request.getRequestDispatcher("/views/board/communitywrite.jsp").forward(request,response);
 		//System.out.println("오류"); //아니 싯팔 왜 안되던게 syso넣으니까 됨?
 	}

     @Override
 	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     	
     	String path = getServletContext().getRealPath("/resource/upload/board");
     	int maxSize = 10485760;
     	String encoding = "UTF-8";
     	MultipartRequest mr = new MultipartRequest(request,path,maxSize,encoding,new FileRename());

     	String title = mr.getParameter("title");
 		String writer = mr.getParameter("writer");//asdasd12
 		String content = mr.getParameter("content");
 		content = content.replaceAll("\n", "<br>");
 		System.out.println(content);
 		String fileName= mr.getFilesystemName("upfile");
 		String upfileName = mr.getOriginalFileName("upfile");
 		HttpSession session = request.getSession(false);
 		Member loginMember = session != null?(Member)session.getAttribute("loginMember"):null;

 		if(loginMember != null)
 		{
 			if(loginMember.getMember_Id().equals(writer))
 			{
 				Post post = new Post();
 				
 				post.setPost_MemberId(writer);
 				post.setPost_Title(title);
 				post.setPost_Content(content);
 				post.setPost_FileName(upfileName);
 				post.setPost_FileReName(fileName);
 				
 				int result = service.save2(post);
 				
 				if(result>0)
 				{
 					request.setAttribute("msg","게시글 등록 성공");
 					request.setAttribute("location","/board/community");
 				}
 				else
 				{
 					request.setAttribute("msg","게시글 등록 실패");
 					request.setAttribute("location", "/board/community");
 				}
 			}
 			else
 			{
 				request.setAttribute("msg", "잘못된 접근");
 				request.setAttribute("location","/board/community");
 			}
 		}
 		else
 		{
 			request.setAttribute("msg", "로그인 후 사용 가능");
 			request.setAttribute("location","/board/community");
 		}
 		
 		request.getRequestDispatcher("/views/common/msg.jsp").forward(request,response);
 	}

}

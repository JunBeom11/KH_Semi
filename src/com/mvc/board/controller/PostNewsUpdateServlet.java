package com.mvc.board.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.model.service.BoardService;
import com.mvc.board.model.vo.Post;
import com.mvc.common.util.FileRename;
import com.oreilly.servlet.MultipartRequest;


@WebServlet("/board/updatenews")
public class PostNewsUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService service = new BoardService();

    public PostNewsUpdateServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    	Post post = service.findPostbyNo(boardNo, true);
    	
    	request.setAttribute("post", post);
    	request.getRequestDispatcher("/views/board/newsupdate.jsp").forward(request, response);
	}//4월14일 3교시 33분
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	Post post = new Post();
    	String path = getServletContext().getRealPath("/resource/upload/board");
    	int maxSize = 10485760;
    	String encoding = "UTF-8";
     	MultipartRequest mr = new MultipartRequest(request,path,maxSize,encoding,new FileRename());
 		String location = mr.getParameter("location");
 		String content = mr.getParameter("content");
 		content = content.replaceAll("\n", "<br>");
 		
     	post.setPost_Num(Integer.parseInt(mr.getParameter("boardNo")));
     	post.setPost_Title(mr.getParameter("title"));
     	post.setPost_Content(mr.getParameter("content"));
     	post.setPost_MemberId(mr.getParameter("writer"));
     	post.setPost_FileName("fileName");
     	post.setPost_FileReName("upfileName");
     	
 		String fileName= mr.getFilesystemName("upfile");
 		String upfileName = mr.getOriginalFileName("upfile");
 		if(fileName !=null && !fileName.equals(""))
 		{
 			String deleteFilePath=path+"/"+post.getPost_FileReName();
 			
 			deleteFile(deleteFilePath);
 			
 			post.setPost_FileName(fileName);
 			post.setPost_FileReName(upfileName);
 		}
 		result=service.save(post);
 		if(result>0)
		{
			request.setAttribute("msg","게시글 수정 성공");
		}
		else
		{
			request.setAttribute("msg","게시글 수정 실패");
		}
 		request.setAttribute("location", "/board/newsview?boardNo="+post.getPost_Num());
 		request.getRequestDispatcher("/views/common/msg.jsp").forward(request,response);
	/*	HttpSession session = request.getSession(false);
		Member loginMember = session != null?(Member)session.getAttribute("loginMember"):null;*/
    }
    
    private void deleteFile(String path) {
    	File file = new File(path);
    	
    	if(file.exists()) {
    		file.delete();
    	}
    }

}

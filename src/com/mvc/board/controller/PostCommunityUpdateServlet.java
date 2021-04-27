package com.mvc.board.controller;

import java.io.File;
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


@WebServlet("/board/updatecommunity")
public class PostCommunityUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService service = new BoardService();
 
    public PostCommunityUpdateServlet() {

    }
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
    	Post post = service.findPostbyNo2(boardNo, true);
    	
    	request.setAttribute("post", post);
    	request.getRequestDispatcher("/views/board/communityupdate.jsp").forward(request, response);
	}
	
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
     	post.setPost_Title("["+location+"]"+mr.getParameter("title"));
     	post.setPost_Content(mr.getParameter("content"));
     	post.setPost_MemberId(mr.getParameter("writer"));
     	post.setPost_FileName("fileName");
     	post.setPost_FileReName("upfileName");
			switch(location)
			{
			case "서울": location="1";
				break;
			case "경기": location="2";
				break;
			case "충청": location="3";
				break;
			case "경상": location="4";
				break;
			case "전라": location="5";
				break;
			case "강원": location="6";
				break;
			default: System.out.println("스케문 오류2");
				break;
			}
		post.setPost_LocationNum(location);
     	System.out.println(post.getPost_LocationNum()+"번호");
 		String fileName= mr.getFilesystemName("upfile");
 		String upfileName = mr.getOriginalFileName("upfile");
 		if(fileName !=null && !fileName.equals(""))
 		{
 			String deleteFilePath=path+"/"+post.getPost_FileReName();
 			
 			deleteFile(deleteFilePath);
 			
 			post.setPost_FileName(fileName);
 			post.setPost_FileReName(upfileName);
 		}
 		result=service.save2(post);
 		if(result>0)
		{
			request.setAttribute("msg","게시글 수정 성공");
		}
		else
		{
			request.setAttribute("msg","게시글 수정 실패");
		}
 		request.setAttribute("location", "/board/communityview?boardNo="+post.getPost_Num());
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

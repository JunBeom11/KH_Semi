package com.mvc.mypage.controller;

import java.io.IOException;					
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.member.model.vo.Member;
import com.mvc.mypage.model.service.MypageService;

@WebServlet(name= "update", urlPatterns="/mypage/update")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MypageService service = new MypageService();
	
    public MemberUpdateServlet() {
    }
    @Override	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/mypage/update.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		HttpSession session = request.getSession(false);
		Member loginMember = session != null ? (Member)session.getAttribute("loginMember"):null;
		
		if(loginMember  != null) {
			Member member = new Member();
	    	
	    	String member_Id = request.getParameter("Member_Id");
	    	String member_Pw = request.getParameter("Member_Pw");
	    	String member_NickName = request.getParameter("Member_NickName");
	    	String member_Email = request.getParameter("member_Email");
	    	String member_Birth = request.getParameter("member_Birth");
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
	}

}

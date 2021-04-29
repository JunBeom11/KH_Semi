package com.mvc.mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.member.model.vo.Member;

@WebServlet("/mypage/checkpw")
public class MypageCheckPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MypageCheckPwServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	Member loginMember = (Member)session.getAttribute("loginMember");
    	
    	if(loginMember==null) {
    		request.setAttribute("msg", "로그인 해주세요.");
    		request.setAttribute("location", "/member/login");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    		return;
    	}
    	
		request.getRequestDispatcher("/views/mypage/checkPw.jsp").forward(request, response);

	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	Member loginMember = (Member)session.getAttribute("loginMember");
    	String inputPw = request.getParameter("Member_Pw");
    	
    	if(inputPw.equals(loginMember.getMember_Pw())) {
    		//일치
    		session.setAttribute("isCheked", true);
    		response.sendRedirect("/inCorona/mypage/update");
    		//request.getRequestDispatcher("/views/mypage/update.jsp").forward(request, response);
    	}
    	else {
    		//불일치
    		request.setAttribute("msg", "비밀번호를 잘못 입력하셨습니다.");
    		request.setAttribute("location", "/mypage/checkpw");
    		
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
    }

}

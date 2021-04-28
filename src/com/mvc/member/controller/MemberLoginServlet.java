package com.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.member.model.service.MemberService;
import com.mvc.member.model.vo.Member;


@WebServlet(name="login",urlPatterns="/member/login")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	MemberService service = new MemberService();
   
    public MemberLoginServlet() {
        super();   
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Member_Id = request.getParameter("Member_Id");
		String Member_Pw = request.getParameter("Member_Pw");
		String saveId = request.getParameter("saveId");
		
		Member loginMember = service.loginMember(Member_Id, Member_Pw);
		
		if(saveId != null) {
			Cookie cookie = new Cookie("saveId",Member_Id);
			
			cookie.setMaxAge(259200);
			response.addCookie(cookie);
		}else {
			Cookie cookie = new Cookie("saveId","");
			
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		if(loginMember != null){
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			
			request.setAttribute("msg", "로그인 성공");
			request.setAttribute("location", "/");
		}else {
			
			request.setAttribute("msg", "로그인 실패 : 아이디, 비밀번호를 확인해 주세요");
			request.setAttribute("location", "/member/login");
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

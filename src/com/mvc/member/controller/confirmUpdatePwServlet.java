package com.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.member.model.service.MemberService;
import com.mvc.member.model.vo.Member;


@WebServlet(name="confirmUpdatePw",urlPatterns="/member/confirmUpdatePw")
public class confirmUpdatePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	MemberService service = new MemberService();
	
    public confirmUpdatePwServlet() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/confirmUpdatePwd.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Member_Id = request.getParameter("Member_Id");
		String Member_NickName = request.getParameter("Member_NickName");
		String Member_Birth = request.getParameter("Member_Birth");
		HttpSession session = request.getSession();
		
		Member loginMember = service.confirmUpdateMemberPw(Member_Id, Member_NickName, Member_Birth);
		System.out.println(loginMember);
		if(loginMember != null) {
			request.setAttribute("msg", "본인확인 성공");
			request.setAttribute("location", "/member/updatePw");
			session.setAttribute("updatePwMember", loginMember);
			
		}else {
			request.setAttribute("msg", "본인확인 실패 : 회원정보가 맞지 않습니다");
			request.setAttribute("location", "/member/confirmUpdatePw");
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}

}

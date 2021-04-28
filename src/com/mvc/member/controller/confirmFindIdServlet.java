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

@WebServlet(name="confirmfindId",urlPatterns="/member/confirmFindId")
public class confirmFindIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	MemberService service = new MemberService();
	
    public confirmFindIdServlet() {
        super();
    
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/confirmFindId.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Member_NickName = request.getParameter("Member_NickName");
		String Member_Birth = request.getParameter("Member_Birth");
		HttpSession session = request.getSession();
		
		Member loginMember = service.findMemberId(Member_NickName, Member_Birth);
		
		if(loginMember != null) {
			request.setAttribute("msg", "본인확인 완료");
			request.setAttribute("location", "/member/findId");
			session.setAttribute("findIdMember", loginMember);
		}else {
			request.setAttribute("msg", "본인확인 실패 : 회원정보가 맞지 않습니다");
			request.setAttribute("location", "/member/confirmFindId");
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
		
	}

}

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


@WebServlet(name="updatePw",urlPatterns="/member/updatePw")
public class MemberUpdatePwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MemberService service = new MemberService();
 
    public MemberUpdatePwServlet() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/updatePw.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member updatePwMember = (Member) session.getAttribute("updatePwMember");
		int result = 0;
		String Member_Pw = request.getParameter("Member_Pw");
		
		result = service.updateMemberPw(Member_Pw,updatePwMember.getMember_Id());
		
		if(result > 0) {
			request.setAttribute("msg","비밀번호 변경이 완료되었습니다.");
			request.setAttribute("location", "/member/login");
		
		}else {
			request.setAttribute("msg","비밀번호 변경에 실패하였습니다.");
			request.setAttribute("location", "/member/updatePw");
		}
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}
}

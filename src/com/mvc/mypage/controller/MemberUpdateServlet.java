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
		String userPwd = request.getParameter("userPwd");
		
		if(loginMember  != null) {
			result = service.updatePassword(loginMember.getMember_Id(),userPwd);
			
			if(result > 0) {
				request.setAttribute("msg", "비밀번호 변경이 완료되었습니다.");
				request.setAttribute("script", "self.close()");
			}else {
				request.setAttribute("msg", "비밀번호 변경에 실패했습니다");
				request.setAttribute("script", "self.close");
			}
			
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
	}

}

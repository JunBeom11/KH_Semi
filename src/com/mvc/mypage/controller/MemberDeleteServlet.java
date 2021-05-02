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

@WebServlet("/member/update")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MypageService service = new MypageService();
	
    public MemberDeleteServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	HttpSession session = request.getSession(false);
    	Member loginMember = session != null ? (Member)session.getAttribute("loginMember") : null;
    	
		if(loginMember != null) {
			result = service.delete(loginMember.getMember_Id());
			 
			if(result > 0) {
				request.setAttribute("msg", "정상적으로 탈퇴되었습니다.");
				
				if(session !=null) {
					session.invalidate();
				}
				
        		request.setAttribute("location", "/");
        	} else {
        		request.setAttribute("msg", "탈퇴에 실패하였습니다.");
        		request.setAttribute("location", "/mypage/update");
        	}
			
		} else {
    		request.setAttribute("msg", "로그인 후 수정해주세요.");
    		request.setAttribute("location", "/");
		}
    
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

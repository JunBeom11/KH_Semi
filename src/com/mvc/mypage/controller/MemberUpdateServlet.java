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

@WebServlet(name = "update", urlPatterns = "/mypage/update")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MypageService service = new MypageService();

	public MemberUpdateServlet() {
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");

		if (loginMember == null) {
			request.setAttribute("msg", "로그인 해주세요.");
			request.setAttribute("location", "/member/login");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
			return;
		}

		//////////////////여기부터
		 boolean isChecked = (boolean)session.getAttribute("isChecked");
		 
		 if(!isChecked) { 
			 request.setAttribute("msg", "비밀번호 재확인이 필요합니다.");
			 request.setAttribute("location", "/mypage/checkpw");
			 request.getRequestDispatcher("/views/common/msg.jsp").forward(request,response);
			 return;
		 }
		 
		session.removeAttribute("isChecked"); 
		////////////////////여기까지
		request.getRequestDispatcher("/views/mypage/update.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
		// String userPwd = request.getParameter("userPwd");
		Member member = new Member(loginMember);
		int LocationNum = 0;

		String loginId = loginMember.getMember_Id();

		switch (request.getParameter("Member_LocationNum")) {
		case "Seoul":
			LocationNum = 1;
			break;
		case "Gyeonggi":
			LocationNum = 2;
			break;
		case "Daegu":
			LocationNum = 3;
			break;
		case "Incheon":
			LocationNum = 4;
			break;
		case "Gwangju":
			LocationNum = 5;
			break;
		case "Daejeon":
			LocationNum = 6;
			break;
		case "Ulsan":
			LocationNum = 7;
			break;
		case "Busan":
			LocationNum = 8;
			break;
		case "Gangwon":
			LocationNum = 9;
			break;
		case "South_Chungcheong":
			LocationNum = 10;
			break;
		case "North_Chungcheong":
			LocationNum = 11;
			break;
		case "South_Jeolla":
			LocationNum = 12;
			break;
		case "North_Jeolla":
			LocationNum = 13;
			break;
		case "South_Gyeongsang":
			LocationNum = 14;
			break;
		case "North_Gyeongsang":
			LocationNum = 15;
			break;
		case "Jeju":
			LocationNum = 16;
			break;
		case "Sejong":
			LocationNum = 17;
			break;
		}

		member.setMember_Id(loginId);
		member.setMember_Pw(request.getParameter("Member_Pw"));
		member.setMember_NickName(request.getParameter("Member_NickName"));
		member.setMember_Birth(request.getParameter("Member_Birth"));
		member.setMember_Email(request.getParameter("Member_Email"));
		member.setMember_LocationNum(String.valueOf(LocationNum));

		// 업데이트와 동시에 member객체 갈아끼움
		member = service.updateMypage(member, loginId);

		if (member != null) {
			// 세션에 저장
			session.setAttribute("loginMember", member);

			request.setAttribute("msg", "회원 정보 수정이 완료되었습니다.");
			request.setAttribute("location", "/");
		} else {
			request.setAttribute("msg", "회원 정보 수정에 실패하였습니다.");
			request.setAttribute("location", "/mypage/update");
		}

		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

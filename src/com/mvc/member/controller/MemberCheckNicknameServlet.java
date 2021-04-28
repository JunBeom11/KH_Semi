package com.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.member.model.service.MemberService;

@WebServlet("/member/checkNickname")
public class MemberCheckNicknameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberCheckNicknameServlet() {
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userNickname = request.getParameter("userNickname");
		
		System.out.println("userNickname : " + userNickname);
		
		boolean duplicated = new MemberService().isNickNameDuplicated(userNickname);
		
		request.setAttribute("duplicated", duplicated);
		
		request.getRequestDispatcher("/views/member/checkNickname.jsp").forward(request, response);
	}

}

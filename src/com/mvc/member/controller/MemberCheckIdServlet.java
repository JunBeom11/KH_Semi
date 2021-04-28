package com.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.member.model.service.MemberService;

@WebServlet("/member/checkId")
public class MemberCheckIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberCheckIdServlet() {
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ID 값을 가져와서 DB에 있는 값인지 확인하고 결과를 페이지에 전달하는 기능
		String userId = request.getParameter("userId");
		
		System.out.println("UserId : " + userId);
		
		boolean duplicated = new MemberService().isIdDuplicated(userId);
		
		request.setAttribute("duplicated", duplicated);
		
		request.getRequestDispatcher("/views/member/checkId.jsp").forward(request, response);
	}

}
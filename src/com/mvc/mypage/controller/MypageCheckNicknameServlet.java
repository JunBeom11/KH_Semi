package com.mvc.mypage.controller;

import java.io.IOException;			
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.mypage.model.service.MypageService;


@WebServlet("/Mypage/CheckNickname")
public class MypageCheckNicknameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
           
    public MypageCheckNicknameServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String userNickname = request.getParameter("userNickname");
		
		System.out.println("userNickname : " + userNickname);
		
		
		boolean duplicated = new MypageService().isNickNameDuplicated(userNickname);
		
		request.setAttribute("duplicated", duplicated);
		
		request.getRequestDispatcher("/views/mypage/checkNickname.jsp").forward(request, response);
	}

}

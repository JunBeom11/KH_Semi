package com.mvc.hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.service.HospitalService;
import com.mvc.hospital.model.vo.Hospital;

@WebServlet("/hospital/cList")
public class CListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private HospitalService service = new HospitalService();
	
    public CListServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("cList페이지입니다.");
    	
    	int page=0;
    	int listCount=0;
    	PageInfo pageInfo= null;
    	List<Hospital> list = null;
    	
    	try {
    		page=Integer.parseInt(request.getParameter("page"));
    	} catch(NumberFormatException e) {
    		page=1;
    	}
    	
    	listCount=service.getClinicCount();
    	pageInfo=new PageInfo(page, 10, listCount, 10);
    	list=service.getClinicList(pageInfo);
    	
    	
    	request.setAttribute("list", list);
    	request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/hospital/cList.jsp").forward(request, response);
	}

}


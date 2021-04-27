package com.mvc.hospital.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.service.HospitalService;
import com.mvc.hospital.model.vo.Hospital;

@WebServlet("/hospital/list")
public class HospitalListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private HospitalService service = new HospitalService();

	
    public HospitalListServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    	request.getRequestDipatcher("/views/hospital/list.jsp").forward(request, response);
    	System.out.println("hospitalListServlet페이지 이동");
    	
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	List<Hospital> list = null;
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1;
		}
    	
    	listCount = service.getHospitalCount();    	
    	pageInfo = new PageInfo(page, 10, listCount, 10);
//    	list = service.getHospitalList(pageInfo);
    	list = service.getHospitalSeoulList(pageInfo);
    	    	
    	request.setAttribute("list", list);
    	request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/hospital/hospitalList.jsp").forward(request, response);
	}
    
	}


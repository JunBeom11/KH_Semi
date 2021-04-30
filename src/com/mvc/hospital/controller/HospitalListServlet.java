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
    	String locationName=request.getParameter("locationName");
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    		System.out.println("page : "+ page);
    	} catch (NumberFormatException e) {
    		System.out.println("오류");
    		page = 1;
		}
    	
    	if(locationName==null) {
    		listCount = service.getHospitalCount();    	
    		
    	}
    	else {
    		listCount = service.getHospitalCount2(locationName);
    	}
    	
    	pageInfo = new PageInfo(page, 10, listCount, 10);
    	list = service.gethType_location(pageInfo, locationName);
    	System.out.println("Servlet list : "+list);
    	System.out.println("Servlet locationName : "+locationName);
    	
    	if(list.size()!=0 && locationName!=null) {
    		String locationNum=list.get(0).getLocation_Hnum();
    		System.out.println(locationNum + "성공");
    		request.setAttribute("locationNum", locationNum);
    		System.out.println(list + locationName);
    	}
    	else {
    		String locationNum="0";
    		request.setAttribute("locationNum", locationNum);
    		System.out.println(list + locationName);
    		System.out.println("elselocationNum : "+locationNum);
    	}
    	
    	request.setAttribute("list", list);
    	request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/hospital/hospitalList.jsp").forward(request, response);
	}
    
	}


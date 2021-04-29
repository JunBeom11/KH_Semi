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

@WebServlet("/clinic/list")
public class ClinicListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private HospitalService service = new HospitalService();
	
    public ClinicListServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("clinicListServlet페이지 이동");
    	
    	int page= 0;
    	int listCount=0;
    	PageInfo pageInfo = null;
    	List<Hospital> list = null;
    	String locationName=request.getParameter("locationName");
    	
    	try {
    		page=Integer.parseInt(request.getParameter("page"));
    		System.out.println("page : "+ page);
    	} catch(NumberFormatException e) {
    		System.out.println("오류");
    		page = 1;
    	}
    	
    	if(locationName==null) {
    		listCount=service.getClinicCount();
    		System.out.println(listCount);
    	}
    	else {
    		listCount=service.getClinicCount2(locationName);
    		System.out.println(listCount);
    	}
    	
    	pageInfo=new PageInfo(page,10,listCount,10);
    	list=service.getcType_location(pageInfo, locationName);
    	
    	if(list.size()!= 0 && locationName != null) {
    		String locationNum=list.get(0).getLocation_Cnum();
    		System.out.println(locationNum + "성공");
    		request.setAttribute("locationNum", locationNum);
    	}
    	else {
    		String locationNum="0";
    		request.setAttribute("locationNum", locationNum);
    		System.out.println("elselocationNum : "+locationNum);
    	}
    	
    	request.setAttribute("list", list);
    	request.setAttribute("pageInfo", pageInfo);
    	request.getRequestDispatcher("/views/hospital/clinicList.jsp").forward(request, response);
	}

}

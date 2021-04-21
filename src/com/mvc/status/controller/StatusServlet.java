package com.mvc.status.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.mvc.status.model.service.StatusService;
import com.mvc.status.model.vo.Status;

@WebServlet("")
public class StatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private StatusService service = new StatusService();
       
    public StatusServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	List<Status> list;
    	
		try {
			list = service.getStatus();
			
			int resultCode = list.get(0).getResultCode();
			String resultMsg = list.get(0).getResultMsg();
			
			//정상적인 결과일 때: 결과코드,결과메세지,임시데이터가 담긴 첫번째 객체 지움
			if(resultCode == 0) list.remove(0);
			
			request.setAttribute("resultCode",resultCode);
			request.setAttribute("resultMsg", resultMsg);	
	    	request.setAttribute("statusList", list);
	    	
	    	//테스트용 콘솔찍기
	    	for(Status status:list) {
	    		System.out.println(status.getDecideCnt());
	    	}
	    	
		} catch (IOException | SAXException | ParserConfigurationException e) {
			
		}
    
		request.getRequestDispatcher("/index.jsp").forward(request, response);   	
    }

}

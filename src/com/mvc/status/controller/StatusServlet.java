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
			list = service.getStatusList();
			
			//결과코드, 결과메세지
			int resultCode = list.get(0).getResultCode();
			String resultMsg = list.get(0).getResultMsg();
			
			request.setAttribute("resultCode",resultCode);
			request.setAttribute("resultMsg", resultMsg);
			
			
			//정상적인 결과가 아닐 때 리턴
			if(resultCode != 0) return;
			
			
			//정상적인 결과일 때			
			//일일 확진자 수 배열
	    	int[] decideArr = service.getDecideArr(list);

	    	//전날과 비교
	    	int[] compareArr = service.getCompareArr(list);
	    	
			request.setAttribute("todayStatus", list.get(1));	//list.get(0)은 결과코드객체
	    	request.setAttribute("decideArr", decideArr);
	    	request.setAttribute("compareArr", compareArr);
	    	
		} catch (IOException | SAXException | ParserConfigurationException e) {
			
		}
    
		request.getRequestDispatcher("/index.jsp").forward(request, response);   	
    }

}

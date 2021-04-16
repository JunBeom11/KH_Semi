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
    	
    }

}

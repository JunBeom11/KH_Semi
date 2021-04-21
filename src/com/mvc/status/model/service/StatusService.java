package com.mvc.status.model.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.mvc.status.util.StatusAPI;
import com.mvc.status.util.StatusParser;
import com.mvc.status.model.vo.Status;

public class StatusService {
	public List<Status> getStatus() throws IOException, SAXException, ParserConfigurationException{
		String xml = readAPI();
		
		//xml을 제대로 불러오지 못했을 때 임시데이터 객체 리턴
		if(xml == null || xml.equals("")) return new ArrayList<Status>() {
				private static final long serialVersionUID = 1L;
				{add(new Status(77,"API_CONNECTION_ERROR"));}
			};	
		
		return parseStatus(xml);
	}
	
	private String readAPI() throws IOException {
		return new StatusAPI().getStatus();
	}
	
	private List<Status> parseStatus(String xml) throws SAXException, ParserConfigurationException, IOException{
		return new StatusParser().parseStatus(xml);
	}
}

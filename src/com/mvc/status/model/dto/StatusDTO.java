package com.mvc.status.model.dto;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.mvc.status.model.vo.Status;

import com.mvc.common.util.StatusAPI;
import com.mvc.common.util.StatusParser;

public class StatusDTO {
	public List<Status> getStatus() throws IOException, SAXException, ParserConfigurationException {
		return null;
	}
	
	private String readAPI() throws IOException {
		return null;
	}
	
	private List<Status> parseStatus(String xml) throws SAXException, ParserConfigurationException, IOException{
		return null;
	}
}

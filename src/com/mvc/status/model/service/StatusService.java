package com.mvc.status.model.service;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import com.mvc.status.model.dto.StatusDTO;
import com.mvc.status.model.vo.Status;

public class StatusService {
	private StatusDTO dto = new StatusDTO();
	
	public List<Status> getStatus() throws IOException, SAXException, ParserConfigurationException{
		return null;
	}
}

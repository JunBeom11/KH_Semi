package com.mvc.common.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mvc.status.model.vo.Status;

public class StatusParser {
	public List<Status> parseStatus(String xml) throws SAXException, ParserConfigurationException, IOException{
		return null;
	}
	
	private String getTagValue(String tag, Element element) {
		return null;
	}
}

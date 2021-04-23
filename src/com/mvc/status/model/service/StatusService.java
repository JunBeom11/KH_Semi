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
	private List<Status> list;
	private int[] compareArr = new int[5];
	private int[] decideArr = new int[7];
	
	public List<Status> getStatusList() throws IOException, SAXException, ParserConfigurationException{
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
	
	public int[] getCompareArr(List<Status> list) {
    	//전날과 비교
		
		if(list==null) return null;
    	this.compareArr[0] = list.get(1).getDecideCnt() - list.get(2).getDecideCnt();	/* 확진자 */
    	this.compareArr[1] = list.get(1).getClearCnt() - list.get(2).getClearCnt();		/* 완치자 */
    	this.compareArr[2] = list.get(1).getCareCnt() - list.get(2).getCareCnt();		/* 격리자 */
    	this.compareArr[3] = list.get(1).getDeathCnt() - list.get(2).getDeathCnt();		/* 사망자 */
    	this.compareArr[4] = list.get(1).getAccExamCnt() - list.get(2).getAccExamCnt();	/* 검사수 */
    	
    	return this.compareArr;
	}

	public int[] getDecideArr(List<Status> list) {
		//일주일 간 확진자 수
		if(list==null) return null;
		for(int i=0;i<7;i++) {
    		this.decideArr[i] = list.get(i+1).getDecideCnt() - list.get(i+2).getDecideCnt();
    	}
		return this.decideArr;
	}
	
}

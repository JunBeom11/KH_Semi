package com.mvc.status.util;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.mvc.status.model.vo.Status;

public class StatusParser {
	public List<Status> parseStatus(String xml) throws SAXException, ParserConfigurationException, IOException{
		List<Status> list = new ArrayList<>();
		
		//파싱 객체 생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		
		//InputSource로 변환
		InputSource is = new InputSource(new StringReader(xml));
		
		//파싱 시작
		Document doc = documentBuilder.parse(is);
		
		//결과코드 있는 Status 객체를 맨 처음에 추가
		Element header = (Element)doc.getElementsByTagName("header").item(0);
		list.add(new Status(Integer.parseInt(getTagValue("resultCode",header)),getTagValue("resultMsg",header)));
		
		//태그 데이터 찾아오기
		NodeList nList = doc.getElementsByTagName("item");
		
		for(int i=0;i<nList.getLength(); i++) {
			Node nNode = nList.item(i);
			
			if(nNode.getNodeType()!=Node.ELEMENT_NODE) continue;			
				
			Element element = (Element)nNode;
			
			Status status = new Status();
				
			status.setStateDt(getTagValue("stateDt",element));									/* 기준일 */
			status.setStateTime(getTagValue("stateTime",element));								/* 기준시간 */
				
			status.setSeq(Integer.parseInt(getTagValue("seq",element)));						/* 게시글번호(감염현황 고유값) */
				
			status.setCreateDt(getTagValue("createDt",element));								/* 등록일시분초 */
			status.setUpdateDt(getTagValue("updateDt",element));								/* 수정일시분초 */	
				
			status.setDecideCnt(Integer.parseInt(getTagValue("decideCnt",element)));			/* 확진자 수 */	
			status.setCareCnt(Integer.parseInt(getTagValue("careCnt",element)));				/* 치료중 환자 수 */
			status.setDeathCnt(Integer.parseInt(getTagValue("deathCnt",element)));				/* 사망자 수 */
			status.setClearCnt(Integer.parseInt(getTagValue("clearCnt",element)));				/* 격리해제 수 */
				
			status.setAccDefRate(Double.parseDouble(getTagValue("accDefRate",element)));		/* 누적 확진률 */					
			status.setAccExamCnt(Integer.parseInt(getTagValue("accExamCnt",element)));			/* 누적 검사수 */
			status.setAccExamCompCnt(Integer.parseInt(getTagValue("accExamCompCnt",element)));	/* 누적 검사 완료수 */
			status.setExamCnt(Integer.parseInt(getTagValue("examCnt",element)));				/* 검사진행 수 */
			status.setResultNegCnt(Integer.parseInt(getTagValue("resutlNegCnt",element)));		/* 결과 음성 수 */
				
			list.add(status);
		}
		
		return list;
	}
	
	private String getTagValue(String tag, Element element) {
		Node nValue = element.getElementsByTagName(tag).item(0).getChildNodes().item(0);		
		return nValue==null? null : nValue.getNodeValue();
	}
}

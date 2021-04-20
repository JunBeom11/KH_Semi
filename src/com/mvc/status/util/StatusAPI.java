package com.mvc.status.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

public class StatusAPI {
	private String serviceKey;
	private String pageNo;
	private String numOfRows;
	
	private URL url;
	
	private Properties prop;
	
	public StatusAPI() throws IOException{
		prop = new Properties();
		prop.load(new FileReader(StatusAPI.class.getResource("/com/mvc/common/config/config.properties").getPath()));

		this.serviceKey = prop.getProperty("status.serviceKey");
		this.pageNo = "1";
		this.numOfRows = "10";
		this.url = buildURL();
	}
	
	public String getStatus() throws IOException {
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/xml"); 
        
        BufferedReader br;        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) { 
        	//연결성공
        	br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
        } else { 
        	//연결실패
        	br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            return null;
        }
        
        StringBuilder result = new StringBuilder();
        String line;
        while ((line=br.readLine())!=null) result.append(line);
        
        br.close();
        conn.disconnect();
        
		return result.toString();
	}
	
	private URL buildURL() throws IOException {
		DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyyMMdd");
		LocalDateTime now = LocalDateTime.now();
		
		String startCreateDt = now.minusDays(7).format(pattern);
		String endCreateDt = now.format(pattern);			
		
		StringBuilder urlBuilder;
		urlBuilder = new StringBuilder(prop.getProperty("status.url")); 		/*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey); 										/*서비스 키*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); 			/*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); 				/*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(startCreateDt, "UTF-8")); 	/*데이터 생성일 시작 범위*/
        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(endCreateDt, "UTF-8")); 		/*데이터 생성일 종료 범위*/
        
        return new URL(urlBuilder.toString());
	}
}

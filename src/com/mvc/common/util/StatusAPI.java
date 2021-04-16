package com.mvc.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class StatusAPI {
	private static String serviceKey = "9HwqcEPXlxiz1OXm9ZK0tX66Vtev0r7IAbcenqO0KvaSPEO9IGFAPIFevcXM%2FQrW1lgEbMDDLLH6oqJmQ%2FryvA%3D%3D";
	private static String pageNo = "1";
	private static String numOfRows = "10";
	
	private LocalDateTime now;
	private DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyyMMdd");
	
	private String startCreateDt;
	private String endCreateDt;
	
	private StringBuilder urlBuilder;
	private URL url;
	
	public StatusAPI() throws IOException{

	}
	
	public String getStatus() throws IOException {
        return null;
	}
	
	private URL buildURL() throws IOException {
		return null;
	}
}

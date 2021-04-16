package com.mvc.hospital.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Hospital {

	private int hospital_Num;				// 지역번호
	private String hospital_Type;			// 병원타입
	private String hospital_Name;			// 병원명
	private String hospital_Location;		// 병원주소
	private String hospital_Url;			// 병원홈페이지
	private String hospital_Tel;			// 병원전화번호
	private String hospital_Latitude;		// 위도
	private String hospital_Longitude;		// 경도
	private String hospital_LocationNum;	// 지역번호()
	
}

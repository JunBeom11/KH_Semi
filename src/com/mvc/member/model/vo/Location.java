package com.mvc.member.model.vo;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Location {

	private String location_Num;		//지역번호
	private String location_Name;		//지역이름
	private String location_Category;	//대분류
	private String location_Latitude;	//위도
	private String location_Longitude;	//경도
}

package com.mvc.hospital.model.service;

import java.sql.Connection;
import java.util.List;

import com.mvc.common.jdbc.JDBCTemplate;
import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.dao.HospitalDAO;
import com.mvc.hospital.model.vo.Hospital;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class HospitalService {

	private HospitalDAO dao = new HospitalDAO();
	
	public int getHospitalCount() {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getHospitalCount(connection);
		
		JDBCTemplate.close(connection);
		return count;
	}
	public int getHospitalCount2(String locationName) {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getHospitalCount2(connection, locationName);
		
		JDBCTemplate.close(connection);
		return count;
	}
	
	
	
	public int getClinicCount() {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getClinicCount(connection);
		
		JDBCTemplate.close(connection);
		
		return count;
	}
	
	public int getClinicCount2(String locationName) {
		Connection connection = JDBCTemplate.getConnection();
		int count = dao.getClinicCount2(connection, locationName);
		
		JDBCTemplate.close(connection);
		return count;
	}
	

	public List<Hospital> gethType_location(PageInfo pageInfo, String locationName) {
		Connection connection = getConnection();
		List<Hospital> list = dao.gethType_location(connection, pageInfo, locationName);
		close(connection);
		return list;
	}
	public List<Hospital> getcType_location(PageInfo pageInfo, String locationName) {
		Connection connection = getConnection();
		List<Hospital> list = dao.getcType_location(connection, pageInfo, locationName);
		close(connection);
		return list;
	}
	public List<Hospital> getClinicList(PageInfo pageInfo) {
		// TODO Auto-generated method stub
		return null;
	}

	

}

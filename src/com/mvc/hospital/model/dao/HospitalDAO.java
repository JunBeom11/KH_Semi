package com.mvc.hospital.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.vo.Hospital;
import com.mvc.member.model.vo.Location;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class HospitalDAO {
	

	public int getHospitalCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			query = "select count(*) from hospital";
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return count;
	}
	
	public int getClinicCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			query = "select count(*) from clinic";
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return count;
	}

	public List<Hospital> findHospitalAll(Connection connection, PageInfo pageInfo) {
		List<Hospital> list= new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		try {
//			query = "select HOSPITAL_NAME, hospital_address, hospital_tel, location_num from hospital";
			query = "select rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select rownum as rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select  hospital_name, hospital_address, hospital_tel, location_num from hospital "
					+ "order by to_number(location_num)asc))"
					+ "where rown between ? and ?";
			
			
			pstmt = connection.prepareStatement(query);
			
			// ? 값을 set하는 구문
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				// BOARD 테이블의 컬럼들을 Board 객체에 Mapping 하는 구문
				hospital.setRowNum(rs.getInt("ROWN"));
				hospital.setHospital_Name(rs.getString("HOSPITAL_NAME"));
				hospital.setHospital_Address(rs.getString("hospital_address"));
				hospital.setHospital_Tel(rs.getString("hospital_tel"));
				hospital.setLocation_Hnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);			
		}		
		
		return list;
	}

	public List<Hospital> findClinicAll(Connection connection, PageInfo pageInfo) {
		List<Hospital> list= new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
//			query = "select HOSPITAL_NAME, hospital_address, hospital_tel, location_num from hospital";
			query = "select rown, clinic_name, clinic_address, clinic_tel, location_num from( "
					+ "select rownum as rown, clinic_name, clinic_address, clinic_tel, location_num from( "
					+ "select  clinic_name, clinic_address, clinic_tel, location_num from clinic "
					+ "order by to_number(location_num)asc))"
					+ "where rown between ? and ?";
			
			
			pstmt = connection.prepareStatement(query);
			
			// ? 값을 set하는 구문
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				// BOARD 테이블의 컬럼들을 Board 객체에 Mapping 하는 구문
				hospital.setRowNum(rs.getInt("ROWN"));
				hospital.setClinic_Name(rs.getString("CLINIC_NAME"));
				hospital.setClinic_Address(rs.getString("clinic_address"));
				hospital.setClinic_Tel(rs.getString("clinic_tel"));
				hospital.setLocation_Cnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);			
		}		
		
		return list;
	}
	

	public List<Hospital> findClinic_typeLocation(Connection connection, PageInfo pageInfo) {
		List<Hospital> list= new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		try {
			query = "select rownum,hospital_name, hospital_address, hospital_tel, location_num from hospital "
					+ "where location_num=1 ";
			
			
			pstmt = connection.prepareStatement(query);
			
			// ? 값을 set하는 구문
//			pstmt.setInt(1, pageInfo.getStartList());
//			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				// Hospital 테이블의 컬럼들을 Hospital 객체에 Mapping 하는 구문
				hospital.setRowNum(rs.getInt("ROWNUM"));
				hospital.setHospital_Name(rs.getString("HOSPITAL_NAME"));
				hospital.setHospital_Address(rs.getString("hospital_address"));
				hospital.setHospital_Tel(rs.getString("hospital_tel"));
				hospital.setLocation_Hnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);			
		}		
		
		return list;
	}
}

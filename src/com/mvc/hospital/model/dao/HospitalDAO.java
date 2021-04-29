package com.mvc.hospital.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mvc.common.util.PageInfo;
import com.mvc.hospital.model.vo.Hospital;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

import static com.mvc.common.jdbc.JDBCTemplate.*;

public class HospitalDAO {

	public int getHospitalCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			query = "select count(*) from hospital ";
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
	
	

	public int getHospitalCount2(Connection connection, String locationName) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			if (locationName != null) {
				query = "select count(hospital_name) from hospital " + "where location_num=? ";
				pstmt = connection.prepareStatement(query);
				switch (locationName) {
				case "서울":
					pstmt.setString(1, "1");
					break;
				case "경기":
					pstmt.setString(1, "2");
					break;
				case "대구":
					pstmt.setString(1, "3");
					break;
				case "인천":
					pstmt.setString(1, "4");
					break;
				case "광주":
					pstmt.setString(1, "5");
					break;
				case "대전":
					pstmt.setString(1, "6");
					break;
				case "울산":
					pstmt.setString(1, "7");
					break;
				case "부산":
					pstmt.setString(1, "8");
					break;
				case "강원":
					pstmt.setString(1, "9");
					break;
				case "충남":
					pstmt.setString(1, "10");
					break;
				case "충북":
					pstmt.setString(1, "11");
					break;
				case "전남":
					pstmt.setString(1, "12");
					break;
				case "전북":
					pstmt.setString(1, "13");
					break;
				case "경남":
					pstmt.setString(1, "14");
					break;
				case "경북":
					pstmt.setString(1, "15");
					break;
				case "제주":
					pstmt.setString(1, "16");
					break;
				case "세종":
					pstmt.setString(1, "17");
					break;
				default:
					break;
				}
			} else {
				query = "select count(*) from hospital ";
				pstmt = connection.prepareStatement(query);
			}
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
	
	public int getClinicCount2(Connection connection, String locationName) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			if (locationName != null) {
				query = "select count(clinic_name) from clinic " + "where location_num=? ";
				pstmt = connection.prepareStatement(query);
				switch (locationName) {
				case "서울":
					pstmt.setString(1, "1");
					break;
				case "경기":
					pstmt.setString(1, "2");
					break;
				case "대구":
					pstmt.setString(1, "3");
					break;
				case "인천":
					pstmt.setString(1, "4");
					break;
				case "광주":
					pstmt.setString(1, "5");
					break;
				case "대전":
					pstmt.setString(1, "6");
					break;
				case "울산":
					pstmt.setString(1, "7");
					break;
				case "부산":
					pstmt.setString(1, "8");
					break;
				case "강원":
					pstmt.setString(1, "9");
					break;
				case "충남":
					pstmt.setString(1, "10");
					break;
				case "충북":
					pstmt.setString(1, "11");
					break;
				case "전남":
					pstmt.setString(1, "12");
					break;
				case "전북":
					pstmt.setString(1, "13");
					break;
				case "경남":
					pstmt.setString(1, "14");
					break;
				case "경북":
					pstmt.setString(1, "15");
					break;
				case "제주":
					pstmt.setString(1, "16");
					break;
				case "세종":
					pstmt.setString(1, "17");
					break;
				default:
					break;
				}
			} else {
				query = "select count(*) from clinic ";
				pstmt = connection.prepareStatement(query);
			}
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




	public List<Hospital> gethType_location(Connection connection, PageInfo pageInfo, String locationName) {
		List<Hospital> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String query=null;
		
		System.out.println("locationName: "+locationName);
		
		query = "SELECT *"
	               + "FROM ("
	               + "    SELECT ROWNUM AS RNUM, hospital_name, hospital_address, hospital_tel, location_num "
	               + "    FROM ("
	               + "        SELECT *"
	               + "        FROM  hospital"
	               + "        WHERE location_num=? ORDER BY location_num asc"
	               + "    )"
	               + ")"
	               + "WHERE RNUM BETWEEN ? and ?";
	             
	         try {
	             System.out.println("locationName 123: "+locationName);
	             if(locationName==null) {
	                query = query.replace("WHERE location_num=?", "");
	                pstmt=connection.prepareStatement(query);
	                pstmt.setInt(1, pageInfo.getStartList());
	                 pstmt.setInt(2, pageInfo.getEndList());
	             }
	             else {
	            	pstmt=connection.prepareStatement(query);
	                pstmt.setInt(2, pageInfo.getStartList());
	                pstmt.setInt(3, pageInfo.getEndList());
	                
	                switch(locationName) {
	                case "서울": pstmt.setString(1, "1"); 
	                break;
	                case "경기": pstmt.setString(1, "2"); 
	                break;
	                case "대구": pstmt.setString(1, "3"); 
	                break;
	                case "인천": pstmt.setString(1, "4"); 
	                break;
	                case "광주": pstmt.setString(1, "5"); 
	                break;
	                case "대전": pstmt.setString(1, "6");
	                break;
	                case "울산": pstmt.setString(1, "7"); 
	                break;
	                case "부산": pstmt.setString(1, "8"); 
	                break;
	                case "강원": pstmt.setString(1, "9"); 
	                break;
	                case "충남": pstmt.setString(1, "10"); 
	                break;
	                case "충북": pstmt.setString(1, "11"); 
	                break;
	                case "전남": pstmt.setString(1, "12"); 
	                break;
	                case "전북": pstmt.setString(1, "13"); 
	                break;
	                case "경남": pstmt.setString(1, "14"); 
	                break;
	                case "경북": pstmt.setString(1, "15"); 
	                break;
	                case "제주": pstmt.setString(1, "16"); 
	                break;
	                case "세종": pstmt.setString(1, "17"); 
	                break;
	                default : System.out.println("없음");
	                break;
	                }
	             }
	             
	             rs=pstmt.executeQuery();
	      
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				hospital.setRowNum(rs.getInt("rnum"));
				hospital.setHospital_Name(rs.getString("hospital_name"));
				hospital.setHospital_Address(rs.getString("hospital_address"));
				hospital.setHospital_Tel(rs.getString("hospital_tel"));
				hospital.setLocation_Hnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}
			System.out.println("dao : "+list);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}


	public List<Hospital> getcType_location(Connection connection, PageInfo pageInfo, String locationName) {
		List<Hospital> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String query=null;
		
		
		query = "SELECT *"
	               + "FROM ("
	               + "    SELECT ROWNUM AS RNUM, clinic_name, clinic_address, clinic_tel, location_num "
	               + "    FROM ("
	               + "        SELECT *"
	               + "        FROM  clinic"
	               + "        WHERE location_num=? ORDER BY location_num asc"
	               + "    )"
	               + ")"
	               + "WHERE RNUM BETWEEN ? and ? ";
	             
	         try {
	             System.out.println("locationName 123: "+locationName);
	             if(locationName==null) {
	                query = query.replace("WHERE location_num=?", "");
	                pstmt=connection.prepareStatement(query);
	                pstmt.setInt(1, pageInfo.getStartList());
	                pstmt.setInt(2, pageInfo.getEndList());
	             }
	             else {
	            	pstmt=connection.prepareStatement(query);
	                pstmt.setInt(2, pageInfo.getStartList());
	                pstmt.setInt(3, pageInfo.getEndList());
	                
	                switch(locationName) {
	                case "서울": pstmt.setString(1, "1"); 
	                break;
	                case "경기": pstmt.setString(1, "2"); 
	                break;
	                case "대구": pstmt.setString(1, "3"); 
	                break;
	                case "인천": pstmt.setString(1, "4"); 
	                break;
	                case "광주": pstmt.setString(1, "5"); 
	                break;
	                case "대전": pstmt.setString(1, "6");
	                break;
	                case "울산": pstmt.setString(1, "7"); 
	                break;
	                case "부산": pstmt.setString(1, "8"); 
	                break;
	                case "강원": pstmt.setString(1, "9"); 
	                break;
	                case "충남": pstmt.setString(1, "10"); 
	                break;
	                case "충북": pstmt.setString(1, "11"); 
	                break;
	                case "전남": pstmt.setString(1, "12"); 
	                break;
	                case "전북": pstmt.setString(1, "13"); 
	                break;
	                case "경남": pstmt.setString(1, "14"); 
	                break;
	                case "경북": pstmt.setString(1, "15"); 
	                break;
	                case "제주": pstmt.setString(1, "16"); 
	                break;
	                case "세종": pstmt.setString(1, "17"); 
	                break;
	                default : System.out.println("없음");
	                break;
	                }
	             }
	             
	             rs=pstmt.executeQuery();
	      
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				hospital.setRowNum(rs.getInt("rnum"));
				hospital.setClinic_Name(rs.getString("clinic_name"));
				hospital.setClinic_Address(rs.getString("clinic_address"));
				hospital.setClinic_Tel(rs.getString("clinic_tel"));
				hospital.setLocation_Cnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}
			System.out.println("dao : "+list);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
	}

	

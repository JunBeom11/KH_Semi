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

	public int getHospitalCount2(Connection connection, String locationName) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			if (locationName != null) {
				query = "select count(hospital_name) from hospital " + "where location_num=?";
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
				query = "select count(hospital_name) from hospital " + "where location_num=1";
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

	public List<Hospital> findHospitalAll(Connection connection, PageInfo pageInfo) {
		List<Hospital> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		try {
			query = "select rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select rownum as rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select  hospital_name, hospital_address, hospital_tel, location_num from hospital "
					+ "order by to_number(location_num)asc))" + "where rown between ? and ?";

			pstmt = connection.prepareStatement(query);

			// ? 값을 set하는 구문
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());

			rs = pstmt.executeQuery();

			while (rs.next()) {
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
		List<Hospital> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
//			query = "select HOSPITAL_NAME, hospital_address, hospital_tel, location_num from hospital";
			query = "select rown, clinic_name, clinic_address, clinic_tel, location_num from( "
					+ "select rownum as rown, clinic_name, clinic_address, clinic_tel, location_num from( "
					+ "select  clinic_name, clinic_address, clinic_tel, location_num from clinic "
					+ "order by to_number(location_num)asc))" + "where rown between ? and ?";

			pstmt = connection.prepareStatement(query);

			// ? 값을 set하는 구문
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());

			rs = pstmt.executeQuery();

			while (rs.next()) {
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
		List<Hospital> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			query = "select rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select rownum as rown, hospital_name, hospital_address, hospital_tel, location_num from( "
					+ "select  hospital_name, hospital_address, hospital_tel, location_num from hospital "
					+ "order by to_number(location_num)asc)) " + "where location_num = 1 and rown between ? and ?";

			pstmt = connection.prepareStatement(query);

			// ? 값을 set하는 구문
//			System.out.println(pageInfo.getStartList());
//			System.out.println(pageInfo.getEndList());
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Hospital hospital = new Hospital();

				// Hospital 테이블의 컬럼들을 Hospital 객체에 Mapping 하는 구문
				hospital.setRowNum(rs.getInt("rown"));
				hospital.setHospital_Name(rs.getString("hospital_name"));
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

	public List<Hospital> gethType_location(Connection connection, PageInfo pageInfo, String locationName) {
		List<Hospital> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String query=null;
		
		System.out.println(locationName);
		
		query="select rownum, hospital_name, hospital_address, hospital_tel, location_num "
				+ "from hospital ";
		
//		select rownum,hospital_name, hospital_address, hospital_tel, location_num 
//		from hospital 
//		where location_num=2
//		and rownum between 1 and 10;
		
		
		if(locationName!=null) {
			query+="where location_num = ?";
			System.out.println("첫번째 if 문 : "+locationName);
			System.out.println("첫번째 if문 list : "+list);
		}
		query+= "and rownum between ? and ?";
		System.out.println("rownum  list : "+list);
		if(locationName!=null) {
			query+="and location_num = ?";
			System.out.println("두번째 if 문 : "+locationName);
			System.out.println("두번째 if 문  list : "+list);
		}
		try {
			pstmt=connection.prepareStatement(query);
			System.out.println("try list : "+list);
			if(locationName==null) {
				pstmt.setInt(1, pageInfo.getStartList());
				pstmt.setInt(2, pageInfo.getEndList());
				System.out.println("locationName==null : "+list);
			}
			else {
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());
				System.out.println("locationName!=null : "+list);
				
				switch(locationName) {
				case "서울": pstmt.setString(1, "1"); pstmt.setString(4, "1");
					break;
				case "경기": pstmt.setString(1, "2"); pstmt.setString(4, "2");
				break;
				case "대구": pstmt.setString(1, "3"); pstmt.setString(4, "3");
				break;
				case "인천": pstmt.setString(1, "4"); pstmt.setString(4, "4");
				break;
				case "광주": pstmt.setString(1, "5"); pstmt.setString(4, "5");
				break;
				case "대전": pstmt.setString(1, "6"); pstmt.setString(4, "6");
				break;
				case "울산": pstmt.setString(1, "7"); pstmt.setString(4, "7");
				break;
				case "부산": pstmt.setString(1, "8"); pstmt.setString(4, "8");
				break;
				case "강원": pstmt.setString(1, "9"); pstmt.setString(4, "9");
				break;
				case "충남": pstmt.setString(1, "10"); pstmt.setString(4, "10");
				break;
				default : System.out.println("없음");
				break;
				}
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Hospital hospital = new Hospital();
				
				hospital.setRowNum(rs.getInt("rownum"));
				hospital.setHospital_Name(rs.getString("hospital_name"));
				hospital.setHospital_Address(rs.getString("hospital_address"));
				hospital.setHospital_Tel(rs.getString("hospital_tel"));
				hospital.setLocation_Hnum(rs.getString("location_Num"));
				
				list.add(hospital);
			}
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
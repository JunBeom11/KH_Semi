package com.mvc.common.wrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.mvc.common.util.EncryptUtil;



public class EncryptPasswordWrapper extends HttpServletRequestWrapper {

	public EncryptPasswordWrapper(HttpServletRequest request) {
		super(request);
	}
	// HttpServletRequestWrapper 객체에서 재정의 하고 싶은 메소드를 작성한다.
	@Override
	public String getParameter(String name) {
		String value="";
		//Client가 전달하는 값중에 password name 값만 암호화를 처리하고 나머지는 정상적으로 반환
		if(name.equals("Member_Pw")) {
			//암호화 처리후 반환
			value = EncryptUtil.oneWayEnc(super.getParameter(name),"SHA-256");
		}else {
			//정상적으로 반환
			value = super.getParameter(name);
		}
		
		return value;
	}
}

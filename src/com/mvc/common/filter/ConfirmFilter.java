package com.mvc.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName="confirmFilter", servletNames = { "update" })
public class ConfirmFilter extends EncodingFilter {
    public ConfirmFilter() {
    }
    
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession ses = req.getSession();
		String isChecked = (String)ses.getAttribute("isChecked");
		
		if(isChecked == null || isChecked.length()<=0) {
			//비밀번호 재확인 안함
			
			System.out.println("비밀번호 재확인 안됨");
			res.sendRedirect("/inCorona/mypage/checkpw");
			return;
		}
		
		System.out.println("비밀번호 재확인 완료");
		super.doFilter(request,response,chain);
		
		//chain.doFilter(request, response);
		
	}

}

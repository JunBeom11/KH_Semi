package com.mvc.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

@WebFilter(filterName="encodingFilter", urlPatterns="/*")
public class EncodingFilter implements Filter {
	//서블릿 필터는 request, response 가 서블릿이나 JSP등 리소스에 도달하기 전에 필요한 전/후 처리 작업을 한다.
	//서블릿 필터를 FilterChain을 통해서 여러개의 필터를 연속적으로 사용이 가능하다.
    public EncodingFilter() {
      
    }
    // 컨테이너가 필터를 생성할 때 초기화를 위해 호출한다.
    public void init(FilterConfig fConfig) throws ServletException {
    	System.out.println(fConfig.getFilterName()+" 필터가 생성되어 초기화가 진행됨");
	}
    //컨테이너가 현재 요청에 필터를 적용하겠다라고 판단하면 호출한다.
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("chain.doFilter() 위의 코드는 서블릿 동작 전 코드 실행");
		
		HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		
		if(httpServletRequest.getMethod().equals("POST")) {
			request.setCharacterEncoding("UTF-8");
			System.out.println("POST 요청에 대한 UTF-8 인코딩 완료!~");
		}
		
		//다음 필터를 호출하거나, 마지막 필터이면 servlet, JSP를 호출한다.
		chain.doFilter(request, response);
		
		System.out.println("chain.doFilter() 위의 코드는 서블릿 동작 후 코드 실행");
	}
	
	//컨테이너가 인스턴스를 제거할때 호출한다.
	public void destroy() {
		System.out.println("필터가 소멸됨!");
	}
}

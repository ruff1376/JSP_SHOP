package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

public class EncodingFilter implements Filter {
	
	private String encoding; 
		
		// 초기화 
	 	@Override
	    public void init(FilterConfig filterConfig) throws ServletException {
	        // web.xml에 등록된 파라미터 "encoding"가져와 멤버 변수에 저장 
	 		encoding = filterConfig.getInitParameter("encoding");
	    }
	 	
	    @Override
	    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	            throws IOException, ServletException {
	        
	    	// 요청과 응답의 문자 인코딩 설정 
	    	request.setCharacterEncoding(encoding);
	        response.setCharacterEncoding(encoding);
	        
	        // 다음 필터 or 서블릿으로 요청을 전달 
	        chain.doFilter(request, response);
	    }
}








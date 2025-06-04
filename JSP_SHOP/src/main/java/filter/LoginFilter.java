package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

		@Override
	    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
	            throws IOException, ServletException {

			// Servlet -> http로 다운 캐스팅 
	        HttpServletRequest request = (HttpServletRequest) req;
	        HttpServletResponse response = (HttpServletResponse) res;

	        // 쿠키에서 rememberMe, token 값 가져오기 
	        String rememberMe = null;
	        String token = null;

	        Cookie[] cookies = request.getCookies();
	        if (cookies != null) {
	            for (Cookie c : cookies) {
	                if ("rememberMe".equals(c.getName())) {
	                    rememberMe = c.getValue();
	                } else if ("token".equals(c.getName())) {
	                    token = c.getValue();
	                }
	            }
	        }
	        
	        // rememberMe, token 값 확인 및 둘다 존재 시, 자동 로그인 
	        if (rememberMe != null && token != null) {
	            String loginId = getLoginIdByToken(token, request);
	            if (loginId != null) {
	                HttpSession session = request.getSession();
	                session.setAttribute("loginId", loginId);
	            }
	        }
	        // 다음 필터 or 서블릿 전달
	        chain.doFilter(request, response);
	    }
		
	    // 토큰 값 가져오기 
	    private String getLoginIdByToken(String token, ServletRequest request) {
	        String loginId = null;

	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	        	// DB 연결 
	            ServletContext context = request.getServletContext();
	            conn = (Connection) context.getAttribute("conn"); 

	            String sql = "SELECT login_id FROM persistent_logins WHERE token = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, token);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                loginId = rs.getString("login_id");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();  // 오류 추적
	        } 

	        return loginId;
	    }
	
}

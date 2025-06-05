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
import shop.dao.UserRepository;
import shop.dto.User;


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
	        
	        if (rememberMe != null && token != null) {
	            String loginId = getLoginIdByToken(token, request);
	            if (loginId != null) {
	                // ✅ UserRepository를 통해 사용자 정보 조회
	                UserRepository userDAO = UserRepository.getInstance();
	                User loginUser = userDAO.getUserById(loginId);

	                if (loginUser != null) {
	                    HttpSession session = request.getSession();
	                    session.setAttribute("loginId", loginUser.getId());
	                    session.setAttribute("loginUser", loginUser);
	                    session.setAttribute("userId", loginUser.getId()); // 로그인 정보 확인
	                }
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
	                loginId = rs.getString("loginId");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();  // 오류 추적
	        } 

	        return loginId;
	    }
	
}

package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;


@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter implements Filter {
	
	
}

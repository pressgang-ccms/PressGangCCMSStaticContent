package org.jboss.pressgang.ccms;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Set the cache headers.
 */
public class CacheControl implements Filter {
    private static final long ONE_DAY_MS = 86400000L;
    private static final long ONE_YEAR_MS = ONE_DAY_MS * 365;
    
    public void destroy(){

    }

    public void init(FilterConfig config) throws ServletException {

    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
    HttpServletRequest httpRequest = (HttpServletRequest) request;
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    String requestURI = httpRequest.getRequestURI();


    long now = System.currentTimeMillis();
    httpResponse.setDateHeader("Date", now);
    httpResponse.setDateHeader("Expires", now + ONE_YEAR_MS);

      filterChain.doFilter(request, response);
    }
}

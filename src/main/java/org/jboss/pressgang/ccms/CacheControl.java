/*
  Copyright 2011-2014 Red Hat

  This file is part of PresGang CCMS.

  PresGang CCMS is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  PresGang CCMS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with PresGang CCMS.  If not, see <http://www.gnu.org/licenses/>.
*/

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

    public void init(final FilterConfig config) throws ServletException {

    }
    
    public void doFilter(final ServletRequest request, final ServletResponse response,
                         final FilterChain filterChain) throws IOException, ServletException {
        final HttpServletRequest httpRequest = (HttpServletRequest) request;
        final HttpServletResponse httpResponse = (HttpServletResponse) response;
        final String requestURI = httpRequest.getRequestURI();


        final long now = System.currentTimeMillis();
        httpResponse.setDateHeader("Date", now);
        httpResponse.setDateHeader("Expires", now + ONE_YEAR_MS);

        filterChain.doFilter(request, response);
    }
}

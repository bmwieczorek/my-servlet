package com.bawi.servlet;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(value = { "/app/reviews.jsp", "/app/reviews_post_redirect_get.jsp", "/app/login.html", "/app/bank.jsp" })
public class NoCacheFilter implements Filter {
    private static final Logger LOGGER = Logger.getLogger(NoCacheFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("init");
        LOGGER.info("NoCacheFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res;
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies
        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {
        System.out.println("destroy");
        LOGGER.info("Destroyed");
    }

}
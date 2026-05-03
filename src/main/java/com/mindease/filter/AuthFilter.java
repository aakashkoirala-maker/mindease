package com.mindease.filter;

import com.mindease.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        boolean isPublic = path.isEmpty()
                || path.equals("/")
                || path.equals("/login")
                || path.equals("/register")
                || path.equals("/logout")
                || path.equals("/about")
                || path.equals("/about.jsp")
                || path.equals("/index.jsp")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/WEB-INF/views/error/");

        if (isPublic) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        boolean isAdmin = "admin".equals(loggedUser.getRole());

        if (path.startsWith("/admin/") && !isAdmin) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        chain.doFilter(req, res);
    }

    public void init(FilterConfig config) throws ServletException {}
    public void destroy() {}
}
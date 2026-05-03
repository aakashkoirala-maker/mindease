package com.mindease.controller;

import com.mindease.model.User;
import com.mindease.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            User loggedUser = (User) session.getAttribute("loggedUser");
            redirectByRole(loggedUser, request, response);
            return;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberMe".equals(cookie.getName())) {
                    User user = userService.getUserByEmail(cookie.getValue());
                    if (user != null && "active".equals(user.getStatus())) {
                        HttpSession newSession = request.getSession();
                        newSession.setAttribute("loggedUser", user);
                        newSession.setMaxInactiveInterval(30 * 24 * 60 * 60);
                        redirectByRole(user, request, response);
                        return;
                    }
                }
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userService.loginUser(email.trim(), password);

            if (user == null) {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            if ("pending".equals(user.getStatus())) {
                request.setAttribute("error", "Your account is pending admin approval.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            if ("inactive".equals(user.getStatus())) {
                request.setAttribute("error", "Your account has been deactivated.");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            if ("on".equals(request.getParameter("rememberMe"))) {
                Cookie rememberCookie = new Cookie("rememberMe", user.getEmail());
                rememberCookie.setMaxAge(30 * 24 * 60 * 60);
                rememberCookie.setPath("/");
                rememberCookie.setHttpOnly(true);
                rememberCookie.setSecure(false);
                rememberCookie.setAttribute("SameSite", "Lax");
                response.addCookie(rememberCookie);
                session.setMaxInactiveInterval(30 * 24 * 60 * 60);
            } else {
                session.setMaxInactiveInterval(30 * 60);
            }

            redirectByRole(user, request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    private void redirectByRole(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }
}
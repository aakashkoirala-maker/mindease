package com.mindease.controller;

import com.mindease.model.User;
import com.mindease.service.AdminUserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final AdminUserService userService = new AdminUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String status = request.getParameter("status");
        java.util.List<User> users;

        if ("pending".equals(status)) {
            users = userService.getUsersByStatus("pending");
        } else if ("active".equals(status)) {
            users = userService.getUsersByStatus("active");
        } else if ("inactive".equals(status)) {
            users = userService.getUsersByStatus("inactive");
        } else {
            users = userService.getAllUsers();
        }

        request.setAttribute("users", users);
        request.setAttribute("totalAll", userService.getAllUsers().size());
        request.setAttribute("totalPending", userService.getUsersByStatus("pending").size());
        request.setAttribute("totalActive", userService.getUsersByStatus("active").size());
        request.setAttribute("totalInactive", userService.getUsersByStatus("inactive").size());
        request.setAttribute("pageTitle", "Manage Users");
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        int userId = parseInt(request.getParameter("userId"));
        boolean ok = false;

        if (userId > 0) {
            if ("approve".equals(action) || "activate".equals(action)) {
                ok = userService.updateUserStatus(userId, "active");
            } else if ("reject".equals(action) || "deactivate".equals(action)) {
                ok = userService.updateUserStatus(userId, "inactive");
            }
        }

        String redirect = request.getContextPath() + "/admin/users" + (ok ? "?success=true" : "?error=true");
        response.sendRedirect(redirect);
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;
        if (loggedUser == null || !"admin".equals(loggedUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return -1;
        }
    }
}


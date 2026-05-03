package com.mindease.controller;

import com.mindease.model.User;
import com.mindease.service.DashboardService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        // Check if user is logged in and is admin
        if (loggedUser == null || !loggedUser.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int totalUsers = dashboardService.getTotalUsers();
            int totalResources = dashboardService.getTotalResources();
            int totalCounselors = dashboardService.getTotalCounselors();
            int pendingAppointments = dashboardService.getPendingAppointments();
            int newRegistrations = dashboardService.getNewRegistrations();
            int moodLogsToday = dashboardService.getMoodLogsToday();
            int sessionsToday = dashboardService.getSessionsToday();
            List<User> recentUsers = dashboardService.getRecentUsers(6);

            // Set request attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalResources", totalResources);
            request.setAttribute("totalCounselors", totalCounselors);
            request.setAttribute("pendingAppointments", pendingAppointments);
            request.setAttribute("newRegistrations", newRegistrations);
            request.setAttribute("moodLogsToday", moodLogsToday);
            request.setAttribute("sessionsToday", sessionsToday);
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("pageTitle", "Dashboard");

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            // Set error message
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        }
    }
}




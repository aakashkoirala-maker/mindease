package com.mindease.controller;

import com.mindease.model.User;
import com.mindease.service.ReportService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        request.setAttribute("totalUsers", reportService.getTotalUsers());
        request.setAttribute("activeUsers", reportService.getActiveUsers());
        request.setAttribute("pendingUsers", reportService.getPendingUsers());
        request.setAttribute("totalMoodEntries", reportService.getTotalMoodEntries());
        request.setAttribute("avgMoodScore", reportService.getAverageMoodScore());
        request.setAttribute("moodDistribution", reportService.getMoodDistribution());
        request.setAttribute("topCounselors", reportService.getTopCounselors(5));
        request.setAttribute("totalResources", reportService.getTotalResources());
        request.setAttribute("publishedResources", reportService.getPublishedResources());
        request.setAttribute("totalAppointments", reportService.getTotalAppointments());
        request.setAttribute("pageTitle", "Reports");

        request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(request, response);
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
}
package com.mindease.controller;

import com.mindease.model.User;
import com.mindease.service.AppointmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/appointments")
public class AdminAppointmentServlet extends HttpServlet {

    private final AppointmentService appointmentService = new AppointmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        request.setAttribute("appointments", appointmentService.getAllAppointments());
        request.setAttribute("pendingCount", appointmentService.countByStatus("pending"));
        request.setAttribute("approvedCount", appointmentService.countByStatus("approved"));
        request.setAttribute("completedCount", appointmentService.countByStatus("completed"));
        request.setAttribute("rejectedCount", appointmentService.countByStatus("rejected"));
        request.setAttribute("pageTitle", "Appointments");
        request.getRequestDispatcher("/WEB-INF/views/admin/appointments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        int apptId = parseInt(request.getParameter("apptId"));
        boolean ok = false;

        if (apptId > 0) {
            if ("approve".equals(action)) {
                ok = appointmentService.updateAppointmentStatus(apptId, "approved", request.getParameter("notes"));
            } else if ("reject".equals(action)) {
                ok = appointmentService.updateAppointmentStatus(apptId, "rejected", request.getParameter("notes"));
            } else if ("complete".equals(action)) {
                ok = appointmentService.updateAppointmentStatus(apptId, "completed", request.getParameter("notes"));
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/appointments" + (ok ? "?success=true" : "?error=true"));
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


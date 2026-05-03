package com.mindease.service;

import com.mindease.dao.AppointmentDAO;
import com.mindease.model.Appointment;

import java.util.List;

public class AppointmentService {
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    public List<Appointment> getAllAppointments() {
        return appointmentDAO.getAllAppointments();
    }

    public List<Appointment> getAppointmentsByUserId(int userId, String statusFilter) {
        return appointmentDAO.getAppointmentsByUserId(userId, statusFilter);
    }

    public boolean createAppointment(Appointment appointment) {
        return appointmentDAO.createAppointment(appointment);
    }

    public boolean updateAppointmentStatus(int apptId, String status, String notes) {
        return appointmentDAO.updateAppointmentStatus(apptId, status, notes);
    }

    public int getCountByUserId(int userId, String status) {
        return appointmentDAO.getCountByUserId(userId, status);
    }

    public int countByStatus(String status) {
        return appointmentDAO.countByStatus(status);
    }

    public int getPendingAppointmentsCount() {
        return appointmentDAO.getPendingAppointmentsCount();
    }

    public int getTodayApprovedSessionsCount() {
        return appointmentDAO.getTodayApprovedSessionsCount();
    }

    public int getAppointmentsCount(int userId) {
        return appointmentDAO.getAppointmentsCount(userId);
    }

    public List<Appointment> getUpcomingSessions(int userId, int limit) {
        return appointmentDAO.getUpcomingSessions(userId, limit);
    }

    public int getTotalAppointmentsCount() {
        return appointmentDAO.getTotalAppointmentsCount();
    }
}
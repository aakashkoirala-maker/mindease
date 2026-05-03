package com.mindease.dao;

import com.mindease.model.Appointment;
import com.mindease.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public int getPendingAppointmentsCount() {
        String sql = "SELECT COUNT(*) FROM appointments WHERE status = 'pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTodayApprovedSessionsCount() {
        String sql = "SELECT COUNT(*) FROM appointments WHERE DATE(appt_date) = CURDATE() AND status = 'approved'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, u.name AS userName, c.name AS counselorName " +
                "FROM appointments a " +
                "JOIN users u ON a.user_id = u.user_id " +
                "JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "ORDER BY a.appt_date DESC, a.appt_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateAppointmentStatus(int apptId, String status, String notes) {
        String sql = "UPDATE appointments SET status = ?, notes = ? WHERE appt_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, apptId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Appointment> getUpcomingSessions(int userId, int limit) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name AS counselorName, c.specialization " +
                "FROM appointments a " +
                "JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "WHERE a.user_id = ? AND a.status IN ('pending', 'approved') AND a.appt_date >= CURDATE() " +
                "ORDER BY a.appt_date ASC, a.appt_time ASC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getAppointmentsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE user_id = ? AND status != 'rejected'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean createAppointment(Appointment appt) {
        String sql = "INSERT INTO appointments (user_id, counselor_id, appt_date, appt_time, notes, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appt.getUserId());
            ps.setInt(2, appt.getCounselorId());
            ps.setDate(3, appt.getApptDate());
            ps.setTime(4, appt.getApptTime());
            ps.setString(5, appt.getNotes());
            ps.setString(6, appt.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Appointment> getAppointmentsByUserId(int userId, String statusFilter) {
        List<Appointment> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT a.*, c.name AS counselorName, c.specialization " +
                        "FROM appointments a " +
                        "JOIN counselors c ON a.counselor_id = c.counselor_id " +
                        "WHERE a.user_id = ? ");
        boolean withStatus = statusFilter != null && !statusFilter.isBlank() && !"all".equalsIgnoreCase(statusFilter);
        if (withStatus) sql.append("AND a.status = ? ");
        sql.append("ORDER BY a.appt_date DESC, a.appt_time DESC");
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            ps.setInt(1, userId);
            if (withStatus) ps.setString(2, statusFilter);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapAppointment(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getCountByUserId(int userId, String status) {
        boolean all = status == null || status.isBlank() || "all".equalsIgnoreCase(status);
        String sql = all
                ? "SELECT COUNT(*) FROM appointments WHERE user_id = ?"
                : "SELECT COUNT(*) FROM appointments WHERE user_id = ? AND status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            if (!all) ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalAppointmentsCount() {
        String sql = "SELECT COUNT(*) FROM appointments";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Appointment mapAppointment(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setApptId(rs.getInt("appt_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setCounselorId(rs.getInt("counselor_id"));
        a.setApptDate(rs.getDate("appt_date"));
        a.setApptTime(rs.getTime("appt_time"));
        a.setStatus(rs.getString("status"));
        a.setNotes(rs.getString("notes"));
        try { a.setUserName(rs.getString("userName")); } catch (SQLException ignored) {}
        try { a.setCounselorName(rs.getString("counselorName")); } catch (SQLException ignored) {}
        try { a.setCounselorSpecialization(rs.getString("specialization")); } catch (SQLException ignored) {}
        return a;
    }
}
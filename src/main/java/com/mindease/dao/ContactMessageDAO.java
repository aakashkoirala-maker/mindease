package com.mindease.dao;

import com.mindease.model.ContactMessage;
import com.mindease.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    public int createMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (user_id, category, subject, message, status) VALUES (?, ?, ?, ?, 'pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, msg.getUserId());
            ps.setString(2, msg.getCategory());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<ContactMessage> getMessagesByUserId(int userId) {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapMessage(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ContactMessage getMessageById(int messageId) {
        String sql = "SELECT cm.*, u.name AS userName, u.email AS userEmail FROM contact_messages cm " +
                "JOIN users u ON cm.user_id = u.user_id WHERE cm.message_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapMessage(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT cm.*, u.name AS userName, u.email AS userEmail FROM contact_messages cm " +
                "JOIN users u ON cm.user_id = u.user_id ORDER BY cm.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapMessage(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean replyToMessage(int messageId, String adminReply) {
        String sql = "UPDATE contact_messages SET admin_reply = ?, status = 'replied', replied_at = NOW() WHERE message_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, adminReply);
            ps.setInt(2, messageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private ContactMessage mapMessage(ResultSet rs) throws SQLException {
        ContactMessage msg = new ContactMessage();
        msg.setMessageId(rs.getInt("message_id"));
        msg.setUserId(rs.getInt("user_id"));
        msg.setCategory(rs.getString("category"));
        msg.setSubject(rs.getString("subject"));
        msg.setMessage(rs.getString("message"));
        msg.setStatus(rs.getString("status"));
        msg.setAdminReply(rs.getString("admin_reply"));
        msg.setCreatedAt(rs.getTimestamp("created_at"));
        msg.setRepliedAt(rs.getTimestamp("replied_at"));
        try {
            msg.setUserName(rs.getString("userName"));
        } catch (SQLException e) {
            e.printStackTrace();
            msg.setUserName(null);
        }
        try {
            msg.setUserEmail(rs.getString("userEmail"));
        } catch (SQLException e) {
            e.printStackTrace();
            msg.setUserEmail(null);
        }
        return msg;
    }
}


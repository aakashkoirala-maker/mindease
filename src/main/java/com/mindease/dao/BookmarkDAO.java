package com.mindease.dao;

import com.mindease.model.Resource;
import com.mindease.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookmarkDAO {

    public int getSavedResourcesCount(int userId) {
        String sql = "SELECT COUNT(*) FROM bookmarks WHERE user_id = ?";
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

    public List<Resource> getSavedResources(int userId, int limit) {
        List<Resource> list = new ArrayList<>();
        String sql = "SELECT r.*, c.name AS categoryName " +
                "FROM bookmarks b " +
                "JOIN resources r ON b.resource_id = r.resource_id " +
                "LEFT JOIN categories c ON r.category_id = c.category_id " +
                "WHERE b.user_id = ? AND r.status = 'published' " +
                "ORDER BY b.saved_at DESC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Resource resource = new Resource();
                resource.setResourceId(rs.getInt("resource_id"));
                resource.setTitle(rs.getString("title"));
                resource.setDescription(rs.getString("description"));
                resource.setUrl(rs.getString("url"));
                resource.setCategoryName(rs.getString("categoryName"));
                resource.setStatus(rs.getString("status"));
                list.add(resource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Integer> getBookmarkedResourceIdsByUserId(int userId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT resource_id FROM bookmarks WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ids.add(rs.getInt("resource_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ids;
    }

    public List<Resource> getBookmarkedResourcesByUserId(int userId) {
        String sql = "SELECT r.*, c.name AS categoryName, c.color_code AS color_code, u.name AS authorName " +
                "FROM bookmarks b " +
                "JOIN resources r ON b.resource_id = r.resource_id " +
                "LEFT JOIN categories c ON r.category_id = c.category_id " +
                "LEFT JOIN users u ON r.added_by = u.user_id " +
                "WHERE b.user_id = ? AND r.status = 'published' " +
                "ORDER BY b.saved_at DESC";

        List<Resource> resources = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Resource r = new Resource();
                r.setResourceId(rs.getInt("resource_id"));
                r.setTitle(rs.getString("title"));
                r.setDescription(rs.getString("description"));
                r.setCategoryId(rs.getInt("category_id"));
                r.setCategoryName(rs.getString("categoryName"));

                String colorCode = rs.getString("color_code");
                r.setColorCode((colorCode == null || colorCode.isBlank()) ? "#ede9fe" : colorCode);

                try {
                    r.setImageUrl(rs.getString("image_url"));
                } catch (SQLException e) {
                    e.printStackTrace();
                    r.setImageUrl(null);
                }

                String readTime;
                try {
                    readTime = rs.getString("read_time");
                } catch (SQLException e) {
                    e.printStackTrace();
                    readTime = null;
                }
                r.setReadTime((readTime == null || readTime.isBlank()) ? "5 min read" : readTime);

                try {
                    r.setTags(rs.getString("tags"));
                } catch (SQLException e) {
                    e.printStackTrace();
                    r.setTags(null);
                }

                String authorName = rs.getString("authorName");
                r.setAuthorName((authorName == null || authorName.isBlank()) ? "Unknown" : authorName);
                resources.add(r);
            }
            return resources;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean addBookmark(int userId, int resourceId) {
        String sql = "INSERT IGNORE INTO bookmarks (user_id, resource_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, resourceId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeBookmark(int userId, int resourceId) {
        String sql = "DELETE FROM bookmarks WHERE user_id = ? AND resource_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, resourceId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}


package com.mindease.dao;

import com.mindease.model.MoodTag;
import com.mindease.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MoodTagDAO {

    public List<MoodTag> getAllTags() {
        List<MoodTag> tags = new ArrayList<>();
        String sql = "SELECT tag_id, tag_name FROM mood_tags ORDER BY tag_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                MoodTag tag = new MoodTag();
                tag.setTagId(rs.getInt("tag_id"));
                tag.setTagName(rs.getString("tag_name"));
                tags.add(tag);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tags;
    }

    public void saveEntryTags(int entryId, List<Integer> tagIds) {
        if (tagIds == null || tagIds.isEmpty()) {
            return;
        }

        String sql = "INSERT INTO mood_entry_tags (entry_id, tag_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (Integer tagId : tagIds) {
                if (tagId == null) {
                    continue;
                }
                ps.setInt(1, entryId);
                ps.setInt(2, tagId);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEntryTags(int entryId) {
        String sql = "DELETE FROM mood_entry_tags WHERE entry_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, entryId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<String> getTagsByEntryId(int entryId) {
        List<String> tags = new ArrayList<>();
        String sql = "SELECT mt.tag_name FROM mood_entry_tags met " +
                "JOIN mood_tags mt ON met.tag_id = mt.tag_id " +
                "WHERE met.entry_id = ? ORDER BY mt.tag_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, entryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tags.add(rs.getString("tag_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tags;
    }
}


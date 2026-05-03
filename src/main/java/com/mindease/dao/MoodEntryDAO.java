package com.mindease.dao;

import com.mindease.model.MoodEntry;
import com.mindease.model.WeeklyMood;
import com.mindease.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MoodEntryDAO {

    public int getTodayMoodEntriesCount() {
        String sql = "SELECT COUNT(*) FROM mood_entries WHERE DATE(entry_date) = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalMoodEntriesCount() {
        String sql = "SELECT COUNT(*) FROM mood_entries";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getAverageMoodScore() {
        String sql = "SELECT ROUND(AVG(mood_score), 1) FROM mood_entries";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<Integer, Integer> getMoodDistribution() {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 1; i <= 5; i++) map.put(i, 0);
        String sql = "SELECT mood_score, COUNT(*) AS cnt FROM mood_entries GROUP BY mood_score ORDER BY mood_score";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) map.put(rs.getInt("mood_score"), rs.getInt("cnt"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    public int getMoodStreak(int userId) {
        String sql = "SELECT DISTINCT entry_date FROM mood_entries WHERE user_id = ? ORDER BY entry_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            int streak = 0;
            Date prevDate = null;
            while (rs.next()) {
                Date current = rs.getDate("entry_date");
                if (prevDate == null) {
                    streak++;
                    prevDate = current;
                    continue;
                }
                long diffDays = (prevDate.getTime() - current.getTime()) / (1000L * 60 * 60 * 24);
                if (diffDays == 1) {
                    streak++;
                    prevDate = current;
                } else {
                    break;
                }
            }
            return streak;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalCountByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM mood_entries WHERE user_id = ?";
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

    public double getAverageScoreByUserId(int userId) {
        String sql = "SELECT ROUND(AVG(mood_score), 1) FROM mood_entries WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public int getPositiveDaysCount(int userId) {
        String sql = "SELECT COUNT(*) FROM mood_entries WHERE user_id = ? AND mood_score >= 4";
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

    public String getBestDayByUserId(int userId) {
        String sql = "SELECT DATE_FORMAT(entry_date, '%b %d') AS bestDay " +
                "FROM mood_entries WHERE user_id = ? " +
                "ORDER BY mood_score DESC, entry_date DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("bestDay");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<MoodEntry> getAllByUserId(int userId) {
        List<MoodEntry> entries = new ArrayList<>();
        String sql = "SELECT entry_id, user_id, mood_score, note, entry_date " +
                "FROM mood_entries WHERE user_id = ? ORDER BY entry_date DESC, entry_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) entries.add(mapEntry(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entries;
    }

    public List<WeeklyMood> getWeeklyMoodData(int userId) {
        List<WeeklyMood> list = new ArrayList<>();
        String sql = "SELECT DATE(entry_date) AS date, ROUND(AVG(mood_score)) AS mood_score FROM mood_entries " +
                "WHERE user_id = ? " +
                "AND entry_date >= DATE_SUB(CURDATE(), INTERVAL (DAYOFWEEK(CURDATE()) - 1) DAY) " +
                "AND entry_date < DATE_ADD(DATE_SUB(CURDATE(), INTERVAL (DAYOFWEEK(CURDATE()) - 1) DAY), INTERVAL 7 DAY) " +
                "GROUP BY DATE(entry_date) ORDER BY DATE(entry_date) ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WeeklyMood mood = new WeeklyMood();
                mood.setDate(rs.getDate("date"));

                int score = rs.getInt("mood_score");
                mood.setMoodScore(score);

                // barHeight: proportional to 160px max
                int barHeight = (int) Math.round((score / 5.0) * 160);
                if (barHeight < 10) barHeight = 10; // minimum visible
                mood.setBarHeight(barHeight);

                // dayLabel from date
                java.time.LocalDate localDate = rs.getDate("date").toLocalDate();
                String dayLabel = localDate.getDayOfWeek()
                        .getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.ENGLISH);
                mood.setDayLabel(dayLabel);

                // moodLabel
                String[] labels = {"", "Very Low", "Low", "Neutral", "Good", "Great"};
                mood.setMoodLabel(score >= 1 && score <= 5 ? labels[score] : "Unknown");

                list.add(mood);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public MoodEntry getTodayMood(int userId) {
        return getTodayEntry(userId);
    }

    public boolean hasTodayEntry(int userId) {
        String sql = "SELECT 1 FROM mood_entries WHERE user_id = ? AND entry_date = CURDATE() LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int insert(MoodEntry entry) {
        String sql = "INSERT INTO mood_entries (user_id, mood_score, note, entry_date) VALUES (?, ?, ?, ?)";
        Date entryDate = entry.getEntryDate() != null ? entry.getEntryDate() : Date.valueOf(java.time.LocalDate.now());
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, entry.getUserId());
            ps.setInt(2, entry.getScore());
            ps.setString(3, entry.getNote());
            ps.setDate(4, entryDate);
            if (ps.executeUpdate() == 0) return 0;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int update(MoodEntry entry) {
        String sql = "UPDATE mood_entries SET mood_score = ?, note = ? WHERE user_id = ? AND entry_date = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, entry.getScore());
            ps.setString(2, entry.getNote());
            ps.setInt(3, entry.getUserId());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<MoodEntry> getRecentByUserId(int userId, int limit) {
        List<MoodEntry> entries = new ArrayList<>();
        String sql = "SELECT me.entry_id, me.user_id, me.mood_score, me.note, me.entry_date, " +
                "GROUP_CONCAT(mt.tag_name ORDER BY mt.tag_name SEPARATOR ',') AS tag_names " +
                "FROM mood_entries me " +
                "LEFT JOIN mood_entry_tags met ON me.entry_id = met.entry_id " +
                "LEFT JOIN mood_tags mt ON met.tag_id = mt.tag_id " +
                "WHERE me.user_id = ? " +
                "GROUP BY me.entry_id, me.user_id, me.mood_score, me.note, me.entry_date " +
                "ORDER BY me.entry_date DESC, me.entry_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MoodEntry entry = mapEntry(rs);
                entry.setTags(parseTagNames(rs.getString("tag_names")));
                entries.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entries;
    }

    public MoodEntry getTodayEntry(int userId) {
        String sql = "SELECT entry_id, user_id, mood_score, note, entry_date " +
                "FROM mood_entries WHERE user_id = ? AND entry_date = CURDATE() LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                MoodEntry entry = mapEntry(rs);
                entry.setTags(getTagsForEntry(entry.getEntryId(), conn));
                return entry;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean upsertTodayMood(int userId, int score, String note) {
        MoodEntry entry = new MoodEntry();
        entry.setUserId(userId);
        entry.setScore(score);
        entry.setNote(note == null ? "" : note.trim());
        if (hasTodayEntry(userId)) return update(entry) > 0;
        return insert(entry) > 0;
    }

    private MoodEntry mapEntry(ResultSet rs) throws SQLException {
        MoodEntry entry = new MoodEntry();
        entry.setEntryId(rs.getInt("entry_id"));
        entry.setUserId(rs.getInt("user_id"));
        entry.setScore(rs.getInt("mood_score"));
        entry.setNote(rs.getString("note"));
        entry.setEntryDate(rs.getDate("entry_date"));
        return entry;
    }

    private List<String> parseTagNames(String tagNames) {
        List<String> tags = new ArrayList<>();
        if (tagNames == null || tagNames.isBlank()) return tags;
        for (String raw : tagNames.split(",")) {
            String tag = raw.trim();
            if (!tag.isEmpty()) tags.add(tag);
        }
        return tags;
    }

    private List<String> getTagsForEntry(int entryId, Connection conn) throws SQLException {
        List<String> tags = new ArrayList<>();
        String sql = "SELECT mt.tag_name FROM mood_entry_tags met " +
                "JOIN mood_tags mt ON met.tag_id = mt.tag_id " +
                "WHERE met.entry_id = ? ORDER BY mt.tag_name";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, entryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) tags.add(rs.getString("tag_name"));
        }
        return tags;
    }
}
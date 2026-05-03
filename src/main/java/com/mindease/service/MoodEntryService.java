package com.mindease.service;

import com.mindease.dao.MoodEntryDAO;
import com.mindease.dao.MoodTagDAO;
import com.mindease.model.MoodEntry;
import com.mindease.model.MoodTag;
import com.mindease.model.WeeklyMood;

import java.util.List;
import java.util.Map;

public class MoodEntryService {
    private final MoodEntryDAO moodEntryDAO = new MoodEntryDAO();
    private final MoodTagDAO moodTagDAO = new MoodTagDAO();

    public int getTotalCountByUserId(int userId) {
        return moodEntryDAO.getTotalCountByUserId(userId);
    }

    public double getAverageScoreByUserId(int userId) {
        return moodEntryDAO.getAverageScoreByUserId(userId);
    }

    public int getPositiveDaysCount(int userId) {
        return moodEntryDAO.getPositiveDaysCount(userId);
    }

    public String getBestDayByUserId(int userId) {
        return moodEntryDAO.getBestDayByUserId(userId);
    }

    public List<MoodEntry> getRecentByUserId(int userId, int limit) {
        return moodEntryDAO.getRecentByUserId(userId, limit);
    }

    public List<MoodEntry> getAllByUserId(int userId) {
        return moodEntryDAO.getAllByUserId(userId);
    }

    public boolean insertOrUpdateMood(MoodEntry entry) {
        if (moodEntryDAO.hasTodayEntry(entry.getUserId())) {
            return moodEntryDAO.update(entry) > 0;
        }
        return moodEntryDAO.insert(entry) > 0;
    }

    public MoodEntry getTodayEntry(int userId) {
        return moodEntryDAO.getTodayEntry(userId);
    }

    public MoodEntry getTodayMood(int userId) {
        return moodEntryDAO.getTodayMood(userId);
    }

    public boolean hasTodayEntry(int userId) {
        return moodEntryDAO.hasTodayEntry(userId);
    }

    public int insert(MoodEntry entry) {
        return moodEntryDAO.insert(entry);
    }

    public int update(MoodEntry entry) {
        return moodEntryDAO.update(entry);
    }

    public List<MoodTag> getAllTags() {
        return moodTagDAO.getAllTags();
    }

    public void replaceEntryTags(int entryId, List<Integer> tagIds) {
        moodTagDAO.deleteEntryTags(entryId);
        moodTagDAO.saveEntryTags(entryId, tagIds);
    }

    public int getMoodStreak(int userId) {
        return moodEntryDAO.getMoodStreak(userId);
    }

    // Fixed: was calling deleted getTotalLogs — now uses getTotalCountByUserId
    public int getTotalLogs(int userId) {
        return moodEntryDAO.getTotalCountByUserId(userId);
    }

    // Fixed: was calling deleted getAvgScore — now uses getAverageScoreByUserId
    public double getAvgMoodScore(int userId) {
        return moodEntryDAO.getAverageScoreByUserId(userId);
    }

    public List<WeeklyMood> getWeeklyMoodData(int userId) {
        return moodEntryDAO.getWeeklyMoodData(userId);
    }

    public int getTodayMoodEntriesCount() {
        return moodEntryDAO.getTodayMoodEntriesCount();
    }

    public int getTotalMoodEntriesCount() {
        return moodEntryDAO.getTotalMoodEntriesCount();
    }

    public double getAverageMoodScore() {
        return moodEntryDAO.getAverageMoodScore();
    }

    public Map<Integer, Integer> getMoodDistribution() {
        return moodEntryDAO.getMoodDistribution();
    }
}
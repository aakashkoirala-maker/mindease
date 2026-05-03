package com.mindease.service;

import com.mindease.model.Appointment;
import com.mindease.model.MoodEntry;
import com.mindease.model.Resource;
import com.mindease.model.User;
import com.mindease.model.WeeklyMood;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class DashboardService {
    private final MoodEntryService moodEntryService = new MoodEntryService();
    private final BookmarkService bookmarkService = new BookmarkService();
    private final AppointmentService appointmentService = new AppointmentService();
    private final AdminUserService adminUserService = new AdminUserService();
    private final ResourceService resourceService = new ResourceService();
    private final CounselorService counselorService = new CounselorService();

    public int getMoodStreak(int userId) {
        return moodEntryService.getMoodStreak(userId);
    }

    public int getTotalLogs(int userId) {
        return moodEntryService.getTotalLogs(userId);
    }

    public int getSavedResourcesCount(int userId) {
        return bookmarkService.getSavedResourcesCount(userId);
    }

    public int getAppointmentsCount(int userId) {
        return appointmentService.getAppointmentsCount(userId);
    }

    public double getAvgMoodScore(int userId) {
        return moodEntryService.getAvgMoodScore(userId);
    }

    public MoodEntry getTodayMood(int userId) {
        return moodEntryService.getTodayMood(userId);
    }

    public List<WeeklyMood> getWeeklyMoodData(int userId) {
        return moodEntryService.getWeeklyMoodData(userId);
    }

    public List<MoodEntry> getRecentMoodEntries(int userId, int limit) {
        return moodEntryService.getRecentByUserId(userId, limit);
    }

    public List<WeeklyMood> buildSevenDayChartData(List<WeeklyMood> source) {
        Map<LocalDate, Integer> byDate = new HashMap<>();
        for (WeeklyMood mood : source) {
            if (mood.getDate() != null) {
                byDate.put(mood.getDate().toLocalDate(), mood.getMoodScore());
            }
        }

        List<WeeklyMood> chart = new ArrayList<>();
        LocalDate today = LocalDate.now();
        LocalDate start = today.minusDays(today.getDayOfWeek().getValue() % 7L);
        for (int i = 0; i < 7; i++) {
            LocalDate day = start.plusDays(i);
            int score = byDate.getOrDefault(day, 0);
            WeeklyMood item = new WeeklyMood();
            item.setDate(Date.valueOf(day));
            item.setMoodScore(score);
            item.setDayLabel(day.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.ENGLISH));
            item.setBarHeight(getBarHeight(score));
            item.setMoodLabel(getMoodLabel(score));
            chart.add(item);
        }
        return chart;
    }

    private int getBarHeight(int score) {
        return score > 0 ? 26 + (score * 28) : 10;
    }

    private String getMoodLabel(int score) {
        return switch (score) {
            case 1 -> "Very Low";
            case 2 -> "Low";
            case 3 -> "Neutral";
            case 4 -> "Good";
            case 5 -> "Great";
            default -> "No Log";
        };
    }

    public List<Appointment> getUpcomingSessions(int userId, int limit) {
        return appointmentService.getUpcomingSessions(userId, limit);
    }

    public List<Resource> getSavedResources(int userId, int limit) {
        return bookmarkService.getSavedResources(userId, limit);
    }

    public int getTotalUsers() {
        return adminUserService.getTotalUsers();
    }

    public int getTotalResources() {
        return resourceService.getTotalResourcesCount();
    }

    public int getTotalCounselors() {
        return counselorService.getActiveCounselorsCount();
    }

    public int getPendingAppointments() {
        return appointmentService.getPendingAppointmentsCount();
    }

    public int getNewRegistrations() {
        return adminUserService.getTodayRegistrationsCount();
    }

    public int getMoodLogsToday() {
        return moodEntryService.getTodayMoodEntriesCount();
    }

    public int getSessionsToday() {
        return appointmentService.getTodayApprovedSessionsCount();
    }

    public List<User> getRecentUsers(int limit) {
        return adminUserService.getRecentUsers(limit);
    }
}
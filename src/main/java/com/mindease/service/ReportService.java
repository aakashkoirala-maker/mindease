package com.mindease.service;

import java.util.List;
import java.util.Map;

public class ReportService {
    private final AdminUserService adminUserService = new AdminUserService();
    private final MoodEntryService moodEntryService = new MoodEntryService();
    private final CounselorService counselorService = new CounselorService();
    private final ResourceService resourceService = new ResourceService();
    private final AppointmentService appointmentService = new AppointmentService();

    public int getTotalUsers() {
        return adminUserService.getTotalUsers();
    }

    public int getActiveUsers() {
        return adminUserService.getActiveUsersCount();
    }

    public int getPendingUsers() {
        return adminUserService.getPendingUsersCount();
    }

    public int getTotalMoodEntries() {
        return moodEntryService.getTotalMoodEntriesCount();
    }

    public double getAverageMoodScore() {
        return moodEntryService.getAverageMoodScore();
    }

    public Map<Integer, Integer> getMoodDistribution() {
        return moodEntryService.getMoodDistribution();
    }

    public List<Object[]> getTopCounselors(int limit) {
        return counselorService.getTopCounselors(limit);
    }

    public int getTotalResources() {
        return resourceService.getTotalResourcesCount();
    }

    public int getPublishedResources() {
        return resourceService.getPublishedResourcesCount();
    }

    public int getTotalAppointments() {
        return appointmentService.getTotalAppointmentsCount();
    }
}
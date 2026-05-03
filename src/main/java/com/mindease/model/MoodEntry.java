package com.mindease.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MoodEntry {

    private int entryId;
    private int userId;
    private int moodScore;
    private String note;
    private Date entryDate;
    private Timestamp createdAt;
    private List<String> tags = new ArrayList<>();

    public MoodEntry() {}

    public int getEntryId() { return entryId; }
    public void setEntryId(int entryId) { this.entryId = entryId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getMoodScore() { return moodScore; }
    public void setMoodScore(int moodScore) { this.moodScore = moodScore; }

    public int getScore() { return moodScore; }
    public void setScore(int score) { this.moodScore = score; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Date getEntryDate() { return entryDate; }
    public void setEntryDate(Date entryDate) { this.entryDate = entryDate; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public List<String> getTags() { return tags; }
    public void setTags(List<String> tags) { this.tags = tags; }
}


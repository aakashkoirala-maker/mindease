package com.mindease.model;

import java.sql.Date;
import java.sql.Time;

public class Appointment {

    private int apptId;
    private int userId;
    private int counselorId;
    private Date apptDate;
    private Time apptTime;
    private String status;
    private String notes;
    private String userName;
    private String counselorName;
    private String counselorSpecialization;

    public Appointment() {}

    public int getApptId() { return apptId; }
    public void setApptId(int apptId) { this.apptId = apptId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCounselorId() { return counselorId; }
    public void setCounselorId(int counselorId) { this.counselorId = counselorId; }

    public Date getApptDate() { return apptDate; }
    public void setApptDate(Date apptDate) { this.apptDate = apptDate; }

    public Time getApptTime() { return apptTime; }
    public void setApptTime(Time apptTime) { this.apptTime = apptTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getCounselorName() { return counselorName; }
    public void setCounselorName(String counselorName) { this.counselorName = counselorName; }

    public String getCounselorSpecialization() { return counselorSpecialization; }
    public void setCounselorSpecialization(String counselorSpecialization) { this.counselorSpecialization = counselorSpecialization; }
}


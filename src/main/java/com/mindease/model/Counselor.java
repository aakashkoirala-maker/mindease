package com.mindease.model;

public class Counselor {

    private int counselorId;
    private String name;
    private String specialization;
    private String email;
    private String phone;
    private String availableDays;
    private String status;

    public Counselor() {}

    public int getCounselorId() { return counselorId; }
    public void setCounselorId(int counselorId) { this.counselorId = counselorId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}


package com.mindease.service;

import com.mindease.dao.CounselorDAO;
import com.mindease.model.Counselor;

import java.util.List;

public class CounselorService {
    private final CounselorDAO counselorDAO = new CounselorDAO();

    public List<Counselor> getAllCounselors() {
        return counselorDAO.getAllCounselors();
    }

    public List<Counselor> getAllActiveCounselors() {
        return counselorDAO.getAllActiveCounselors();
    }

    public Counselor getCounselorById(int id) {
        return counselorDAO.getCounselorById(id);
    }

    public boolean createCounselor(Counselor counselor) {
        return counselorDAO.createCounselor(counselor);
    }

    public boolean updateCounselor(Counselor counselor) {
        return counselorDAO.updateCounselor(counselor);
    }

    public boolean deactivateCounselor(int id) {
        return counselorDAO.deactivateCounselor(id);
    }

    public boolean activateCounselor(int id) {
        return counselorDAO.activateCounselor(id);
    }

    public int getActiveCounselorsCount() {
        return counselorDAO.getActiveCounselorsCount();
    }

    public List<Object[]> getTopCounselors(int limit) {
        return counselorDAO.getTopCounselors(limit);
    }
}


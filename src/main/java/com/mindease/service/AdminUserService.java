package com.mindease.service;

import com.mindease.dao.UserDAO;
import com.mindease.model.User;

import java.util.List;

public class AdminUserService {
    private final UserDAO userDAO = new UserDAO();

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<User> getUsersByStatus(String status) {
        return userDAO.getUsersByStatus(status);
    }

    public boolean updateUserStatus(int userId, String status) {
        return userDAO.updateUserStatus(userId, status);
    }

    public int getTotalUsers() {
        return userDAO.getTotalUsers();
    }

    public int getTodayRegistrationsCount() {
        return userDAO.getTodayRegistrationsCount();
    }

    public int getActiveUsersCount() {
        return userDAO.getActiveUsersCount();
    }

    public int getPendingUsersCount() {
        return userDAO.getPendingUsersCount();
    }

    public List<User> getRecentUsers(int limit) {
        return userDAO.getRecentUsers(limit);
    }
}


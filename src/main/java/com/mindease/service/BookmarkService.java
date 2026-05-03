package com.mindease.service;

import com.mindease.dao.BookmarkDAO;
import com.mindease.model.Resource;

import java.util.List;

public class BookmarkService {
    private final BookmarkDAO bookmarkDAO = new BookmarkDAO();

    public List<Integer> getBookmarkedResourceIdsByUserId(int userId) {
        return bookmarkDAO.getBookmarkedResourceIdsByUserId(userId);
    }

    public List<Resource> getBookmarkedResourcesByUserId(int userId) {
        return bookmarkDAO.getBookmarkedResourcesByUserId(userId);
    }

    public boolean addBookmark(int userId, int resourceId) {
        return bookmarkDAO.addBookmark(userId, resourceId);
    }

    public boolean removeBookmark(int userId, int resourceId) {
        return bookmarkDAO.removeBookmark(userId, resourceId);
    }

    public int getSavedResourcesCount(int userId) {
        return bookmarkDAO.getSavedResourcesCount(userId);
    }

    public List<Resource> getSavedResources(int userId, int limit) {
        return bookmarkDAO.getSavedResources(userId, limit);
    }
}


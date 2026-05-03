package com.mindease.service;

import com.mindease.dao.BookmarkDAO;
import com.mindease.dao.CategoryDAO;
import com.mindease.dao.ResourceDAO;
import com.mindease.model.Category;
import com.mindease.model.Resource;

import java.util.List;

public class ResourceService {

    private final ResourceDAO resourceDAO = new ResourceDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BookmarkDAO bookmarkDAO = new BookmarkDAO();

    public List<Resource> getAllResources() {
        return resourceDAO.getAllResources();
    }

    public List<Resource> getFilteredResources(String search, Integer categoryId, String status) {
        return resourceDAO.getFilteredResources(search, categoryId, status);
    }

    public List<Resource> getPublishedResources(String searchQuery, String categoryId, String page, int limit) {
        return resourceDAO.getPublishedResources(searchQuery, categoryId, page, limit);
    }

    public Resource getResourceById(int id) {
        return resourceDAO.getResourceById(id);
    }

    public int createResource(Resource resource) {
        return resourceDAO.createResource(resource);
    }

    public boolean updateResource(Resource resource) {
        return resourceDAO.updateResource(resource);
    }

    public boolean deleteResource(int id) {
        return resourceDAO.deleteResource(id);
    }

    public boolean updateStatus(int id, String status) {
        return resourceDAO.updateStatus(id, status);
    }

    public int getPublishedResourcesCount(String searchQuery, String categoryId) {
        return resourceDAO.getPublishedResourcesCount(searchQuery, categoryId);
    }

    public int getTotalResourcesCount() {
        return resourceDAO.getTotalResourcesCount();
    }

    public int getPublishedResourcesCount() {
        return resourceDAO.getPublishedResourcesCount();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public List<Integer> getBookmarkedResourceIdsByUserId(int userId) {
        return bookmarkDAO.getBookmarkedResourceIdsByUserId(userId);
    }

    public String validateResource(Resource resource) {
        if (resource == null) {
            return "Invalid resource data.";
        }
        if (resource.getTitle() == null || resource.getTitle().trim().isEmpty()) {
            return "Title is required.";
        }
        if (resource.getUrl() == null || resource.getUrl().trim().isEmpty()) {
            return "Resource URL is required.";
        }

        String url = resource.getUrl().trim().toLowerCase();
        if (!url.startsWith("http://") && !url.startsWith("https://")) {
            return "URL must start with http:// or https://";
        }

        if (resource.getImageUrl() != null && !resource.getImageUrl().trim().isEmpty()) {
            String imageUrl = resource.getImageUrl().trim().toLowerCase();
            if (!imageUrl.startsWith("http://") && !imageUrl.startsWith("https://")) {
                return "Image URL must start with http:// or https://";
            }
        }

        return null;
    }

    public void normalizeResource(Resource resource) {
        if (resource == null) {
            return;
        }

        resource.setTitle(trimToNull(resource.getTitle()));
        resource.setDescription(trimToNull(resource.getDescription()));
        resource.setUrl(trimToNull(resource.getUrl()));
        resource.setImageUrl(trimToNull(resource.getImageUrl()));
        resource.setReadTime(trimToNull(resource.getReadTime()));
        resource.setTags(normalizeTags(resource.getTags()));

        String status = trimToNull(resource.getStatus());
        if (status == null || (!"published".equalsIgnoreCase(status) && !"draft".equalsIgnoreCase(status))) {
            resource.setStatus("draft");
        } else {
            resource.setStatus(status.toLowerCase());
        }

        if (resource.getReadTime() == null) {
            resource.setReadTime("5 min read");
        }
    }

    private String normalizeTags(String tags) {
        String cleaned = trimToNull(tags);
        if (cleaned == null) {
            return null;
        }

        String[] parts = cleaned.split(",");
        StringBuilder builder = new StringBuilder();
        for (String part : parts) {
            String item = trimToNull(part);
            if (item == null) {
                continue;
            }
            if (builder.length() > 0) {
                builder.append(", ");
            }
            builder.append(item);
        }
        return builder.length() == 0 ? null : builder.toString();
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}


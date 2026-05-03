package com.mindease.service;

import com.mindease.dao.CategoryDAO;
import com.mindease.model.Category;

public class CategoryService {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    public String addCategory(String name, String description) {
        if (name == null || name.trim().isEmpty()) {
            return "Category name is required.";
        }
        Category c = new Category();
        c.setName(name.trim());
        c.setDescription(description == null ? "" : description.trim());
        return categoryDAO.createCategory(c) ? "success" : "Failed to create category.";
    }

    public String updateCategory(int categoryId, String name, String description) {
        if (name == null || name.trim().isEmpty()) {
            return "Category name is required.";
        }
        Category c = new Category();
        c.setCategoryId(categoryId);
        c.setName(name.trim());
        c.setDescription(description == null ? "" : description.trim());
        return categoryDAO.updateCategory(c) ? "success" : "Failed to update category.";
    }

    public boolean deleteCategory(int id) {
        return categoryDAO.deleteCategory(id);
    }
}


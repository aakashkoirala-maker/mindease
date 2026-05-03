package com.mindease.controller;

import com.mindease.dao.CategoryDAO;
import com.mindease.model.User;
import com.mindease.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        String editId = request.getParameter("editId");
        if (editId != null && !editId.isBlank()) {
            request.setAttribute("editCategory", categoryDAO.getCategoryById(parseInt(editId)));
        }

        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("pageTitle", "Manage Categories");
        request.getRequestDispatcher("/WEB-INF/views/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        String result = "Failed";

        if ("create".equals(action)) {
            result = categoryService.addCategory(request.getParameter("name"), request.getParameter("description"));
        } else if ("update".equals(action)) {
            int id = parseInt(request.getParameter("categoryId"));
            result = categoryService.updateCategory(id, request.getParameter("name"), request.getParameter("description"));
        } else if ("delete".equals(action)) {
            int id = parseInt(request.getParameter("categoryId"));
            result = categoryService.deleteCategory(id) ? "success" : "Failed";
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories" + ("success".equals(result) ? "?success=true" : "?error=true"));
    }

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;
        if (loggedUser == null || !"admin".equals(loggedUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return -1;
        }
    }
}


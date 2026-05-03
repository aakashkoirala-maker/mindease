<%-- This is a categories jsp --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Manage Categories</h1>
                <p>Create and organize resource categories.</p>
            </div>

            <c:if test="${param.success == 'true'}"><div class="alert-success">Saved successfully.</div></c:if>
            <c:if test="${param.error == 'true'}"><div class="alert-error">Action failed.</div></c:if>

            <div class="admin-two-col">
                <div class="card">
                    <div class="card-header">
                        <h2><c:choose><c:when test="${not empty editCategory}">Edit Category</c:when><c:otherwise>Add New Category</c:otherwise></c:choose></h2>
                    </div>
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                            <input type="hidden" name="action" value="${not empty editCategory ? 'update' : 'create'}">
                            <c:if test="${not empty editCategory}">
                                <input type="hidden" name="categoryId" value="${editCategory.categoryId}">
                            </c:if>
                            <div class="form-group">
                                <label>Category Name</label>
                                <input class="form-control" name="name" required value="${editCategory.name}">
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea class="form-control" name="description" style="height:90px;">${editCategory.description}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width:100%;">${not empty editCategory ? 'Save Changes' : 'Add Category'}</button>
                            <c:if test="${not empty editCategory}">
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline" style="width:100%;margin-top:8px;text-align:center;">Cancel</a>
                            </c:if>
                        </form>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h2>All Categories</h2>
                        <div class="stat-pill">${fn:length(categories)} total</div>
                    </div>
                    <div class="table-responsive">
                        <table>
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <tr><td colspan="4" style="text-align:center;color:#9ca3af;">No categories yet. Add one to get started.</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="c" items="${categories}" varStatus="s">
                                        <tr>
                                            <td style="color:#9ca3af;font-size:0.78rem;font-weight:600;">${s.index + 1}</td>
                                            <td>${c.name}</td>
                                            <td style="color:#6b7280;">${c.description}</td>
                                            <td class="action-buttons">
                                                <a class="btn btn-outline" href="${pageContext.request.contextPath}/admin/categories?editId=${c.categoryId}">Edit</a>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/categories" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="categoryId" value="${c.categoryId}">
                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Delete this category?');">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    const content = document.querySelector('.content');
    const topbar = document.querySelector('.topbar');
    if (content && topbar) {
        content.addEventListener('scroll', function() {
            topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
        });
    }
</script>
</body>
</html>
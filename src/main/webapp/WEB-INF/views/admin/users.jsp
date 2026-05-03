<%-- This is the FIXED user jsp --%>

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
    <title>Manage Users - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <%-- Include Sidebar --%>
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />

    <div class="main-area">
        <%-- Include Topbar --%>
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />

        <main class="content">
            <div class="page-header">
                <div>
                    <h1>Manage Users</h1>
                    <p>View, approve, and manage user accounts</p>
                </div>
                <div class="stat-badge">${totalAll} Total Users</div>
            </div>

            <%-- Alert Messages --%>
            <c:if test="${param.success == 'true'}">
                <div class="alert-success">User status updated successfully.</div>
            </c:if>
            <c:if test="${param.error == 'true'}">
                <div class="alert-error">Action failed. Please try again.</div>
            </c:if>

            <%-- Filter Tabs (FIXED URL PATHS) --%>
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/admin/users?status=all"
                   class="filter-pill ${param.status == 'all' or empty param.status ? 'active' : ''}">
                    All <span class="count">${totalAll}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?status=pending"
                   class="filter-pill ${param.status == 'pending' ? 'active' : ''}">
                    Pending <span class="count">${totalPending}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?status=active"
                   class="filter-pill ${param.status == 'active' ? 'active' : ''}">
                    Active <span class="count">${totalActive}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?status=inactive"
                   class="filter-pill ${param.status == 'inactive' ? 'active' : ''}">
                    Inactive <span class="count">${totalInactive}</span>
                </a>
            </div>

            <div class="card">
                <c:choose>
                    <c:when test="${empty users}">
                        <div class="empty-state">
                            <div class="empty-state-emoji">
                                <svg width="42" height="42" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                            </div>
                            <div class="empty-state-title">No users found</div>
                            <div class="empty-state-text">Try a different filter or wait for new registrations</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="users-table">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Registered</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td>${u.name}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td style="text-transform:capitalize;">${u.role}</td>
                                        <td><span class="badge badge-${u.status}">${u.status}</span></td>
                                        <td>${fn:substring(u.createdAt.toString(), 0, 10)}</td>
                                        <td class="action-buttons">
                                            <c:if test="${u.status == 'pending'}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="userId" value="${u.userId}">
                                                    <button class="btn btn-success" type="submit">Approve</button>
                                                </form>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="userId" value="${u.userId}">
                                                    <button class="btn btn-danger" type="submit">Reject</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${u.status == 'active'}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                    <input type="hidden" name="action" value="deactivate">
                                                    <input type="hidden" name="userId" value="${u.userId}">
                                                    <button class="btn btn-warning" type="submit">Deactivate</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${u.status == 'inactive'}">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                    <input type="hidden" name="action" value="activate">
                                                    <input type="hidden" name="userId" value="${u.userId}">
                                                    <button class="btn btn-success" type="submit">Activate</button>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
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
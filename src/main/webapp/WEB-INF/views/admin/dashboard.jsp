<%-- This is a dashboard jsp --%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Dashboard</h1>
                <p>Track key metrics and recent admin activity.</p>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon users" style="color:#2b7a78;">
                        <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    </div>
                    <div>
                        <div class="stat-label">Total Users</div>
                        <div class="stat-number">${totalUsers}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon resources" style="color:#92400e;">
                        <svg viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                    </div>
                    <div>
                        <div class="stat-label">Total Resources</div>
                        <div class="stat-number">${totalResources}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon counselors" style="color:#7c3aed;">
                        <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
                    </div>
                    <div>
                        <div class="stat-label">Total Counselors</div>
                        <div class="stat-number">${totalCounselors}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon appointments" style="color:#991b1b;">
                        <svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                    </div>
                    <div>
                        <div class="stat-label">Pending Appointments</div>
                        <div class="stat-number">${pendingAppointments}</div>
                    </div>
                </div>
            </div>

            <div class="main-row">
                <div class="recent-users-card">
                    <div class="card-header">
                        <h2 class="card-title">Recent Users</h2>
                        <span class="entries-count">${fn:length(recentUsers)} entries</span>
                    </div>
                    <div class="table-responsive">
                        <table class="users-table">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="u" items="${recentUsers}" varStatus="st">
                                <c:set var="userDisplayName" value="User" />
                                <c:if test="${not empty u.name}"><c:set var="userDisplayName" value="${fn:trim(u.name)}" /></c:if>
                                <c:set var="userInitials" value="US" />
                                <c:choose>
                                    <c:when test="${fn:length(userDisplayName) >= 2}"><c:set var="userInitials" value="${fn:toUpperCase(fn:substring(userDisplayName, 0, 2))}" /></c:when>
                                    <c:when test="${fn:length(userDisplayName) == 1}"><c:set var="userInitials" value="${fn:toUpperCase(userDisplayName)}" /></c:when>
                                </c:choose>
                                <tr style="background:${st.index % 2 == 0 ? '#ffffff' : '#f9fafb'};">
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar">${userInitials}</div>
                                            <span>${userDisplayName}</span>
                                        </div>
                                    </td>
                                    <td>${u.email}</td>
                                    <td><c:out value="${u.role.substring(0, 1).toUpperCase()}${u.role.substring(1).toLowerCase()}" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.status == 'active'}"><span class="status-badge status-active">Active</span></c:when>
                                            <c:when test="${u.status == 'pending'}"><span class="status-badge status-pending">Pending</span></c:when>
                                            <c:otherwise><span class="status-badge status-inactive">Inactive</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer">
                        <span>Showing ${fn:length(recentUsers)} of ${totalUsers} users</span>
                        <a href="${pageContext.request.contextPath}/admin/users" class="view-all-link">View All Users</a>
                    </div>
                </div>

                <div class="quick-stats">
                    <div class="quick-stat-card">
                        <div class="quick-icon registrations" style="color:#2b7a78;">
                            <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 11h-6"></path><path d="M20 8v6"></path></svg>
                        </div>
                        <div class="quick-text">
                            <div class="quick-number">${newRegistrations}</div>
                            <h3>New Registrations</h3>
                            <div class="quick-sublabel">Today</div>
                        </div>
                    </div>
                    <div class="quick-stat-card">
                        <div class="quick-icon moods" style="color:#92400e;">
                            <svg viewBox="0 0 24 24"><path d="M22 12h-4l-3 9-6-18-3 9H2"></path></svg>
                        </div>
                        <div class="quick-text">
                            <div class="quick-number">${moodLogsToday}</div>
                            <h3>Mood Logs</h3>
                            <div class="quick-sublabel">Today</div>
                        </div>
                    </div>
                    <div class="quick-stat-card">
                        <div class="quick-icon sessions" style="color:#065f46;">
                            <svg viewBox="0 0 24 24"><path d="M9 11l3 3L22 4"></path><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
                        </div>
                        <div class="quick-text">
                            <div class="quick-number">${sessionsToday}</div>
                            <h3>Sessions</h3>
                            <div class="quick-sublabel">Approved today</div>
                        </div>
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
        content.addEventListener('scroll', () => {
            topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
        });
    }
</script>
</body>
</html>
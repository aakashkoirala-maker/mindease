<%-- WEB-INF/views/admin/includes/sidebar.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<aside class="sidebar" id="adminSidebar">

    <div class="sidebar-logo">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-logo-link">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="MindEase">
            <span class="logo-text">MindEase</span>
        </a>
    </div>

    <button class="sidebar-toggle" type="button" onclick="toggleSidebar()" aria-label="Toggle sidebar">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <line x1="3" y1="6" x2="21" y2="6"/>
            <line x1="3" y1="12" x2="21" y2="12"/>
            <line x1="3" y1="18" x2="21" y2="18"/>
        </svg>
    </button>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link" title="Dashboard">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
            </span>
            <span class="nav-label">Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-link" title="Manage Users">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </span>
            <span class="nav-label">Manage Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/resources" class="nav-link" title="Manage Resources">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
            </span>
            <span class="nav-label">Manage Resources</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/counselors" class="nav-link" title="Manage Counselors">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
            </span>
            <span class="nav-label">Manage Counselors</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/categories" class="nav-link" title="Manage Categories">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"/><line x1="7" y1="7" x2="7.01" y2="7"/></svg>
            </span>
            <span class="nav-label">Manage Categories</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/appointments" class="nav-link" title="Appointments">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            </span>
            <span class="nav-label">Appointments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/messages" class="nav-link" title="Messages">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
            </span>
            <span class="nav-label">Messages</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link" title="Reports">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
            </span>
            <span class="nav-label">Reports</span>
        </a>
    </nav>

    <div class="sidebar-logout">
        <a href="${pageContext.request.contextPath}/logout" class="nav-link" title="Logout">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            </span>
            <span class="nav-label">Logout</span>
        </a>
    </div>

</aside>

<script>
    (function () {
        var sidebar = document.getElementById('adminSidebar');

        // Restore collapse state
        if (localStorage.getItem('adminSidebarCollapsed') === 'true') {
            sidebar.classList.add('collapsed');
            document.body.classList.add('sidebar-collapsed');
        }

        // Active link highlight
        var currentPath = window.location.pathname;
        document.querySelectorAll('.sidebar .nav-link').forEach(function (link) {
            var href = link.getAttribute('href');
            if (href && (currentPath === href || currentPath.startsWith(href + '/'))) {
                link.classList.add('active');
            }
        });

        window.toggleSidebar = function () {
            var collapsed = sidebar.classList.toggle('collapsed');
            document.body.classList.toggle('sidebar-collapsed', collapsed);
            localStorage.setItem('adminSidebarCollapsed', collapsed);
        };
    })();
</script>
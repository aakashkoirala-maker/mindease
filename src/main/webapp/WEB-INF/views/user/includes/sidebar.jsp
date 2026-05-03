<%-- WEB-INF/views/user/includes/sidebar.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<aside class="user-sidebar" id="userSidebar">

    <div class="user-sidebar-logo">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="user-logo-link">
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

    <nav class="user-nav">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-link" title="Dashboard">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
            </span>
            <span class="nav-label">Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/log-mood" class="nav-link" title="Log Mood">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
            </span>
            <span class="nav-label">Log Mood</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/mood-history" class="nav-link" title="Mood History">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            </span>
            <span class="nav-label">Mood History</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/resources" class="nav-link" title="Browse Resources">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
            </span>
            <span class="nav-label">Browse Resources</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/bookmarks" class="nav-link" title="My Bookmarks">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"/></svg>
            </span>
            <span class="nav-label">My Bookmarks</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/book-appointment" class="nav-link" title="Book Appointment">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            </span>
            <span class="nav-label">Book Appointment</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/appointments" class="nav-link" title="My Appointments">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 11 18 15 14"/></svg>
            </span>
            <span class="nav-label">My Appointments</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/contact" class="nav-link" title="Contact Support">
            <span class="nav-icon-box">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
            </span>
            <span class="nav-label">Contact Support</span>
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
        var sidebar = document.getElementById('userSidebar');

        // Restore collapse state
        if (localStorage.getItem('sidebarCollapsed') === 'true') {
            sidebar.classList.add('collapsed');
            document.body.classList.add('sidebar-collapsed');
        }

        // Active link highlight
        var currentPath = window.location.pathname;
        document.querySelectorAll('.user-sidebar .nav-link').forEach(function (link) {
            var href = link.getAttribute('href');
            if (href && (currentPath === href || currentPath.startsWith(href + '/'))) {
                link.classList.add('active');
            }
        });

        window.toggleSidebar = function () {
            var collapsed = sidebar.classList.toggle('collapsed');
            document.body.classList.toggle('sidebar-collapsed', collapsed);
            localStorage.setItem('sidebarCollapsed', collapsed);
        };
    })();
</script>
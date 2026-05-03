<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro { border-left: 4px solid #2b7a78; padding-left: 16px; margin-bottom: 24px; }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { font-size: 0.82rem; color: #9ca3af; margin-top: 4px; }

        .success-banner {
            background: #d1fae5; color: #065f46;
            border-left: 4px solid #10b981;
            border-radius: 10px; padding: 12px 16px;
            margin-bottom: 20px; font-weight: 600;
        }

        .stat-filter-card {
            background: white; border-radius: 16px; padding: 16px;
            display: flex; align-items: center; gap: 14px;
            cursor: default; transition: all 0.2s;
            border: 1px solid #f1f5f9;
            box-shadow: 0 1px 4px rgba(0,0,0,0.05);
        }
        .stat-filter-card.active { background: #f0fbfa; border-color: #f1f5f9; }
        .stat-filter-icon { width: 48px; height: 48px; border-radius: 14px; display: flex; align-items: center; justify-content: center; }
        .stat-filter-icon svg { width: 1.3rem; height: 1.3rem; }
        .stat-filter-number { font-size: 1.5rem; font-weight: 700; color: #2b7a78; }
        .stat-filter-label { font-size: 0.75rem; color: #6b7280; }

        .appointments-table { width: 100%; border-collapse: collapse; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 2px 10px rgba(43,122,120,0.08); }
        .appointments-table th { background: #2b7a78; color: white; padding: 14px 20px; text-align: left; font-weight: 600; font-size: 0.9rem; }
        .appointments-table td { padding: 16px 20px; border-bottom: 1px solid #f0f4f4; font-size: 0.9rem; }
        .appointments-table tr:nth-child(even) { background: #fafafa; }
        .appointments-table tr:hover { background: #f0fbfa; }

        .counselor-name { font-weight: 700; color: #1a2e2e; margin-bottom: 4px; }
        .counselor-specialty { font-size: 0.75rem; color: #9ca3af; }

        .status-pill { display: inline-flex; align-items: center; gap: 6px; border-radius: 40px; padding: 5px 14px; font-size: 0.75rem; font-weight: 600; text-transform: capitalize; }
        .status-approved { background: #d1fae5; color: #065f46; }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-rejected { background: #fee2e2; color: #991b1b; }

        .empty-state { text-align: center; padding: 60px; background: white; border-radius: 20px; box-shadow: 0 2px 10px rgba(43,122,120,0.08); }
    </style>
</head>
<body>
<div class="user-layout">
    <jsp:include page="/WEB-INF/views/user/includes/sidebar.jsp" />

    <div class="user-main">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />

        <main class="user-content content">
            <div class="page-intro">
                <h1>My Appointments</h1>
                <p>Track your session requests and current appointment status.</p>
            </div>

            <c:if test="${param.success == 'true'}">
                <div class="success-banner">Appointment requested successfully. It is now pending admin approval.</div>
            </c:if>

            <div class="stats-filter-grid">
                <div class="stat-filter-card ${activeFilter == 'all' ? 'active' : ''}" data-filter="all">
                    <div class="stat-filter-icon" style="background:#e6f4f3;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color:#2b7a78;"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg></div>
                    <div><div class="stat-filter-number">${totalCount}</div><div class="stat-filter-label">Total</div></div>
                </div>
                <div class="stat-filter-card ${activeFilter == 'approved' ? 'active' : ''}" data-filter="approved">
                    <div class="stat-filter-icon" style="background:#d1fae5;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color:#065f46;"><path d="M5 13l4 4L19 7"></path></svg></div>
                    <div><div class="stat-filter-number">${approvedCount}</div><div class="stat-filter-label">Approved</div></div>
                </div>
                <div class="stat-filter-card ${activeFilter == 'pending' ? 'active' : ''}" data-filter="pending">
                    <div class="stat-filter-icon" style="background:#fef3c7;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color:#92400e;"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 2"></path></svg></div>
                    <div><div class="stat-filter-number">${pendingCount}</div><div class="stat-filter-label">Pending</div></div>
                </div>
                <div class="stat-filter-card ${activeFilter == 'rejected' ? 'active' : ''}" data-filter="rejected">
                    <div class="stat-filter-icon" style="background:#fee2e2;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="color:#991b1b;"><path d="M18 6 6 18"></path><path d="m6 6 12 12"></path></svg></div>
                    <div><div class="stat-filter-number">${rejectedCount}</div><div class="stat-filter-label">Rejected</div></div>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty appointments}">
                    <div class="empty-state">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:3rem;height:3rem;color:#9ca3af;margin:0 auto 16px;display:block;"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg>
                        <h3 style="color:#1a2e2e;">No appointments found</h3>
                        <p style="color:#9ca3af;margin-top:8px;"><a href="${pageContext.request.contextPath}/user/book-appointment" style="color:#2b7a78;">Book your first session</a></p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="appointments-table">
                            <thead>
                            <tr>
                                <th>Counselor</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${appointments}" var="a">
                                <tr>
                                    <td>
                                        <div class="counselor-name">${a.counselorName}</div>
                                        <div class="counselor-specialty">Mental Health Counselor</div>
                                    </td>
                                    <td><fmt:formatDate value="${a.apptDate}" pattern="MMM dd, yyyy"/></td>
                                    <td><fmt:formatDate value="${a.apptTime}" pattern="h:mm a"/></td>
                                    <td>
                                        <span class="status-pill status-${a.status}">
                                            <c:choose>
                                                <c:when test="${a.status == 'approved'}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><circle cx="12" cy="12" r="9"></circle><path d="M8 12.5l2.5 2.5L16 9.5"></path></svg></c:when>
                                                <c:when test="${a.status == 'pending'}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><path d="M8 3h8"></path><path d="M8 21h8"></path><path d="M8 3v4l3 3-3 3v8"></path><path d="M16 3v4l-3 3 3 3v8"></path></svg></c:when>
                                                <c:otherwise><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><circle cx="12" cy="12" r="9"></circle><path d="M15 9 9 15"></path><path d="m9 9 6 6"></path></svg></c:otherwise>
                                            </c:choose>
                                            ${a.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        const href = link.getAttribute('href');
        if (href && (href === currentPath || currentPath.startsWith(href + '/'))) link.classList.add('active');
    });

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
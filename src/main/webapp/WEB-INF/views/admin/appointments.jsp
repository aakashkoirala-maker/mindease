<%-- This is a appointment jsp --%>
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
    <title>Appointments - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Appointments</h1>
                <p>Review, approve, and track appointment status.</p>
            </div>

            <c:if test="${param.success == 'true'}"><div class="alert-success">Appointment updated.</div></c:if>
            <c:if test="${param.error == 'true'}"><div class="alert-error">Action failed.</div></c:if>

            <div class="summary-strip">
                <div class="appt-stat-card">
                    <div class="appt-stat-number">${pendingCount}</div>
                    <div class="appt-stat-label">Pending</div>
                    <div class="appt-stat-bar pending-bar"></div>
                </div>
                <div class="appt-stat-card">
                    <div class="appt-stat-number">${approvedCount}</div>
                    <div class="appt-stat-label">Approved</div>
                    <div class="appt-stat-bar approved-bar"></div>
                </div>
                <div class="appt-stat-card">
                    <div class="appt-stat-number">${completedCount}</div>
                    <div class="appt-stat-label">Completed</div>
                    <div class="appt-stat-bar completed-bar"></div>
                </div>
                <div class="appt-stat-card">
                    <div class="appt-stat-number">${rejectedCount}</div>
                    <div class="appt-stat-label">Rejected</div>
                    <div class="appt-stat-bar rejected-bar"></div>
                </div>
            </div>

            <div style="margin-bottom:16px;">
                <button class="tab-btn active" data-filter="all">All</button>
                <button class="tab-btn" data-filter="pending">Pending</button>
                <button class="tab-btn" data-filter="approved">Approved</button>
                <button class="tab-btn" data-filter="completed">Completed</button>
                <button class="tab-btn" data-filter="rejected">Rejected</button>
            </div>

            <div class="card">
                <div class="table-responsive">
                    <table>
                        <thead>
                        <tr>
                            <th>User</th>
                            <th>Counselor</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="appt" items="${appointments}">
                            <tr data-status="${appt.status}">
                                <td>${appt.userName}</td>
                                <td>${appt.counselorName}</td>
                                <td>${appt.apptDate}</td>
                                <td>${appt.apptTime}</td>
                                <td><span class="badge badge-${appt.status}">${appt.status}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty appt.notes && fn:length(appt.notes) > 40}">${fn:substring(appt.notes,0,40)}...</c:when>
                                        <c:otherwise>${appt.notes}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="row-actions">
                                        <c:if test="${appt.status == 'pending'}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/appointments">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="apptId" value="${appt.apptId}">
                                                <button class="btn btn-success" type="submit">Approve</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/appointments">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="hidden" name="apptId" value="${appt.apptId}">
                                                <input type="text" name="notes" placeholder="Rejection reason..." style="width:140px;padding:5px 10px;border:1.5px solid #e5e7eb;border-radius:7px;font-size:0.78rem;outline:none;">
                                                <button class="btn btn-danger" type="submit">Reject</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${appt.status == 'approved'}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/appointments">
                                                <input type="hidden" name="action" value="complete">
                                                <input type="hidden" name="apptId" value="${appt.apptId}">
                                                <button class="btn" style="background:#e0f2fe;color:#075985;border:1px solid #bae6fd;" type="submit">Mark Complete</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${appt.status == 'completed' || appt.status == 'rejected'}">
                                            <span style="color:#9ca3af;">-</span>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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

    document.querySelectorAll('.tab-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.tab-btn').forEach(function(b) { b.classList.remove('active'); });
            this.classList.add('active');
            const filter = this.dataset.filter;
            document.querySelectorAll('tbody tr').forEach(function(row) {
                row.style.display = (filter === 'all' || row.dataset.status === filter) ? '' : 'none';
            });
        });
    });
</script>
</body>
</html>
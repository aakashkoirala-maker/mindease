<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<section class="white-card">
    <div class="card-header">
        <h3>Upcoming Sessions</h3>
        <a href="#" class="view-all-link">View all</a>
    </div>

    <c:choose>
        <c:when test="${empty upcomingSessions}">
            <p style="color:#9ca3af;">No upcoming sessions yet.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="s" items="${upcomingSessions}">
                <div class="session-row">
                    <div class="date-badge">
                        <div class="date-day"><fmt:formatDate value="${s.apptDate}" pattern="dd" /></div>
                        <div class="date-month"><fmt:formatDate value="${s.apptDate}" pattern="MMM" /></div>
                    </div>
                    <div class="session-info">
                        <div class="session-name">${s.counselorName}</div>
                        <div class="session-meta">${s.counselorSpecialization} • ${s.apptTime}</div>
                    </div>
                    <span class="status-pill ${s.status == 'approved' ? 'status-approved' : 'status-pending'}">${s.status}</span>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</section>
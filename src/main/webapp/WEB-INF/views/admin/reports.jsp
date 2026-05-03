<%-- reports.jsp --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Reports</h1>
                <p>View platform insights and counselor performance metrics.</p>
            </div>

            <div class="summary-grid">
                <div class="card" style="padding:16px 20px;">
                    <h3 class="summary-title">
                        <svg viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                        User Overview
                    </h3>
                    <div class="stat-row"><span style="color:#6b7280;">Total Users</span><strong style="color:#2b7a78;">${totalUsers}</strong></div>
                    <div class="divider"></div>
                    <div class="stat-row"><span style="color:#6b7280;">Active Users</span><strong style="color:#2b7a78;">${activeUsers}</strong></div>
                    <div class="divider"></div>
                    <div class="stat-row"><span style="color:#6b7280;">Pending Users</span><strong style="color:#2b7a78;">${pendingUsers}</strong></div>
                </div>
                <div class="card" style="padding:16px 20px;">
                    <h3 class="summary-title">
                        <svg viewBox="0 0 24 24"><path d="M22 12h-4l-3 9-6-18-3 9H2"></path></svg>
                        Mood Summary
                    </h3>
                    <div class="stat-row"><span style="color:#6b7280;">Total Logs</span><strong style="color:#2b7a78;">${totalMoodEntries}</strong></div>
                    <div class="stat-row"><span style="color:#6b7280;">Avg Score</span><strong style="color:#2b7a78;">${avgMoodScore} / 5</strong></div>
                    <div class="mood-row"><span>&#128542; 1</span><div class="bar"><span style="width:${totalMoodEntries > 0 ? (moodDistribution[1] * 100 / totalMoodEntries) : 0}%;"></span></div><span>${moodDistribution[1]}</span></div>
                    <div class="mood-row"><span>&#128577; 2</span><div class="bar"><span style="width:${totalMoodEntries > 0 ? (moodDistribution[2] * 100 / totalMoodEntries) : 0}%;"></span></div><span>${moodDistribution[2]}</span></div>
                    <div class="mood-row"><span>&#128528; 3</span><div class="bar"><span style="width:${totalMoodEntries > 0 ? (moodDistribution[3] * 100 / totalMoodEntries) : 0}%;"></span></div><span>${moodDistribution[3]}</span></div>
                    <div class="mood-row"><span>&#128578; 4</span><div class="bar"><span style="width:${totalMoodEntries > 0 ? (moodDistribution[4] * 100 / totalMoodEntries) : 0}%;"></span></div><span>${moodDistribution[4]}</span></div>
                    <div class="mood-row"><span>&#128516; 5</span><div class="bar"><span style="width:${totalMoodEntries > 0 ? (moodDistribution[5] * 100 / totalMoodEntries) : 0}%;"></span></div><span>${moodDistribution[5]}</span></div>
                </div>
                <div class="card" style="padding:16px 20px;">
                    <h3 class="summary-title">
                        <svg viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                        Resources
                    </h3>
                    <div class="stat-row"><span style="color:#6b7280;">Total</span><strong style="color:#2b7a78;">${totalResources}</strong></div>
                    <div class="divider"></div>
                    <div class="stat-row"><span style="color:#6b7280;">Published</span><strong style="color:#2b7a78;">${publishedResources}</strong></div>
                    <div class="divider"></div>
                    <div class="stat-row"><span style="color:#6b7280;">Draft</span><strong style="color:#2b7a78;">${totalResources - publishedResources}</strong></div>
                </div>
            </div>

            <div class="card" style="padding:0;">
                <div class="card-header"><h2>Most Booked Counselors</h2></div>
                <c:set var="maxVal" value="1"/>
                <c:forEach var="item" items="${topCounselors}" varStatus="st">
                    <c:if test="${st.index == 0}"><c:set var="maxVal" value="${item[1]}"/></c:if>
                </c:forEach>
                <div class="table-responsive">
                    <table>
                        <thead>
                        <tr><th>Rank</th><th>Counselor Name</th><th>Total Appointments</th><th>Visual</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${topCounselors}" varStatus="st">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${st.index == 0}"><span style="font-size:1.2rem;">&#129351;</span></c:when>
                                        <c:when test="${st.index == 1}"><span style="font-size:1.2rem;">&#129352;</span></c:when>
                                        <c:when test="${st.index == 2}"><span style="font-size:1.2rem;">&#129353;</span></c:when>
                                        <c:otherwise><strong style="color:#6b7280;">${st.index + 1}</strong></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item[0]}</td>
                                <td>${item[1]}</td>
                                <td>
                                    <div style="height:8px;border-radius:999px;background:#e5e7eb;width:160px;display:inline-block;vertical-align:middle;overflow:hidden;">
                                        <div style="height:8px;border-radius:999px;background:linear-gradient(90deg,#2b7a78,#3aafa9);width:${maxVal > 0 ? ((item[1] * 100) / maxVal) : 0}%;"></div>
                                    </div>
                                    <span style="font-size:0.75rem;color:#6b7280;margin-left:8px;">${item[1]}</span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="export-bar">
                <button class="btn btn-outline" onclick="window.print()">Print Report</button>
                <button type="button" id="summaryBtn" style="border:1.5px solid #2b7a78;color:#2b7a78;background:white;border-radius:8px;padding:8px 18px;font-size:0.85rem;font-weight:600;cursor:pointer;">Summary</button>
            </div>

            <div id="summaryModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.45);z-index:300;align-items:center;justify-content:center;padding:16px;">
                <div style="background:white;border-radius:16px;padding:28px;width:100%;max-width:440px;box-shadow:0 20px 60px rgba(0,0,0,0.15);max-height:calc(100vh - 32px);overflow-y:auto;">
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                        <h3 style="font-size:1rem;font-weight:700;color:#1f2937;">Report Summary</h3>
                        <button id="closeSummary" style="background:none;border:none;font-size:1.2rem;cursor:pointer;color:#9ca3af;">&#x2715;</button>
                    </div>
                    <div style="display:flex;flex-direction:column;gap:0;">
                        <div style="display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f1f5f9;"><span style="font-size:0.85rem;color:#6b7280;">Total Users</span><span style="font-size:0.85rem;font-weight:700;color:#2b7a78;">${totalUsers}</span></div>
                        <div style="display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f1f5f9;"><span style="font-size:0.85rem;color:#6b7280;">Total Mood Logs</span><span style="font-size:0.85rem;font-weight:700;color:#2b7a78;">${totalMoodEntries}</span></div>
                        <div style="display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f1f5f9;"><span style="font-size:0.85rem;color:#6b7280;">Average Mood Score</span><span style="font-size:0.85rem;font-weight:700;color:#2b7a78;">${avgMoodScore} / 5</span></div>
                        <div style="display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f1f5f9;"><span style="font-size:0.85rem;color:#6b7280;">Published Resources</span><span style="font-size:0.85rem;font-weight:700;color:#2b7a78;">${publishedResources}</span></div>
                        <div style="display:flex;justify-content:space-between;padding:10px 0;"><span style="font-size:0.85rem;color:#6b7280;">Total Appointments</span><span style="font-size:0.85rem;font-weight:700;color:#2b7a78;">${totalAppointments != null ? totalAppointments : 0}</span></div>
                    </div>
                    <button onclick="window.print()" style="margin-top:20px;width:100%;background:linear-gradient(135deg,#2b7a78,#3aafa9);color:white;border:none;border-radius:8px;padding:10px;font-weight:600;cursor:pointer;">Print Summary</button>
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
    const summaryBtn = document.getElementById('summaryBtn');
    const summaryModal = document.getElementById('summaryModal');
    const closeSummary = document.getElementById('closeSummary');
    if (summaryBtn && summaryModal && closeSummary) {
        summaryBtn.addEventListener('click', function() { summaryModal.style.display = 'flex'; document.body.classList.add('modal-open'); });
        closeSummary.addEventListener('click', function() { summaryModal.style.display = 'none'; document.body.classList.remove('modal-open'); });
        summaryModal.addEventListener('click', function(e) { if (e.target === summaryModal) { summaryModal.style.display = 'none'; document.body.classList.remove('modal-open'); } });
    }
</script>
</body>
</html>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
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
    <title>Mood History - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro { border-left: 4px solid #2b7a78; padding-left: 16px; margin-bottom: 24px; }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { font-size: 0.82rem; color: #9ca3af; margin-top: 4px; }

        .history-stat-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
        }
        .history-stat-icon {
            width: 48px; height: 48px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 14px; font-size: 1.25rem;
        }
        .history-icon-teal { background: #e6f4f3; color: #2b7a78; }
        .history-icon-amber { background: #fef3c7; color: #92400e; }
        .history-icon-mint { background: #d1fae5; color: #065f46; }
        .history-icon-lavender { background: #ede9fe; color: #5b21b6; }
        .history-stat-number { font-size: 2rem; font-weight: 700; color: #2b7a78; font-family: Poppins,'Segoe UI',sans-serif; line-height: 1.1; }
        .history-stat-label { font-size: 0.85rem; font-weight: 600; color: #374151; margin-top: 6px; }
        .history-stat-desc { font-size: 0.72rem; color: #9ca3af; margin-top: 2px; }

        .history-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
        }
        .history-title { font-size: 1.05rem; font-weight: 600; color: #1f2937; margin-bottom: 4px; }

        .history-bar {
            width: 32px;
            border-radius: 20px 20px 8px 8px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .history-bar:hover { transform: translateY(-2px); }

        .history-tooltip {
            position: fixed;
            background: #1f2937; color: #ffffff;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.72rem;
            pointer-events: none;
            z-index: 120;
            display: none;
            white-space: nowrap;
        }

        .history-filters { display: flex; gap: 10px; margin-bottom: 18px; flex-wrap: wrap; }
        .history-filter-chip {
            background: #f3f4f6; color: #6b7280;
            border: none; border-radius: 40px;
            padding: 8px 18px; font-size: 0.85rem;
            cursor: pointer; transition: all 0.2s;
        }
        .history-filter-chip.active { background: #2b7a78; color: #ffffff; }

        .history-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 16px; overflow: hidden; }
        .history-table thead th { background: #2b7a78; color: #ffffff; padding: 14px 20px; text-align: left; font-weight: 600; }
        .history-table tbody td { padding: 14px 20px; border-bottom: 1px solid #f0f4f4; }
        .history-table tbody tr:nth-child(even) { background: #fafafa; }
        .history-table tbody tr:hover { background: #f9fafb; }

        .history-row-5 { background: #f0fdf9 !important; }
        .history-row-4 { background: #f6fef8 !important; }
        .history-row-3 { background: #fffef0 !important; }
        .history-row-2 { background: #fff8f3 !important; }
        .history-row-1 { background: #fff5f5 !important; }

        .history-score-circle {
            display: inline-flex; align-items: center; justify-content: center;
            width: 32px; height: 32px; border-radius: 50%;
            font-weight: 700; font-size: 0.85rem;
        }
        .history-score-5 { background: #a7f3d0; color: #065f46; }
        .history-score-4 { background: #d1fae5; color: #065f46; }
        .history-score-3 { background: #fef3c7; color: #92400e; }
        .history-score-2 { background: #fde8d8; color: #9b2c1d; }
        .history-score-1 { background: #fee2e2; color: #991b1b; }

        .history-mood-pill {
            display: inline-flex; align-items: center; gap: 6px;
            border-radius: 40px; padding: 4px 14px;
            font-size: 0.8rem; font-weight: 500;
        }
        .history-mood-5 { background: #d1fae5; color: #065f46; }
        .history-mood-4 { background: #dcfce7; color: #065f46; }
        .history-mood-3 { background: #fef9c3; color: #854d0e; }
        .history-mood-2 { background: #ffedd5; color: #9a3412; }
        .history-mood-1 { background: #fee2e2; color: #991b1b; }

        .history-note { color: #6b7280; max-width: 360px; word-break: break-word; }
        .history-footer { padding: 14px 2px 4px; text-align: right; font-size: 0.8rem; color: #9ca3af; }
        .history-empty { text-align: center; padding: 48px; color: #9ca3af; }
        .history-empty a { color: #2b7a78; text-decoration: none; font-weight: 600; }
        .entries-container { min-height: 400px; }

        @media (max-width: 768px) {
            .history-table { min-width: 520px; }
        }
    </style>
</head>
<body>
<div class="user-layout">
    <jsp:include page="/WEB-INF/views/user/includes/sidebar.jsp" />

    <div class="user-main">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />

        <main class="user-content content">
            <div class="page-intro">
                <h1>Mood History</h1>
                <p>Review your mood trends and past journal entries.</p>
            </div>

            <section class="history-stats-grid">
                <div class="history-stat-card">
                    <div class="history-stat-icon history-icon-teal"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="22" height="22"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg></div>
                    <div class="history-stat-number">${totalEntries}</div>
                    <div class="history-stat-label">Total Entries</div>
                </div>
                <div class="history-stat-card">
                    <div class="history-stat-icon history-icon-amber"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="22" height="22"><path d="M3 19h18"></path><polyline points="5 15 10 10 13 13 19 7"></polyline></svg></div>
                    <div class="history-stat-number"><fmt:formatNumber value="${avgScore}" minFractionDigits="1" maxFractionDigits="1" /> / 5.0</div>
                    <div class="history-stat-label">Average Score</div>
                </div>
                <div class="history-stat-card">
                    <div class="history-stat-icon history-icon-mint"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="22" height="22"><circle cx="12" cy="12" r="9"></circle><path d="M8 15c1 1.5 2.3 2 4 2s3-.5 4-2"></path><circle cx="9" cy="10" r="1"></circle><circle cx="15" cy="10" r="1"></circle></svg></div>
                    <div class="history-stat-number">${positiveDays}</div>
                    <div class="history-stat-label">Positive Days</div>
                    <div class="history-stat-desc">Score >= 4</div>
                </div>
                <div class="history-stat-card">
                    <div class="history-stat-icon history-icon-lavender"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="22" height="22"><circle cx="12" cy="8" r="4"></circle><path d="M8 12v9l4-2.2L16 21v-9"></path></svg></div>
                    <div class="history-stat-number"><c:out value="${bestDay}" default="&mdash;" escapeXml="false" /></div>
                    <div class="history-stat-label">Best Day</div>
                </div>
            </section>

            <section class="history-card">
                <h3 class="history-title">Mood Trend - Last 12 Entries</h3>
                <c:choose>
                    <c:when test="${empty chartEntries}">
                        <div class="history-empty">No mood entries yet. <a href="${pageContext.request.contextPath}/user/log-mood">Log your first mood</a></div>
                    </c:when>
                    <c:otherwise>
                        <div class="history-chart-wrap">
                            <div class="history-chart-inner">
                                <c:forEach items="${chartEntries}" var="entry">
                                    <c:choose>
                                        <c:when test="${entry.score == 5}"><c:set var="moodText" value="Excellent" /></c:when>
                                        <c:when test="${entry.score == 4}"><c:set var="moodText" value="Good" /></c:when>
                                        <c:when test="${entry.score == 3}"><c:set var="moodText" value="Okay" /></c:when>
                                        <c:when test="${entry.score == 2}"><c:set var="moodText" value="Low" /></c:when>
                                        <c:otherwise><c:set var="moodText" value="Very Low" /></c:otherwise>
                                    </c:choose>
                                    <fmt:formatDate value="${entry.entryDate}" pattern="MMM dd" var="entryDateLabel"/>
                                    <div style="display:flex;flex-direction:column;align-items:center;width:12%;">
                                        <div class="history-bar history-bar-${entry.score}"
                                             style="height:${(entry.score / 5) * 180}px; background:${entry.score == 5 ? '#a7f3d0' : entry.score == 4 ? '#d1fae5' : entry.score == 3 ? '#fef3c7' : entry.score == 2 ? '#fde8d8' : '#fee2e2'};"
                                             data-date="${entryDateLabel}"
                                             data-mood="${moodText}">
                                        </div>
                                        <div style="font-size:0.7rem;color:#9ca3af;margin-top:8px;">${entryDateLabel}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="history-card">
                <h3 class="history-title">All Entries</h3>
                <div class="history-filters">
                    <button class="history-filter-chip filter-tab active" data-filter="all">All</button>
                    <button class="history-filter-chip filter-tab" data-filter="5">&#128516; Excellent</button>
                    <button class="history-filter-chip filter-tab" data-filter="4">&#128578; Good</button>
                    <button class="history-filter-chip filter-tab" data-filter="3">&#128528; Okay</button>
                    <button class="history-filter-chip filter-tab" data-filter="2">&#128577; Low</button>
                    <button class="history-filter-chip filter-tab" data-filter="1">&#128542; Very Low</button>
                </div>

                <div class="entries-container">
                    <div class="table-responsive">
                        <table class="history-table">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Score</th>
                                <th>Mood</th>
                                <th>Note</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty allEntries}">
                                    <tr>
                                        <td colspan="4" style="text-align:center;padding:48px;color:#9ca3af;">
                                            No mood entries yet. <a href="${pageContext.request.contextPath}/user/log-mood" style="color:#2b7a78;">Log your first mood</a>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${allEntries}" var="entry">
                                        <tr class="entry-row history-row-${entry.score}" data-score="${entry.score}">
                                            <td><fmt:formatDate value="${entry.entryDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><span class="history-score-circle history-score-${entry.score}">${entry.score}</span></td>
                                            <td>
                                                <span class="history-mood-pill history-mood-${entry.score}">
                                                    <c:choose>
                                                        <c:when test="${entry.score == 5}">&#128516; Excellent</c:when>
                                                        <c:when test="${entry.score == 4}">&#128578; Good</c:when>
                                                        <c:when test="${entry.score == 3}">&#128528; Okay</c:when>
                                                        <c:when test="${entry.score == 2}">&#128577; Low</c:when>
                                                        <c:otherwise>&#128542; Very Low</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="history-note">
                                                <c:choose>
                                                    <c:when test="${empty entry.note}">-</c:when>
                                                    <c:when test="${fn:length(entry.note) > 80}">${fn:substring(entry.note, 0, 80)}...</c:when>
                                                    <c:otherwise>${entry.note}</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <div id="emptyState" style="display:none;text-align:center;padding:48px 20px;color:#9ca3af;">
                        <div style="font-size:1.5rem;margin-bottom:10px;">📭</div>
                        <div style="font-weight:600;color:#6b7280;font-size:0.95rem;">No entries found</div>
                        <div style="font-size:0.82rem;margin-top:6px;">Try selecting a different filter</div>
                    </div>
                </div>

                <div class="history-footer"><span id="entryCount">Showing ${fn:length(allEntries)} of ${totalEntries} entries</span></div>
            </section>
        </main>
    </div>
</div>

<div class="history-tooltip" id="historyTooltip"></div>

<script>
    (function () {
        const currentPath = window.location.pathname;
        document.querySelectorAll('.user-nav-link').forEach(link => {
            if (link.getAttribute('href') === currentPath) link.classList.add('active');
        });

        const content = document.querySelector('.content');
        const topbar = document.querySelector('.topbar');
        if (content && topbar) {
            content.addEventListener('scroll', () => {
                topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
            });
        }

        const tooltip = document.getElementById('historyTooltip');
        document.querySelectorAll('.history-bar').forEach(bar => {
            bar.addEventListener('mouseenter', (e) => {
                tooltip.textContent = bar.dataset.mood + ' - ' + bar.dataset.date;
                tooltip.style.display = 'block';
                tooltip.style.left = (e.pageX + 10) + 'px';
                tooltip.style.top = (e.pageY - 30) + 'px';
            });
            bar.addEventListener('mouseleave', () => { tooltip.style.display = 'none'; });
            bar.addEventListener('mousemove', (e) => {
                tooltip.style.left = (e.pageX + 10) + 'px';
                tooltip.style.top = (e.pageY - 30) + 'px';
            });
        });

        function updateCount() {
            const visible = document.querySelectorAll('.entry-row:not([style*="display: none"])').length;
            const total = document.querySelectorAll('.entry-row').length;
            const counter = document.getElementById('entryCount');
            if (counter) counter.textContent = 'Showing ' + visible + ' of ' + total + ' entries';
            const emptyState = document.getElementById('emptyState');
            if (emptyState) emptyState.style.display = total > 0 && visible === 0 ? 'block' : 'none';
        }

        document.querySelectorAll('.filter-tab').forEach(function(tab) {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                const filter = this.dataset.filter;
                document.querySelectorAll('.entry-row').forEach(function(row) {
                    row.style.display = (filter === 'all' || row.dataset.score === filter) ? '' : 'none';
                });
                updateCount();
            });
        });

        updateCount();
    })();
</script>
</body>
</html>
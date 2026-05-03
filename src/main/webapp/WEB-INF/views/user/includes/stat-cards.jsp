<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon" style="background:#e6f4f3;">🔥</div>
        <div class="stat-number">${moodStreak}</div>
        <div class="stat-label">Mood Streak</div>
        <div class="stat-desc">Consecutive days logged</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:#e0f2fe;color:#0284c7;">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/>
                <line x1="3" y1="6" x2="3.01" y2="6"/><line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/>
            </svg>
        </div>
        <div class="stat-number">${totalLogs}</div>
        <div class="stat-label">Total Logs</div>
        <div class="stat-desc">All mood entries</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:#ede9fe;color:#7c3aed;">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"/>
            </svg>
        </div>
        <div class="stat-number">${savedResourcesCount}</div>
        <div class="stat-label">Saved Resources</div>
        <div class="stat-desc">Bookmarked reads</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:#fef3c7;color:#d97706;">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
            </svg>
        </div>
        <div class="stat-number">${appointmentsCount}</div>
        <div class="stat-label">Appointments</div>
        <div class="stat-desc">Pending + approved</div>
    </div>
</section>


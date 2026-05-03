<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<section class="white-card" style="min-width:0; overflow:hidden; width:100%; box-sizing:border-box; margin-bottom:24px;">
    <div class="card-header">
        <h3>Weekly Mood Trend</h3>
        <span class="streak-badge">Last 7 days</span>
    </div>
    <c:choose>
        <c:when test="${empty weeklyMoodData}">
            <p style="color:#9ca3af;">No mood logs yet for this week.</p>
        </c:when>
        <c:otherwise>

                <div style="display:flex; align-items:flex-end; gap:4px; height:180px; margin:16px 0; width:100%;">
                    <c:forEach var="item" items="${weeklyMoodData}">
                        <div style="flex:1; display:flex; flex-direction:column; align-items:center; justify-content:flex-end; height:100%;">
                            <div class="bar-${item.moodScore > 0 ? item.moodScore : 1}"
                                 style="width:28px; height:${item.barHeight}px; border-radius:20px; cursor:pointer;"
                                 data-mood="${item.moodLabel}"></div>
                            <div style="font-size:0.68rem; color:#9ca3af; margin-top:6px;">${item.dayLabel}</div>
                        </div>
                    </c:forEach>
                </div>

        </c:otherwise>
    </c:choose>
    <div class="chart-legend" style="display:flex; flex-wrap:wrap; gap:10px; margin-top:14px; padding-top:12px; border-top:1px solid #e5e7eb;">
        <span class="legend-text"><span class="legend-dot" style="background:#fca5a5; width:10px; height:10px; border-radius:50%; display:inline-block; margin-right:4px;"></span>Very Low</span>
        <span class="legend-text"><span class="legend-dot" style="background:#fdba74; width:10px; height:10px; border-radius:50%; display:inline-block; margin-right:4px;"></span>Low</span>
        <span class="legend-text"><span class="legend-dot" style="background:#fde68a; width:10px; height:10px; border-radius:50%; display:inline-block; margin-right:4px;"></span>Neutral</span>
        <span class="legend-text"><span class="legend-dot" style="background:#86efac; width:10px; height:10px; border-radius:50%; display:inline-block; margin-right:4px;"></span>Good</span>
        <span class="legend-text"><span class="legend-dot" style="background:#34d399; width:10px; height:10px; border-radius:50%; display:inline-block; margin-right:4px;"></span>Great</span>
    </div>
</section>
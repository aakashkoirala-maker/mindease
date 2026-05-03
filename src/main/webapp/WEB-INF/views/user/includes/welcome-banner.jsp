<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<section class="welcome-banner">
    <div class="banner-blob blob-1"></div>
    <div class="banner-blob blob-2"></div>

    <div class="banner-date">${todayDate}</div>
    <h1 class="banner-greeting">Welcome back, ${sessionScope.loggedUser.name} </h1>
    <p class="banner-motivation">A small check-in today keeps your streak strong.</p>

    <div class="banner-cards">
        <div class="frost-card">
            <div class="frost-card-label">Current Streak</div>
            <div class="frost-card-value">🔥 ${moodStreak}</div>
        </div>
        <div class="frost-card">
            <div class="frost-card-label">Today's Mood</div>
            <div class="frost-card-value">
                <c:choose>
                    <c:when test="${not empty todayMood}">${todayMood.moodScore}/5</c:when>
                    <c:otherwise>Not logged</c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="frost-card">
            <div class="frost-card-label">Avg Score</div>
            <div class="frost-card-value">${avgMoodScore}/5</div>
        </div>
    </div>
</section>


<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<section class="sidebar-card">
    <div class="sidebar-header">
        <span>Recent Entries</span>
        <a class="view-all-link" href="${pageContext.request.contextPath}/user/mood-history">View all</a>
    </div>

    <c:choose>
        <c:when test="${empty recentEntries}">
            <p class="empty-text">No mood entries yet. Log your first mood above.</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${recentEntries}" var="entry">
                <div class="recent-entry">
                    <div class="entry-emoji score-${entry.score}">
                        <c:choose>
                            <c:when test="${entry.score == 1}">&#128542;</c:when>
                            <c:when test="${entry.score == 2}">&#128577;</c:when>
                            <c:when test="${entry.score == 3}">&#128528;</c:when>
                            <c:when test="${entry.score == 4}">&#128578;</c:when>
                            <c:otherwise>&#128516;</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="entry-details">
                        <div class="entry-label score-${entry.score}-text">
                            <c:choose>
                                <c:when test="${entry.score == 1}">Very Low</c:when>
                                <c:when test="${entry.score == 2}">Low</c:when>
                                <c:when test="${entry.score == 3}">Okay</c:when>
                                <c:when test="${entry.score == 4}">Good</c:when>
                                <c:otherwise>Excellent</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="entry-date">${entry.entryDate}</div>
                        <c:if test="${not empty entry.note}">
                            <div class="entry-note">
                                ${fn:length(entry.note) > 60 ? fn:substring(entry.note, 0, 60) : entry.note}${fn:length(entry.note) > 60 ? '...' : ''}
                            </div>
                        </c:if>
                        <c:if test="${not empty entry.tags}">
                            <div class="entry-tags">
                                <c:forEach items="${entry.tags}" var="tag" varStatus="st">
                                    ${tag}<c:if test="${!st.last}">, </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</section>



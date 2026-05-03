<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<section class="white-card">
    <div class="card-header">
        <h3>Saved Resources</h3>
        <a href="${pageContext.request.contextPath}/user/bookmarks" class="view-all-link">View all</a>
    </div>

    <c:choose>
        <c:when test="${empty savedResources}">
            <p style="color:#9ca3af;">No saved resources yet.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="r" items="${savedResources}" varStatus="st">
                <div class="resource-row">
                    <div class="resource-info">
                        <div class="resource-title">${r.title}</div>
                        <span class="category-pill" style="
                            background:${st.index % 5 == 0 ? '#ede9fe' : st.index % 5 == 1 ? '#d1fae5' : st.index % 5 == 2 ? '#e0f2fe' : st.index % 5 == 3 ? '#fef3c7' : '#fee2e2'};
                            color:${st.index % 5 == 0 ? '#5b21b6' : st.index % 5 == 1 ? '#065f46' : st.index % 5 == 2 ? '#075985' : st.index % 5 == 3 ? '#92400e' : '#991b1b'};">
                            ${empty r.categoryName ? 'General' : r.categoryName}
                        </span>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</section>


<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="displayName" value="User" />
<c:if test="${not empty sessionScope.loggedUser and not empty sessionScope.loggedUser.name}">
    <c:set var="displayName" value="${fn:trim(sessionScope.loggedUser.name)}" />
</c:if>
<c:set var="resolvedPageTitle" value="${empty requestScope.pageTitle ? 'Dashboard' : requestScope.pageTitle}" />

<header class="topbar" id="topbar">
    <div class="topbar-left">
        <nav class="breadcrumb">
            <span class="breadcrumb-root">MindEase</span>
            <span class="breadcrumb-sep">&rsaquo;</span>
            <span class="breadcrumb-current">${resolvedPageTitle}</span>
        </nav>
    </div>

    <div class="topbar-right">
        <div class="topbar-user">
            <div class="topbar-user-info">
                <span class="topbar-user-name">${displayName}</span>
                <span class="topbar-user-role">${sessionScope.loggedUser.role}</span>
            </div>
            <div class="topbar-avatar">
                ${fn:substring(displayName, 0, 2)}
            </div>
        </div>
    </div>
</header>



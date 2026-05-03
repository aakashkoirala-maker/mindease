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
    <title>My Bookmarks - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro { border-left: 4px solid #2b7a78; padding-left: 16px; margin-bottom: 24px; }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { color: #9ca3af; font-size: 0.82rem; margin-top: 4px; }

        .resource-card {
            background: white; border-radius: 20px; overflow: hidden;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            transition: transform 0.2s, box-shadow 0.2s, opacity 0.2s;
        }
        .resource-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(43,122,120,0.12); }

        .card-image { position: relative; height: 176px; overflow: hidden; background: linear-gradient(135deg, #edf7f6, #f7fbfb); }
        .card-image img { width: 100%; height: 100%; object-fit: cover; object-position: top; }
        .card-image-placeholder { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9ca3af; font-size: 2rem; }

        .bookmark-btn {
            position: absolute; top: 12px; right: 12px;
            width: 36px; height: 36px; border-radius: 36px;
            background: #2b7a78; border: none; cursor: pointer;
            display: flex; align-items: center; justify-content: center;
        }
        .bookmark-btn svg { color: white; width: 1rem; height: 1rem; }

        .card-content { padding: 18px; }
        .card-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; gap: 10px; }
        .category-badge { padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: 600; white-space: nowrap; }
        .read-time { font-size: 0.7rem; color: #9ca3af; white-space: nowrap; }
        .read-time svg { margin-right: 4px; width: 0.82rem; height: 0.82rem; vertical-align: -2px; }

        .resource-title { font-size: 1rem; font-weight: 700; color: #1a2e2e; margin-bottom: 10px; line-height: 1.4; }
        .resource-description { font-size: 0.8rem; color: #6b7280; line-height: 1.5; margin-bottom: 12px; }

        .resource-footer {
            display: flex; justify-content: space-between; align-items: center;
            margin-top: 12px; padding-top: 12px; border-top: 1px solid #f0f4f4; gap: 8px;
        }
        .author-info { display: flex; align-items: center; gap: 8px; min-width: 0; }
        .author-avatar { width: 28px; height: 28px; background: #e6f4f3; color: #2b7a78; border-radius: 28px; display: flex; align-items: center; justify-content: center; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; flex-shrink: 0; }
        .author-name { font-size: 0.7rem; color: #9ca3af; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

        .remove-btn {
            background: none; border: none; color: #ef4444;
            font-size: 0.75rem; font-weight: 600; cursor: pointer;
            display: flex; align-items: center; gap: 6px;
            padding: 6px 12px; border-radius: 30px; transition: all 0.2s; flex-shrink: 0;
        }
        .remove-btn:hover { background: #fee2e2; }

        .empty-state { text-align: center; padding: 80px 20px; background: white; border-radius: 24px; }
        .empty-icon { width: 80px; height: 80px; background: #e6f4f3; border-radius: 80px; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; }
        .empty-icon svg { width: 2rem; height: 2rem; color: #2b7a78; }
        .empty-state h3 { font-size: 1.2rem; color: #1a2e2e; margin-bottom: 8px; }
        .empty-state p { color: #9ca3af; margin-bottom: 20px; }
        .browse-link { display: inline-block; background: linear-gradient(135deg, #2b7a78, #3aafa9); color: white; padding: 10px 28px; border-radius: 40px; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
<div class="user-layout">
    <jsp:include page="/WEB-INF/views/user/includes/sidebar.jsp" />

    <div class="user-main">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />

        <main class="user-content content">
            <div class="page-intro">
                <h1>Saved Resources</h1>
                <p id="bookmarkCountText">${totalBookmarks} ${totalBookmarks == 1 ? 'resource' : 'resources'} in your reading list</p>
            </div>

            <c:choose>
                <c:when test="${empty bookmarkedResources}">
                    <div class="empty-state">
                        <div class="empty-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3h12a1 1 0 0 1 1 1v17l-7-4-7 4V4a1 1 0 0 1 1-1z"></path></svg></div>
                        <h3>No bookmarks yet</h3>
                        <p>Browse resources and bookmark ones you want to revisit.</p>
                        <a href="${pageContext.request.contextPath}/user/resources" class="browse-link">Browse Resources</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="bookmarks-grid" id="bookmarksGrid">
                        <c:forEach items="${bookmarkedResources}" var="resource">
                            <c:set var="safeDesc" value="${empty resource.description ? '' : resource.description}" />
                            <c:set var="safeAuthor" value="${empty resource.authorName ? 'Unknown' : resource.authorName}" />
                            <div class="resource-card" data-resource-id="${resource.resourceId}">
                                <div class="card-image">
                                    <c:choose>
                                        <c:when test="${not empty resource.imageUrl}">
                                            <img src="${resource.imageUrl}" alt="${resource.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="card-image-placeholder"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="34" height="34"><path d="M3 5.5A2.5 2.5 0 0 1 5.5 3H11v18H5.5A2.5 2.5 0 0 1 3 18.5z"></path><path d="M21 5.5A2.5 2.5 0 0 0 18.5 3H13v18h5.5a2.5 2.5 0 0 0 2.5-2.5z"></path></svg></div>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="bookmark-btn" type="button" title="Saved">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3h12a1 1 0 0 1 1 1v17l-7-4-7 4V4a1 1 0 0 1 1-1z"></path></svg>
                                    </button>
                                </div>
                                <div class="card-content">
                                    <div class="card-meta">
                                        <span class="category-badge" style="background: ${resource.colorCode}20; color: ${resource.colorCode}; display:inline-flex; align-items:center; gap:6px;">
                                            <c:choose>
                                                <c:when test="${empty resource.categoryName}">
                                                    <span class="category-icon" style="display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;background:#f3f4f6;border-radius:8px;color:#6b7280;flex-shrink:0;">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                                                    </span>
                                                    General
                                                </c:when>
                                                <c:otherwise>${resource.categoryName}</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="read-time"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 2"></path></svg> ${resource.readTime}</span>
                                    </div>
                                    <h3 class="resource-title">${resource.title}</h3>
                                    <p class="resource-description">
                                        <c:choose>
                                            <c:when test="${fn:length(safeDesc) > 80}">${fn:substring(safeDesc, 0, 80)}...</c:when>
                                            <c:otherwise>${safeDesc}</c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="resource-footer">
                                        <div class="author-info">
                                            <div class="author-avatar">${fn:toUpperCase(fn:substring(safeAuthor, 0, 1))}</div>
                                            <span class="author-name">${safeAuthor}</span>
                                        </div>
                                        <button class="remove-btn" data-id="${resource.resourceId}" type="button">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><path d="M3 6h18"></path><path d="M8 6V4h8v2"></path><path d="M19 6l-1 14H6L5 6"></path><path d="M10 11v6M14 11v6"></path></svg> Remove
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        const href = link.getAttribute('href');
        if (href && (href === currentPath || currentPath.startsWith(href + '/'))) link.classList.add('active');
    });

    const content = document.querySelector('.content');
    const topbar = document.querySelector('.topbar');
    if (content && topbar) {
        content.addEventListener('scroll', () => {
            topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
        });
    }

    function updateBookmarkCount() {
        const remainingCards = document.querySelectorAll('.resource-card').length;
        const countText = document.getElementById('bookmarkCountText');
        if (countText) countText.textContent = remainingCards + ' ' + (remainingCards === 1 ? 'resource' : 'resources') + ' in your reading list';
    }

    document.querySelectorAll('.remove-btn').forEach(btn => {
        btn.addEventListener('click', async function(e) {
            e.stopPropagation();
            const resourceId = this.dataset.id;
            const card = this.closest('.resource-card');
            if (!card) return;
            card.style.opacity = '0';
            setTimeout(() => {
                card.remove();
                updateBookmarkCount();
                if (document.querySelectorAll('.resource-card').length === 0) location.reload();
            }, 200);
            await fetch(contextPath + '/user/toggle-bookmark', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'resourceId=' + encodeURIComponent(resourceId) + '&bookmarked=false'
            });
        });
    });
</script>
</body>
</html>
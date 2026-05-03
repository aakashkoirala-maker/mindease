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
    <title>Browse Resources - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro { border-left: 4px solid #2b7a78; padding-left: 16px; margin-bottom: 24px; }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { font-size: 0.82rem; color: #9ca3af; margin-top: 4px; }

        .hero-blob {
            position: absolute; top: -80px; right: -80px;
            width: 300px; height: 300px;
            background: rgba(167,243,208,0.15);
            border-radius: 50%; filter: blur(60px); pointer-events: none;
        }
        .hero-content { position: relative; z-index: 2; }
        .hero-banner h1 { color: white; font-size: 2rem; font-family: Poppins,'Segoe UI',sans-serif; margin-bottom: 12px; }
        .hero-banner p { color: rgba(255,255,255,0.70); margin-bottom: 28px; }

        .search-container {
            display: flex; align-items: center;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 60px; padding: 6px 20px; max-width: 500px;
        }
        .search-icon { color: rgba(255,255,255,0.70); margin-right: 12px; width: 18px; height: 18px; flex-shrink: 0; }
        .search-input { background: transparent; border: none; padding: 14px 0; color: white; font-size: 1rem; width: 100%; outline: none; }
        .search-input::placeholder { color: rgba(255,255,255,0.50); }

        .category-chip {
            background: white; border: 1px solid #e5e7eb; border-radius: 40px;
            padding: 8px 20px; font-size: 0.85rem; font-weight: 500;
            color: #6b7280; cursor: pointer; white-space: nowrap; transition: all 0.2s;
        }
        .category-chip.active { background: #2b7a78; border-color: #2b7a78; color: white; box-shadow: 0 4px 12px rgba(43,122,120,0.20); }
        .category-chip:hover:not(.active) { background: #f0f4f4; }

        .resource-card {
            background: white; border-radius: 20px; overflow: hidden;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .resource-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(43,122,120,0.12); }

        .card-image { position: relative; height: 176px; overflow: hidden; background: linear-gradient(135deg, #edf7f6, #f7fbfb); }
        .card-image img { width: 100%; height: 100%; object-fit: cover; object-position: top; }
        .card-image-placeholder { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #9ca3af; font-size: 2rem; }

        .bookmark-btn {
            position: absolute; top: 12px; right: 12px;
            width: 36px; height: 36px; border-radius: 36px;
            background: rgba(255,255,255,0.85); border: none; cursor: pointer;
            display: flex; align-items: center; justify-content: center; transition: all 0.2s;
        }
        .bookmark-btn svg { color: #6b7280; width: 1rem; height: 1rem; }
        .bookmark-btn.bookmarked { background: #2b7a78; }
        .bookmark-btn.bookmarked svg { color: white; }

        .card-content { padding: 18px; }
        .card-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; gap: 10px; }
        .category-badge { padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: 600; white-space: nowrap; }
        .read-time { font-size: 0.7rem; color: #9ca3af; white-space: nowrap; }
        .read-time svg { margin-right: 4px; width: 0.82rem; height: 0.82rem; vertical-align: -2px; }

        .resource-title { font-size: 1rem; font-weight: 700; color: #1a2e2e; margin-bottom: 10px; line-height: 1.4; }
        .resource-description { font-size: 0.8rem; color: #6b7280; line-height: 1.5; margin-bottom: 12px; }
        .read-more-btn { background: none; border: none; color: #2b7a78; font-size: 0.75rem; font-weight: 600; cursor: pointer; padding: 0; margin-left: 4px; }

        .resource-author { display: flex; align-items: center; gap: 10px; margin-top: 8px; padding-top: 12px; border-top: 1px solid #f0f4f4; }
        .resource-action { margin-top: 12px; }
        .resource-link-btn { display: inline-block; padding: 8px 14px; border-radius: 10px; background: #2b7a78; color: #ffffff; text-decoration: none; font-size: 0.8rem; font-weight: 600; }
        .resource-link-disabled { display: inline-block; padding: 8px 14px; border-radius: 10px; background: #f3f4f6; color: #9ca3af; font-size: 0.8rem; font-weight: 600; }

        .author-avatar { width: 28px; height: 28px; background: #e6f4f3; color: #2b7a78; border-radius: 28px; display: flex; align-items: center; justify-content: center; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; }
        .author-name { font-size: 0.7rem; color: #9ca3af; }

        .empty-state { grid-column: 1 / -1; text-align: center; padding: 60px 20px; }
        .empty-icon { width: 80px; height: 80px; background: #e6f4f3; border-radius: 80px; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; }
        .empty-icon svg { width: 2rem; height: 2rem; color: #2b7a78; }
        .empty-state h3 { font-size: 1.2rem; color: #1a2e2e; margin-bottom: 8px; }
        .empty-state p { color: #9ca3af; }

        .pagination { display: flex; justify-content: center; gap: 8px; margin-top: 40px; }
        .page-btn { background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 8px 14px; color: #6b7280; text-decoration: none; transition: all 0.2s; }
        .page-btn.active { background: #2b7a78; border-color: #2b7a78; color: white; }
        .page-btn:hover:not(.active) { background: #f0f4f4; }

        @media (max-width: 768px) {
            .hero-banner h1 { font-size: 1.3rem; }
            .search-container { max-width: 100%; }
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
                <h1>Browse Resources</h1>
                <p>Discover curated articles and tools for mental wellness.</p>
            </div>

            <div class="hero-banner">
                <div class="hero-blob"></div>
                <div class="hero-content">
                    <h1>Explore Mental Wellness Resources</h1>
                    <p>Curated articles, guides, and tools to support your mental health journey</p>
                    <div class="search-container">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"></circle><path d="m21 21-4.3-4.3"></path></svg>
                        <label for="searchInput" class="sr-only">Search resources</label>
                        <input type="text" id="searchInput" class="search-input"
                               placeholder="Search by title, author, or keyword..."
                               value="${searchQuery}">
                    </div>
                </div>
            </div>

            <div class="categories-wrapper">
                <div class="categories-scroll">
                    <button class="category-chip ${empty selectedCategory or selectedCategory == 'all' ? 'active' : ''}" data-category="all">All</button>
                    <c:forEach items="${categories}" var="cat">
                        <c:choose>
                            <c:when test="${selectedCategory != 'all' and selectedCategory == cat.categoryId.toString()}">
                                <button class="category-chip active" data-category="${cat.categoryId}">${cat.name}</button>
                            </c:when>
                            <c:otherwise>
                                <button class="category-chip" data-category="${cat.categoryId}">${cat.name}</button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>

            <div class="resources-grid" id="resourcesGrid">
                <c:choose>
                    <c:when test="${empty resources}">
                        <div class="empty-state">
                            <div class="empty-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"></circle><path d="m21 21-4.3-4.3"></path></svg></div>
                            <h3>No resources found</h3>
                            <p>Try adjusting your search or filter to find what you're looking for</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${resources}" var="resource">
                            <c:set var="isBookmarked" value="false" />
                            <c:forEach items="${bookmarkedIds}" var="bookmarkedId">
                                <c:if test="${bookmarkedId == resource.resourceId}">
                                    <c:set var="isBookmarked" value="true" />
                                </c:if>
                            </c:forEach>

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
                                    <c:choose>
                                        <c:when test="${isBookmarked}">
                                            <button class="bookmark-btn bookmarked" data-id="${resource.resourceId}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3h12a1 1 0 0 1 1 1v17l-7-4-7 4V4a1 1 0 0 1 1-1z"></path></svg></button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="bookmark-btn" data-id="${resource.resourceId}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3h12a1 1 0 0 1 1 1v17l-7-4-7 4V4a1 1 0 0 1 1-1z"></path></svg></button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-content">
                                    <div class="card-meta">
                                        <span class="category-badge"
                                              style="background: ${resource.colorCode}20; color: ${resource.colorCode};"
                                              data-category="${resource.categoryName}">
                                                ${resource.categoryName}
                                        </span>
                                        <span class="read-time"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 2"></path></svg> ${resource.readTime}</span>
                                    </div>
                                    <h3 class="resource-title">${resource.title}</h3>
                                    <p class="resource-description">
                                        <c:set var="safeDesc" value="${empty resource.description ? '' : resource.description}" />
                                        <span class="desc-short">
                                            <c:choose>
                                                <c:when test="${fn:length(safeDesc) > 80}">${fn:substring(safeDesc, 0, 80)}...</c:when>
                                                <c:otherwise>${safeDesc}</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="desc-full" style="display:none;">${safeDesc}</span>
                                        <c:if test="${fn:length(safeDesc) > 80}">
                                            <button type="button" class="read-more-btn">Read more</button>
                                        </c:if>
                                    </p>
                                    <c:if test="${not empty resource.tags}">
                                        <div class="resource-tags">
                                            <c:forTokens items="${resource.tags}" delims="," var="tag">
                                                <span class="tag-pill">#${fn:trim(tag)}</span>
                                            </c:forTokens>
                                        </div>
                                    </c:if>
                                    <div class="resource-author">
                                        <c:set var="safeAuthor" value="${empty resource.authorName ? 'Unknown' : resource.authorName}" />
                                        <div class="author-avatar">${fn:toUpperCase(fn:substring(safeAuthor, 0, 1))}</div>
                                        <span class="author-name">${safeAuthor}</span>
                                    </div>
                                    <div class="resource-action">
                                        <c:choose>
                                            <c:when test="${not empty resource.url}">
                                                <a href="${resource.url}" target="_blank" rel="noopener noreferrer" class="resource-link-btn">Read Article -&gt;</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="resource-link-disabled">No link available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${totalResources > 9}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${currentPage == i}">
                                <a href="${pageContext.request.contextPath}/user/resources?page=${i}&search=${searchQuery}&category=${selectedCategory}" class="page-btn active">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/resources?page=${i}&search=${searchQuery}&category=${selectedCategory}" class="page-btn">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>
        </main>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const selectedCategory = '${selectedCategory}';

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

    const searchInput = document.getElementById('searchInput');
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            const search = encodeURIComponent(this.value || '');
            window.location.href = contextPath + '/user/resources?search=' + search + '&category=' + encodeURIComponent(selectedCategory || 'all');
        }
    });

    document.querySelectorAll('.category-chip').forEach(chip => {
        chip.addEventListener('click', function() {
            const category = this.dataset.category;
            const search = encodeURIComponent(searchInput.value || '');
            window.location.href = contextPath + '/user/resources?search=' + search + '&category=' + encodeURIComponent(category);
        });
    });

    document.querySelectorAll('.bookmark-btn').forEach(btn => {
        btn.addEventListener('click', async function(e) {
            e.stopPropagation();
            const resourceId = this.dataset.id;
            const isBookmarked = this.classList.contains('bookmarked');
            const response = await fetch(contextPath + '/user/toggle-bookmark', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'resourceId=' + encodeURIComponent(resourceId) + '&bookmarked=' + encodeURIComponent(String(!isBookmarked))
            });
            if (response.ok) this.classList.toggle('bookmarked');
        });
    });

    document.querySelectorAll('.read-more-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const descShort = this.parentElement.querySelector('.desc-short');
            const descFull = this.parentElement.querySelector('.desc-full');
            if (descFull.style.display === 'none') {
                descShort.style.display = 'none';
                descFull.style.display = 'inline';
                this.textContent = 'Show less';
            } else {
                descShort.style.display = 'inline';
                descFull.style.display = 'none';
                this.textContent = 'Read more';
            }
        });
    });
</script>
</body>
</html>
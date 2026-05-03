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
    <title>Log Mood - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro {
            border-left: 4px solid #2b7a78;
            padding-left: 16px;
            margin-bottom: 24px;
        }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { font-size: 0.82rem; color: #9ca3af; margin-top: 4px; }

        .log-mood-grid {
            display: grid;
            grid-template-columns: 3fr 2fr;
            gap: 24px;
        }

        .log-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            padding: 22px 24px;
            margin-bottom: 20px;
            min-width: 0;
        }
        .log-card h2 { color: #1a2e2e; font-size: 1.12rem; margin-bottom: 6px; }
        .log-card-sub { color: #9ca3af; font-size: 0.84rem; }

        .mood-buttons {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 12px;
            margin-top: 18px;
        }

        .mood-btn {
            border: 1.5px solid #e5e7eb;
            background: #ffffff;
            border-radius: 16px;
            padding: 16px 10px;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            min-width: 0;
            word-break: break-word;
        }
        .mood-btn:hover { border-color: #cbd5e1; transform: translateY(-1px); }
        .mood-btn.selected { transform: scale(1.05); border-width: 2px; }
        .mood-btn[data-score="1"].selected { background: #fee2e2; border-color: #fca5a5; }
        .mood-btn[data-score="2"].selected { background: #fde8d8; border-color: #fdba74; }
        .mood-btn[data-score="3"].selected { background: #fef9c3; border-color: #fde68a; }
        .mood-btn[data-score="4"].selected { background: #dcfce7; border-color: #86efac; }
        .mood-btn[data-score="5"].selected { background: #d1fae5; border-color: #34d399; }

        .mood-emoji { display: block; font-size: 2rem; line-height: 1; margin-bottom: 8px; }
        .mood-label { display: block; font-size: 0.86rem; font-weight: 700; color: #1f2937; }
        .mood-sublabel { display: block; font-size: 0.72rem; color: #6b7280; margin-top: 4px; }

        .journal-note {
            width: 100%;
            min-height: 108px;
            border: 1.5px solid #e5e7eb;
            border-radius: 14px;
            padding: 12px;
            font-size: 0.9rem;
            resize: vertical;
            outline: none;
            transition: all 0.2s;
        }
        .journal-note:focus { border-color: #2b7a78; background: #f0fbfa; }

        .char-counter { text-align: right; font-size: 0.72rem; color: #9ca3af; margin-top: 6px; }

        .submit-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 40px;
            font-weight: 700;
            font-size: 0.98rem;
            cursor: pointer;
            margin-top: 8px;
            transition: all 0.2s;
            background: linear-gradient(135deg, #2b7a78, #3aafa9);
            color: #ffffff;
        }
        .submit-btn:disabled { background: #e5e7eb; color: #9ca3af; cursor: not-allowed; }

        .right-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            padding: 20px;
            margin-bottom: 20px;
            min-width: 0;
        }
        .right-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }
        .right-card-header h3 { font-size: 1.02rem; color: #1a2e2e; }

        .empty-state { color: #9ca3af; font-size: 0.85rem; }

        .wellness-tip-card {
            background: linear-gradient(135deg, #ede9fe, #fce7f3);
            border-radius: 16px;
            padding: 20px;
        }
        .wellness-icon { color: #7c3aed; font-size: 1.35rem; }
        .wellness-tip-card h3 { margin-top: 8px; margin-bottom: 8px; color: #7c3aed; font-size: 1.04rem; font-weight: 700; }
        .wellness-tip-card p { color: #4b5563; line-height: 1.5; font-size: 0.88rem; }

        .alert-info {
            background: #e6f4f3;
            color: #1f4f4e;
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 16px;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 1024px) {
            .log-mood-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 768px) {
            .mood-buttons {
                grid-template-columns: repeat(5, minmax(0, 1fr));
                gap: 8px;
            }
            .mood-emoji { font-size: 1.5rem; }
            .mood-label { font-size: 0.75rem; }
            .mood-sublabel { display: none; }
            .mood-btn { padding: 12px 4px; }
        }

        @media (max-width: 480px) {
            .mood-buttons { grid-template-columns: repeat(3, minmax(0, 1fr)); }
            .mood-sublabel { display: none; }
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
                <h1>Log Mood</h1>
                <p>Track how you feel today and capture your reflections.</p>
            </div>

            <c:if test="${param.success == 'true'}">
                <div class="alert-success">Mood saved successfully.</div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert-error">${param.error}</div>
            </c:if>
            <c:if test="${hasTodayEntry}">
                <div class="alert-info">You already logged a mood today. Edit below or wait until tomorrow.</div>
            </c:if>

            <section class="log-mood-grid">
                <div class="left-column">
                    <form id="moodForm" method="post" action="${pageContext.request.contextPath}/user/log-mood">
                        <div class="log-card">
                            <h2>How are you feeling right now?</h2>
                            <p class="log-card-sub">Select a mood score from 1 to 5</p>
                            <div class="mood-buttons">
                                <button type="button" class="mood-btn ${todayMood.score == 1 ? 'selected' : ''}" data-score="1" data-label="Very Low">
                                    <span class="mood-emoji">&#128542;</span>
                                    <span class="mood-label">Very Low</span>
                                    <span class="mood-sublabel">Having a tough time</span>
                                </button>
                                <button type="button" class="mood-btn ${todayMood.score == 2 ? 'selected' : ''}" data-score="2" data-label="Low">
                                    <span class="mood-emoji">&#128577;</span>
                                    <span class="mood-label">Low</span>
                                    <span class="mood-sublabel">A bit stressed today</span>
                                </button>
                                <button type="button" class="mood-btn ${todayMood.score == 3 ? 'selected' : ''}" data-score="3" data-label="Okay">
                                    <span class="mood-emoji">&#128528;</span>
                                    <span class="mood-label">Okay</span>
                                    <span class="mood-sublabel">Neutral and balanced</span>
                                </button>
                                <button type="button" class="mood-btn ${todayMood.score == 4 ? 'selected' : ''}" data-score="4" data-label="Good">
                                    <span class="mood-emoji">&#128578;</span>
                                    <span class="mood-label">Good</span>
                                    <span class="mood-sublabel">Feeling positive</span>
                                </button>
                                <button type="button" class="mood-btn ${todayMood.score == 5 ? 'selected' : ''}" data-score="5" data-label="Excellent">
                                    <span class="mood-emoji">&#128516;</span>
                                    <span class="mood-label">Excellent</span>
                                    <span class="mood-sublabel">Great energy today</span>
                                </button>
                            </div>
                        </div>

                        <div class="log-card">
                            <h2>What's contributing to this feeling?</h2>
                            <div class="tags-container">
                                <c:forEach items="${allTags}" var="tag">
                                    <c:set var="isSelected" value="false" />
                                    <c:forEach items="${todaySelectedTagNames}" var="selectedTagName">
                                        <c:if test="${selectedTagName == tag.tagName}">
                                            <c:set var="isSelected" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <button type="button" class="tag-pill ${isSelected ? 'selected' : ''}" data-tag-id="${tag.tagId}">${tag.tagName}</button>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="log-card">
                            <h2>Journal Note</h2>
                            <textarea id="moodNote" name="note" maxlength="500" class="journal-note" placeholder="Write about how you're feeling... (optional)">${todayMood.note}</textarea>
                            <div class="char-counter"><span id="charCount">0</span>/500</div>
                        </div>

                        <input type="hidden" name="score" id="selectedScore" value="${todayMood.score}">
                        <input type="hidden" name="selectedTags" id="selectedTags" value="">

                        <c:choose>
                            <c:when test="${empty todayMood}">
                                <button type="submit" id="submitBtn" class="submit-btn" disabled>Select a mood to continue</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" id="submitBtn" class="submit-btn">Update Today's Mood</button>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>

                <div>
                    <section class="right-card">
                        <div class="right-card-header">
                            <h3>Recent Entries</h3>
                            <a class="view-all-link" href="${pageContext.request.contextPath}/user/mood-history">View all</a>
                        </div>
                        <c:choose>
                            <c:when test="${empty recentEntries}">
                                <p class="empty-state">No mood entries yet. Log your first mood above.</p>
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
                                        <div>
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

                    <section class="right-card wellness-tip-card">
                        <div class="wellness-icon">&#128161;</div>
                        <h3>Wellness Tip</h3>
                        <p>${wellnessTip}</p>
                    </section>
                </div>
            </section>
        </main>
    </div>
</div>

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

        const scoreInput = document.getElementById('selectedScore');
        const tagsInput = document.getElementById('selectedTags');
        const submitBtn = document.getElementById('submitBtn');
        const moodButtons = document.querySelectorAll('.mood-btn');

        moodButtons.forEach(btn => {
            btn.addEventListener('click', function () {
                moodButtons.forEach(b => b.classList.remove('selected'));
                this.classList.add('selected');
                scoreInput.value = this.dataset.score;
                submitBtn.disabled = false;
                submitBtn.textContent = 'Save Mood - ' + this.dataset.label;
            });
        });

        const selectedTagIds = new Set();
        document.querySelectorAll('.tag-pill').forEach(tag => {
            if (tag.classList.contains('selected')) selectedTagIds.add(tag.dataset.tagId);
            tag.addEventListener('click', function () {
                this.classList.toggle('selected');
                if (this.classList.contains('selected')) {
                    selectedTagIds.add(this.dataset.tagId);
                } else {
                    selectedTagIds.delete(this.dataset.tagId);
                }
                tagsInput.value = Array.from(selectedTagIds).join(',');
            });
        });
        tagsInput.value = Array.from(selectedTagIds).join(',');

        const note = document.getElementById('moodNote');
        const charCount = document.getElementById('charCount');
        const syncCount = () => { charCount.textContent = String(note.value.length); };
        syncCount();
        note.addEventListener('input', syncCount);
    })();
</script>
</body>
</html>
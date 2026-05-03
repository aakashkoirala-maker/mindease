<%-- This is a messages jsp --%>

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
    <title>Messages - MindEase Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/admin/includes/sidebar.jsp" />
    <div class="main-area">
        <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />
        <main class="content">
            <div class="page-intro">
                <h1>Messages</h1>
                <p>View and respond to user inquiries</p>
            </div>

            <c:if test="${param.success == 'true'}"><div class="alert-success">Reply sent successfully.</div></c:if>
            <c:if test="${param.error == 'true'}"><div class="alert-error">Could not process your request. Please try again.</div></c:if>

            <c:choose>
                <c:when test="${empty viewMessage}">
                    <div class="filter-tabs">
                        <button type="button" class="filter-pill active" data-filter="all">All</button>
                        <button type="button" class="filter-pill" data-filter="pending">Pending</button>
                        <button type="button" class="filter-pill" data-filter="replied">Replied</button>
                    </div>
                    <div class="table-card table-responsive">
                        <table>
                            <thead>
                            <tr>
                                <th>User</th>
                                <th>Subject</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="messagesTableBody">
                            <c:choose>
                                <c:when test="${empty allMessages}">
                                    <tr><td colspan="6" class="empty-state">No messages found.</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${allMessages}" var="msg">
                                        <tr data-status="${msg.status}">
                                            <td>
                                                <div class="user-cell">
                                                    <div class="user-avatar">
                                                        <c:choose>
                                                            <c:when test="${not empty msg.userName}">${fn:substring(msg.userName, 0, 1)}</c:when>
                                                            <c:otherwise>U</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>${msg.userName}</span>
                                                </div>
                                            </td>
                                            <td class="subject-cell">
                                                <c:choose>
                                                    <c:when test="${fn:length(msg.subject) > 40}">${fn:substring(msg.subject, 0, 40)}...</c:when>
                                                    <c:otherwise>${msg.subject}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${msg.category}</td>
                                            <td><span class="status-flat status-${msg.status}">${msg.status}</span></td>
                                            <td>${fn:substring(msg.createdAt.toString(), 0, 10)}</td>
                                            <td><a class="action-link" href="${ctx}/admin/messages?id=${msg.messageId}">View &amp; Reply</a></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="detail-grid">
                        <div class="detail-card">
                            <a class="back-link" href="${ctx}/admin/messages">&larr; Back to all messages</a>
                            <div style="display:flex;align-items:center;justify-content:space-between;gap:10px;">
                                <div>
                                    <div style="font-size:0.92rem;font-weight:700;color:#1f2937;">${viewMessage.userName}</div>
                                    <div style="font-size:0.8rem;color:#6b7280;">${viewMessage.userEmail}</div>
                                </div>
                                <span class="status-flat status-${viewMessage.status}">${viewMessage.status}</span>
                            </div>
                            <div style="margin-top:14px;font-size:1.1rem;font-weight:700;color:#1f2937;">${viewMessage.subject}</div>
                            <div style="margin-top:8px;"><span class="status-flat" style="background:#e6f4f3;color:#2b7a78;">${viewMessage.category}</span></div>
                            <div class="message-box">${viewMessage.message}</div>
                            <div class="meta-line">Date sent: ${fn:substring(viewMessage.createdAt.toString(), 0, 19)}</div>
                            <c:if test="${viewMessage.status == 'replied' and not empty viewMessage.adminReply}">
                                <div class="reply-preview">
                                    <div class="reply-label">
                                        <div class="reply-avatar">A</div>
                                        <span>Admin Response</span>
                                        <span class="reply-time">${fn:substring(viewMessage.repliedAt.toString(), 0, 19)}</span>
                                    </div>
                                    <p class="reply-thread-body">${viewMessage.adminReply}</p>
                                </div>
                            </c:if>
                        </div>
                        <div class="detail-card">
                            <div style="font-size:0.72rem;color:#2b7a78;font-weight:700;letter-spacing:0.08em;">REPLY</div>
                            <div style="font-size:1rem;font-weight:700;color:#1f2937;margin-top:6px;">Respond to this message</div>
                            <c:choose>
                                <c:when test="${viewMessage.status == 'pending'}">
                                    <form method="post" action="${ctx}/admin/messages">
                                        <input type="hidden" name="messageId" value="${viewMessage.messageId}">
                                        <label for="adminReply" style="display:block;margin-top:14px;font-size:0.78rem;color:#374151;font-weight:600;">Your Reply</label>
                                        <textarea id="adminReply" name="adminReply" rows="6" class="reply-area" required></textarea>
                                        <button type="submit" class="reply-btn">Send Reply</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="reply-disabled">Already replied. This message is closed.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script>
    (function () {
        const content = document.querySelector('.content');
        const topbar = document.querySelector('.topbar');
        if (content && topbar) {
            content.addEventListener('scroll', function() {
                topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
            });
        }
        const filterButtons = document.querySelectorAll('.filter-pill');
        const rows = document.querySelectorAll('#messagesTableBody tr[data-status]');
        filterButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                filterButtons.forEach(function(btn) { btn.classList.remove('active'); });
                this.classList.add('active');
                const filter = this.getAttribute('data-filter');
                rows.forEach(function(row) {
                    row.style.display = (filter === 'all' || row.getAttribute('data-status') === filter) ? '' : 'none';
                });
            });
        });
    })();
</script>
</body>
</html>
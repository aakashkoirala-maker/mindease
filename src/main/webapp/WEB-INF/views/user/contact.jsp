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
  <title>Contact Support - MindEase</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
  <style>
    .contact-page { max-width: 1280px; margin: 0 auto; padding: 20px 5%; }
    .page-header { margin-bottom: 28px; }
    .page-header h1 { font-size: 1.5rem; font-weight: 700; color: #1a2e2e; margin-bottom: 6px; }
    .page-header p { color: #9ca3af; font-size: 0.85rem; }

    .contact-left { min-width: 0; }
    .contact-right { position: sticky; top: 20px; }

    .contact-card { background: white; border-radius: 16px; border: 1px solid #e5e7eb; padding: 24px; }
    .info-card { background: white; border-radius: 16px; border: 1px solid #e5e7eb; padding: 24px; }

    .card-label { font-size: 0.7rem; color: #2b7a78; font-weight: 700; letter-spacing: 0.08em; margin-bottom: 8px; }
    .contact-card h3 { font-size: 1.1rem; font-weight: 700; color: #1a2e2e; margin-bottom: 20px; }
    .info-card h4 { font-size: 1rem; font-weight: 700; color: #1a2e2e; margin-bottom: 16px; }

    .form-group { margin-bottom: 18px; }
    .form-group label { display: block; font-size: 0.8rem; font-weight: 600; color: #374151; margin-bottom: 6px; }
    .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-size: 0.85rem; outline: none; }
    .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: #2b7a78; }
    .char-counter { text-align: right; font-size: 0.7rem; color: #9ca3af; margin-top: 4px; }
    .btn-submit { width: 100%; background: linear-gradient(135deg, #2b7a78, #3aafa9); color: white; border: none; border-radius: 8px; padding: 12px; font-weight: 600; cursor: pointer; }

    .history-table { width: 100%; border-collapse: collapse; }
    .history-table th { text-align: left; padding: 12px 8px; background: #f8fafc; font-size: 0.75rem; font-weight: 600; color: #6b7280; }
    .history-table td { padding: 12px 8px; border-bottom: 1px solid #f1f5f9; font-size: 0.8rem; }
    .preview-cell { color: #6b7280; max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .status-badge { display: inline-block; padding: 2px 8px; border-radius: 20px; font-size: 0.7rem; font-weight: 600; }
    .status-pending { background: #fef3c7; color: #92400e; }
    .status-replied { background: #d1fae5; color: #065f46; }
    .view-reply-btn { background: none; border: 1px solid #2b7a78; color: #2b7a78; padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; cursor: pointer; }
    .empty-history { text-align: center; padding: 32px; color: #9ca3af; }

    .hours-list, .contact-list { list-style: none; padding: 0; margin: 0; }
    .hours-list li { padding: 6px 0; font-size: 0.85rem; color: #6b7280; }
    .hours-list li span { font-weight: 600; color: #1a2e2e; min-width: 80px; display: inline-block; }
    .contact-list li { padding: 8px 0; font-size: 0.85rem; color: #6b7280; }
    .response-time { font-size: 0.75rem; color: #2b7a78; margin-top: 12px; padding-top: 12px; border-top: 1px solid #f1f5f9; }

    @media (max-width: 768px) {
      .history-table { min-width: 500px; }
    }
  </style>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="user-layout">
  <jsp:include page="/WEB-INF/views/user/includes/sidebar.jsp" />

  <div class="user-main">
    <jsp:include page="/WEB-INF/views/admin/includes/topbar.jsp" />

    <main class="user-content content">
      <div class="contact-page">
        <div class="page-header">
          <h1>Contact Support</h1>
          <p>Send us a message and we'll get back to you shortly.</p>
        </div>

        <c:if test="${param.success == 'true'}">
          <div class="alert-success">Your message has been sent successfully.</div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="alert-error">${error}</div>
        </c:if>

        <div class="contact-grid">
          <div class="contact-left">
            <div class="contact-card">
              <div class="card-label">NEW MESSAGE</div>
              <h3>Send us a message</h3>
              <form method="post" action="${ctx}/user/contact" id="contactForm">
                <div class="form-group">
                  <label>Name</label>
                  <input type="text" value="${sessionScope.loggedUser.name}" disabled style="background:#f3f4f6;">
                </div>
                <div class="form-group">
                  <label>Category</label>
                  <select name="category" required>
                    <option value="">Select category</option>
                    <option value="Technical Issue" ${formCategory == 'Technical Issue' ? 'selected' : ''}>Technical Issue</option>
                    <option value="Account Help" ${formCategory == 'Account Help' ? 'selected' : ''}>Account Help</option>
                    <option value="General Inquiry" ${formCategory == 'General Inquiry' ? 'selected' : ''}>General Inquiry</option>
                    <option value="Feedback" ${formCategory == 'Feedback' ? 'selected' : ''}>Feedback</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>Subject</label>
                  <input type="text" name="subject" placeholder="Brief description of your inquiry" required maxlength="200" value="${formSubject}">
                </div>
                <div class="form-group">
                  <label>Message</label>
                  <textarea id="message" name="message" rows="5" placeholder="Tell us what you need help with..." required maxlength="500">${formMessage}</textarea>
                  <div class="char-counter"><span id="charCount">0</span> / 500</div>
                </div>
                <button type="submit" class="btn-submit">Send Message</button>
              </form>
            </div>

            <div class="contact-card" style="margin-top:24px;">
              <div class="card-label">MESSAGE HISTORY</div>
              <h3>Your previous inquiries</h3>
              <c:choose>
                <c:when test="${empty messages}">
                  <div class="empty-history">No previous messages.</div>
                </c:when>
                <c:otherwise>
                  <div class="table-responsive">
                    <table class="history-table">
                      <thead>
                      <tr><th>Subject</th><th>Category</th><th>Status</th><th>Date</th><th>Message</th><th>Reply</th></tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${messages}" var="msg">
                        <tr>
                          <td><strong><c:choose><c:when test="${fn:length(msg.subject) > 40}">${fn:substring(msg.subject, 0, 40)}...</c:when><c:otherwise>${msg.subject}</c:otherwise></c:choose></strong></td>
                          <td>${msg.category}</td>
                          <td><span class="status-badge status-${msg.status}">${msg.status}</span></td>
                          <td>${fn:substring(msg.createdAt.toString(), 0, 10)}</td>
                          <td class="preview-cell"><c:choose><c:when test="${fn:length(msg.message) > 50}">${fn:substring(msg.message, 0, 50)}...</c:when><c:otherwise>${msg.message}</c:otherwise></c:choose></td>
                          <td>
                            <c:if test="${msg.status == 'replied'}"><button type="button" class="view-reply-btn" data-message="${fn:escapeXml(msg.message)}" data-reply="${fn:escapeXml(msg.adminReply)}">View Reply</button></c:if>
                            <c:if test="${msg.status != 'replied'}">&mdash;</c:if>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="contact-right">
            <div class="info-card">
              <h4>Support Hours</h4>
              <ul class="hours-list">
                <li><span>Mon - Fri:</span> 9:00 AM - 6:00 PM</li>
                <li><span>Saturday:</span> 10:00 AM - 3:00 PM</li>
                <li><span>Sunday:</span> Closed</li>
              </ul>
              <p class="response-time">Typical response within 24 hours</p>
            </div>
            <div class="info-card" style="margin-top:20px;">
              <h4>Reach Us</h4>
              <ul class="contact-list">
                <li>Email: support@mindease.app</li>
                <li>Phone: +977 9842236927</li>
                <li>Address: Itahari-9</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<div id="replyModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:1000;align-items:center;justify-content:center;">
  <div style="background:white;max-width:500px;width:90%;border-radius:16px;padding:24px;">
    <h3 style="margin-bottom:16px;">Message Details</h3>
    <div style="margin-bottom:16px;">
      <div style="font-weight:600;margin-bottom:4px;">Your Message:</div>
      <div id="modalMessage" style="background:#f8fafc;padding:12px;border-radius:8px;"></div>
    </div>
    <div style="margin-bottom:20px;">
      <div style="font-weight:600;margin-bottom:4px;">Admin Reply:</div>
      <div id="modalReply" style="background:#f0fdf4;padding:12px;border-radius:8px;border-left:3px solid #10b981;"></div>
    </div>
    <button onclick="closeModal()" style="background:#e5e7eb;border:none;padding:8px 20px;border-radius:8px;cursor:pointer;">Close</button>
  </div>
</div>

<script>
  const content = document.querySelector('.content');
  const topbar = document.querySelector('.topbar');
  if (content && topbar) {
    content.addEventListener('scroll', function() {
      topbar.style.boxShadow = content.scrollTop > 10 ? '0 2px 16px rgba(0,0,0,0.08)' : 'none';
    });
  }

  const message = document.getElementById('message');
  const charCount = document.getElementById('charCount');
  if (message && charCount) {
    const updateCount = function() { charCount.textContent = String(message.value.length); };
    updateCount();
    message.addEventListener('input', updateCount);
  }

  document.querySelectorAll('.view-reply-btn').forEach(function(btn) {
    btn.addEventListener('click', function() {
      document.getElementById('modalMessage').textContent = this.dataset.message;
      document.getElementById('modalReply').textContent = this.dataset.reply;
      document.getElementById('replyModal').style.display = 'flex';
    });
  });

  function closeModal() { document.getElementById('replyModal').style.display = 'none'; }

  window.addEventListener('click', function(event) {
    const modal = document.getElementById('replyModal');
    if (event.target === modal) closeModal();
  });
</script>
</body>
</html>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - MindEase</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .page-intro { border-left: 4px solid #2b7a78; padding-left: 16px; margin-bottom: 24px; }
        .page-intro h1 { font-size: 1.3rem; font-weight: 700; color: #1f2937; }
        .page-intro p { font-size: 0.82rem; color: #9ca3af; margin-top: 4px; }

        .counselor-card {
            background: white; border-radius: 20px; padding: 20px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            cursor: pointer; transition: all 0.2s;
            position: relative; border: 2px solid transparent;
        }
        .counselor-card.selected { border-color: #2b7a78; }

        .selected-badge {
            position: absolute; top: 12px; right: 12px;
            width: 24px; height: 24px; background: #2b7a78;
            border-radius: 24px; display: flex; align-items: center;
            justify-content: center; color: white; font-size: 0.7rem;
        }

        .counselor-header { display: flex; gap: 16px; margin-bottom: 12px; }
        .counselor-photo { width: 56px; height: 56px; background: #e6f4f3; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: #2b7a78; }
        .counselor-info h3 { font-size: 1.1rem; font-weight: 700; color: #1a2e2e; margin-bottom: 4px; }
        .counselor-specialty { font-size: 0.8rem; color: #9ca3af; }
        .counselor-bio { font-size: 0.8rem; color: #6b7280; margin: 10px 0; line-height: 1.4; }
        .counselor-meta { display: flex; gap: 16px; margin-top: 10px; font-size: 0.75rem; color: #6b7280; }
        .counselor-meta svg { color: #2b7a78; margin-right: 4px; width: 14px; height: 14px; vertical-align: -2px; }

        .booking-card {
            background: white; border-radius: 20px; padding: 24px;
            box-shadow: 0 2px 12px rgba(43,122,120,0.08);
            position: sticky; top: 20px;
        }

        .selected-counselor-preview {
            background: #f0fbfa; border-radius: 16px; padding: 16px;
            display: flex; align-items: center; gap: 14px; margin-bottom: 20px;
        }
        .preview-photo { width: 48px; height: 48px; background: #2b7a78; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.85rem; font-weight: 600; color: #374151; margin-bottom: 8px; }
        .form-group input, .form-group textarea {
            width: 100%; padding: 12px 14px;
            border: 1.5px solid #e5e7eb; border-radius: 12px;
            font-size: 0.9rem; outline: none; transition: all 0.2s;
        }
        .form-group input:focus, .form-group textarea:focus { border-color: #2b7a78; background: #f0fbfa; }

        .time-slots { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
        .time-slot { background: #f3f4f6; color: #6b7280; border: none; border-radius: 30px; padding: 8px 12px; font-size: 0.8rem; cursor: pointer; transition: all 0.2s; }
        .time-slot.selected { background: #2b7a78; color: white; }

        .submit-btn { width: 100%; padding: 14px; border-radius: 40px; border: none; font-weight: 600; font-size: 1rem; cursor: pointer; margin-top: 20px; }
        .submit-btn:disabled { background: #e5e7eb; color: #9ca3af; cursor: not-allowed; }
        .submit-btn:not(:disabled) { background: linear-gradient(135deg, #2b7a78, #3aafa9); color: white; }

        .error-card { background: #fee2e2; color: #991b1b; padding: 12px 16px; border-radius: 10px; margin-bottom: 20px; border-left: 4px solid #ef4444; }

        @media (max-width: 768px) {
            .booking-card { position: static; }
            .time-slots { grid-template-columns: repeat(2, 1fr); }
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
                <h1>Book Appointment</h1>
                <p>Select a counselor and request your preferred session slot.</p>
            </div>

            <c:if test="${param.error == 'true'}">
                <div class="error-card">Unable to book appointment. Please check your inputs and try again.</div>
            </c:if>

            <div class="two-column-grid">
                <div>
                    <div class="counselors-grid" id="counselorsGrid">
                        <c:forEach items="${counselors}" var="c">
                            <div class="counselor-card" data-id="${c.counselorId}" data-name="${c.name}" data-specialty="${c.specialization}">
                                <div class="counselor-header">
                                    <div class="counselor-photo"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="24" height="24"><circle cx="12" cy="8" r="4"></circle><path d="M4 20c1.5-3.5 4.2-5 8-5s6.5 1.5 8 5"></path></svg></div>
                                    <div class="counselor-info">
                                        <h3>${c.name}</h3>
                                        <div class="counselor-specialty">${empty c.specialization ? 'Mental Health Counselor' : c.specialization}</div>
                                    </div>
                                </div>
                                <div class="counselor-bio">Dedicated mental health professional focused on supportive, evidence-based guidance.</div>
                                <div class="counselor-meta">
                                    <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg> ${empty c.availableDays ? 'Mon-Fri' : c.availableDays}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div>
                    <div class="booking-card" id="bookingCard">
                        <div id="noSelectionMsg" style="text-align:center;padding:40px 20px;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:3rem;height:3rem;color:#9ca3af;margin:0 auto 16px;display:block;"><circle cx="12" cy="8" r="4"></circle><path d="M4 20c1.5-3.5 4.2-5 8-5s6.5 1.5 8 5"></path></svg>
                            <h3 style="color:#6b7280;">Select a counselor first</h3>
                            <p style="color:#9ca3af;font-size:0.85rem;">Click on any counselor card to book a session</p>
                        </div>
                        <div id="bookingForm" style="display:none;">
                            <form id="appointmentForm" method="post" action="${pageContext.request.contextPath}/user/book-appointment">
                                <input type="hidden" name="counselorId" id="counselorId">
                                <div class="selected-counselor-preview">
                                    <div class="preview-photo" id="previewPhoto">👤</div>
                                    <div>
                                        <div id="previewName" style="font-weight:700;color:#1a2e2e;"></div>
                                        <div id="previewSpecialty" style="font-size:0.75rem;color:#6b7280;"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="apptDate"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"><rect x="3" y="5" width="18" height="16" rx="2"></rect><path d="M8 3v4M16 3v4M3 10h18"></path></svg> Date</label>
                                    <input type="date" name="apptDate" id="apptDate" required>
                                </div>
                                <div class="form-group">
                                    <label><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"><circle cx="12" cy="12" r="9"></circle><path d="M12 7v5l3 2"></path></svg> Time Slot</label>
                                    <div class="time-slots" id="timeSlots">
                                        <button type="button" class="time-slot" data-time="09:00">9:00 AM</button>
                                        <button type="button" class="time-slot" data-time="10:00">10:00 AM</button>
                                        <button type="button" class="time-slot" data-time="11:00">11:00 AM</button>
                                        <button type="button" class="time-slot" data-time="14:00">2:00 PM</button>
                                        <button type="button" class="time-slot" data-time="15:00">3:00 PM</button>
                                        <button type="button" class="time-slot" data-time="16:00">4:00 PM</button>
                                    </div>
                                    <input type="hidden" name="apptTime" id="selectedTime" required>
                                </div>
                                <div class="form-group">
                                    <label for="notes"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:14px;height:14px;vertical-align:-2px;margin-right:4px;"><path d="M12 20h9"></path><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L7 19l-4 1 1-4z"></path></svg> Notes (optional)</label>
                                    <textarea id="notes" name="notes" rows="3" maxlength="300" placeholder="Anything you'd like to share before the session..."></textarea>
                                    <div style="text-align:right;font-size:0.7rem;color:#9ca3af;margin-top:4px;"><span id="charCount">0</span>/300</div>
                                </div>
                                <button type="submit" class="submit-btn" id="submitBtn" disabled>Select date and time</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
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

    let selectedCounselorId = null;
    let selectedTimeSlot = null;
    const dateInput = document.getElementById('apptDate');
    if (dateInput) dateInput.min = new Date().toISOString().split('T')[0];

    document.querySelectorAll('.counselor-card').forEach(card => {
        card.addEventListener('click', function() {
            document.querySelectorAll('.counselor-card').forEach(c => {
                c.classList.remove('selected');
                const badge = c.querySelector('.selected-badge');
                if (badge) badge.remove();
            });
            this.classList.add('selected');
            const badge = document.createElement('div');
            badge.className = 'selected-badge';
            badge.textContent = '✓';
            this.appendChild(badge);
            selectedCounselorId = this.dataset.id;
            document.getElementById('counselorId').value = selectedCounselorId;
            document.getElementById('previewName').textContent = this.dataset.name || '';
            document.getElementById('previewSpecialty').textContent = this.dataset.specialty || 'Mental Health Counselor';
            document.getElementById('noSelectionMsg').style.display = 'none';
            document.getElementById('bookingForm').style.display = 'block';
            validateForm();
        });
    });

    document.querySelectorAll('.time-slot').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.time-slot').forEach(b => b.classList.remove('selected'));
            this.classList.add('selected');
            selectedTimeSlot = this.dataset.time;
            document.getElementById('selectedTime').value = selectedTimeSlot;
            validateForm();
        });
    });

    if (dateInput) dateInput.addEventListener('change', validateForm);

    const noteTextarea = document.getElementById('notes');
    if (noteTextarea) {
        noteTextarea.addEventListener('input', function() {
            const count = document.getElementById('charCount');
            if (count) count.textContent = this.value.length;
        });
    }

    function validateForm() {
        const submitBtn = document.getElementById('submitBtn');
        const hasDate = dateInput && dateInput.value;
        if (submitBtn && selectedCounselorId && selectedTimeSlot && hasDate) {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Request Appointment';
        } else if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.textContent = 'Select date and time';
        }
    }

    const appointmentForm = document.getElementById('appointmentForm');
    if (appointmentForm) {
        appointmentForm.addEventListener('submit', function(e) {
            if (!selectedCounselorId || !selectedTimeSlot || !dateInput || !dateInput.value) e.preventDefault();
        });
    }
</script>
</body>
</html>
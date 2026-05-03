<%-- This is a register.jsp --%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/images/logo.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/images/logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>MindEase - Register</title>
    <script src="${pageContext.request.contextPath}/js/validation.js" defer></script>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; }
        body { font-family: "Segoe UI", Arial, sans-serif; background: #f8fffe; color: #1f2937; overflow: hidden; }
        .auth-page { min-height: 100vh; min-height: 100dvh; height: 100vh; height: 100dvh; display: flex; overflow: hidden; }

        .left-panel {
            width: 45%;
            background: linear-gradient(135deg, #1a2e2e 0%, #2b7a78 55%, #3aafa9 100%);
            position: relative;
            overflow: hidden;
            padding: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .left-panel .blob {
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            filter: blur(70px);
            pointer-events: none;
        }

        .blob-lavender { top: -80px; right: -70px; background: rgba(167, 139, 250, 0.2); }
        .blob-pink { bottom: -100px; left: -80px; background: rgba(249, 168, 212, 0.2); }

        .brand {
            position: absolute;
            top: 32px;
            left: 32px;
            color: #ffffff;
            font-size: 1.35rem;
            font-weight: 700;
        }

        .left-content { max-width: 430px; width: 100%; position: relative; z-index: 2; }
        .left-title { color: #ffffff; font-size: 1.5rem; font-weight: 700; line-height: 1.35; }
        .left-title .mint { color: #a7f3d0; }
        .left-subtitle { color: rgba(255, 255, 255, 0.7); font-size: 0.92rem; margin-top: 10px; }

        .benefit-list { margin-top: 20px; display: flex; flex-direction: column; gap: 12px; }
        .benefit-item { display: flex; align-items: center; gap: 12px; color: rgba(255, 255, 255, 0.85); }
        .benefit-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            background: rgba(255,255,255,0.15);
            border-radius: 8px;
            flex-shrink: 0;
            color: #a7f3d0;
        }

        .testimonial {
            margin-top: 24px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 14px;
            padding: 20px;
        }

        .testimonial-head { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
        .avatar { width: 44px; height: 44px; border-radius: 50%; object-fit: cover; }
        .stars { color: #facc15; letter-spacing: 1px; }
        .testimonial-quote { color: rgba(255, 255, 255, 0.8); font-style: italic; font-size: 0.9rem; margin: 8px 0; }
        .testimonial-name { color: #a7f3d0; font-size: 0.85rem; font-weight: 600; }

        .dot-row { margin-top: 12px; display: flex; gap: 8px; align-items: center; }
        .dot {
            height: 8px;
            border-radius: 999px;
            border: none;
            background: rgba(255, 255, 255, 0.3);
            width: 8px;
            cursor: pointer;
        }

        .dot.active { background: #a7f3d0; width: 20px; }

        .free-card {
            margin-top: 16px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 14px 18px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .free-icon { color: #a7f3d0; font-size: 1.1rem; }
        .free-title { color: #ffffff; font-size: 0.86rem; font-weight: 700; }
        .free-subtitle { color: rgba(255, 255, 255, 0.6); font-size: 0.78rem; }

        .right-panel {
            width: 55%;
            position: relative;
            overflow: hidden;
            background: #f8fffe;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .right-panel .blob { position: absolute; width: 300px; height: 300px; border-radius: 50%; filter: blur(70px); pointer-events: none; }
        .blob-mint { top: -90px; right: -90px; background: rgba(209, 250, 229, 0.75); }
        .blob-soft-lavender { bottom: -90px; left: -90px; background: rgba(237, 233, 254, 0.75); }

        .form-shell { max-width: 480px; width: 100%; padding: 48px 40px; position: relative; z-index: 2; }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #e6f4f3;
            color: #2b7a78;
            border-radius: 999px;
            padding: 6px 14px;
            font-size: 0.78rem;
            font-weight: 600;
            margin-bottom: 20px;
        }

        h1 { color: #1a2e2e; font-size: 2rem; font-weight: 700; line-height: 1.2; margin-bottom: 8px; }
        h1 .accent { color: #2b7a78; }
        .subtitle { color: #6b7280; font-size: 0.95rem; margin-bottom: 22px; }

        .alert {
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 16px;
            font-size: 0.88rem;
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #b91c1c;
        }

        .field { position: relative; margin-bottom: 18px; }
        .field label { display: flex; align-items: center; justify-content: space-between; font-size: 0.85rem; font-weight: 500; color: #374151; margin-bottom: 6px; }
        .field input {
            width: 100%;
              padding: 11px 14px;
            border: 1.5px solid #e5e7eb;
            border-radius: 10px;
            background: #ffffff;
            font-size: 0.95rem;
            color: #1f2937;
            outline: none;
            transition: all 0.25s;
        }

        .field input:focus { border-color: #2b7a78; background: #f0fbfa; }
        .field input:focus + .input-icon { color: #0d9488; }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 1rem;
            pointer-events: none;
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 1rem;
            cursor: pointer;
            user-select: none;
              line-height: 0;
              display: flex;
              align-items: center;
        }

            input[type="password"]::-ms-reveal,
            input[type="password"]::-ms-clear {
              display: none !important;
              visibility: hidden;
              pointer-events: none;
            }

        .input-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

        .strength-wrap { margin-top: 6px; }
        .strength-row { display: flex; gap: 4px; }
        .strength-bar { height: 4px; border-radius: 999px; flex: 1; background: #e5e7eb; }
        .strength-label { margin-top: 5px; font-size: 0.78rem; font-weight: 600; min-height: 16px; }

        .match-indicator { font-size: 0.78rem; font-weight: 600; min-height: 16px; }

        #passError { margin-bottom: 12px; }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #2b7a78, #3aafa9);
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(43, 122, 120, 0.35);
            transition: all 0.3s;
        }

        .submit-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(43, 122, 120, 0.4); }
        .terms { text-align: center; color: #6b7280; font-size: 0.8rem; margin-top: 12px; line-height: 1.45; }
        .terms a, .bottom-link a { color: #2b7a78; font-weight: 600; text-decoration: none; }
        .bottom-link { margin-top: 18px; text-align: center; color: #6b7280; font-size: 0.92rem; }

        @media (max-width: 768px) {
            body { overflow-y: auto; }
            .left-panel { display: none; }
            .right-panel { width: 100%; padding: 12px; }
            .form-shell { padding: 36px 18px; }
            .input-grid { grid-template-columns: 1fr; gap: 0; }
        }

        @media (max-width: 480px) {
            h1 { font-size: 1.6rem; }
            .input-grid { grid-template-columns: 1fr; gap: 0; }
            .social-row { flex-direction: column; }
        }
    </style>
</head>
<body>
<div class="auth-page">
    <aside class="left-panel">
        <div class="blob blob-lavender"></div>
        <div class="blob blob-pink"></div>
        <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;gap:8px;text-decoration:none;position:absolute;top:28px;left:28px;">
            <div style="width:38px;height:38px;background:rgba(255,255,255,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="MindEase" style="width:26px;height:26px;object-fit:contain;">
            </div>
            <span style="font-weight:700;font-size:1.1rem;color:#ffffff;">MindEase</span>
        </a>
      <a href="${pageContext.request.contextPath}/" style="position:absolute;top:32px;right:28px;display:inline-flex;align-items:center;gap:5px;color:rgba(255,255,255,0.70);font-size:0.82rem;text-decoration:none;background:rgba(255,255,255,0.12);border:1px solid rgba(255,255,255,0.20);border-radius:999px;padding:5px 12px;transition:all 0.2s;" onmouseover="this.style.background='rgba(255,255,255,0.20)';this.style.color='#ffffff'" onmouseout="this.style.background='rgba(255,255,255,0.12)';this.style.color='rgba(255,255,255,0.70)'">
        Home
      </a>

        <div class="left-content">
            <h2 class="left-title">Join thousands on their path to <span class="mint">mental wellness</span></h2>
            <p class="left-subtitle">Free forever. No credit card required. Your data is always private.</p>

            <div class="benefit-list">
                <div class="benefit-item">
                    <span class="benefit-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
                        </svg>
                    </span>
                    <span>Daily mood tracking with beautiful charts</span>
                </div>
                <div class="benefit-item">
                    <span class="benefit-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
                        </svg>
                    </span>
                    <span>Curated mental health resources &amp; guides</span>
                </div>
                <div class="benefit-item">
                    <span class="benefit-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                        </svg>
                    </span>
                    <span>Book sessions with certified counselors</span>
                </div>
                <div class="benefit-item">
                    <span class="benefit-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                        </svg>
                    </span>
                    <span>100% private, secure, and HIPAA-aware</span>
                </div>
            </div>

            <div class="testimonial" id="testimonialCard">
                <div class="testimonial-head">
                    <img id="testimonialAvatar" class="avatar" src="https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200" alt="User avatar">
                    <div class="stars">★★★★★</div>
                </div>
                <p id="testimonialQuote" class="testimonial-quote">"MindEase helped me build a gentle daily reflection routine that actually sticks."</p>
                <div id="testimonialName" class="testimonial-name">Neha B.</div>
                <div class="dot-row">
                    <button type="button" class="dot active" data-index="0" aria-label="Show testimonial 1"></button>
                    <button type="button" class="dot" data-index="1" aria-label="Show testimonial 2"></button>
                </div>
            </div>
        </div>
    </aside>

    <main class="right-panel">
        <div class="blob blob-mint"></div>
        <div class="blob blob-soft-lavender"></div>

        <div class="form-shell">
            <div class="badge">GET STARTED FREE</div>
            <h1>Begin your<br><span class="accent">wellness journey </span></h1>
            <p class="subtitle">Create your free account in under a minute.</p>

            <c:if test="${not empty error}">
                <div class="alert">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                <div class="input-grid">
                    <div class="field">
                        <label for="name">Full Name</label>
                        <input id="name" type="text" name="name" required placeholder="Enter your full name">
                    </div>

                    <div class="field">
                        <label for="phone">Phone</label>
                        <input id="phone" type="text" name="phone" placeholder="Enter your phone number">
                    </div>
                </div>

                <div class="field">
                    <label for="email">Email</label>
                    <input id="email" type="email" name="email" required placeholder="Enter your email">
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <div style="position:relative;">
                        <input type="password" name="password" id="password" autocomplete="new-password" required placeholder="Min 6 characters" style="width:100%;padding:11px 40px 11px 14px;">
                        <button type="button" class="eye-toggle" onclick="togglePassword(this)" style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#9ca3af;padding:0;display:none;align-items:center;justify-content:center;width:20px;height:20px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                    <div class="strength-wrap">
                        <div class="strength-row" id="strengthBars">
                            <span class="strength-bar"></span>
                            <span class="strength-bar"></span>
                            <span class="strength-bar"></span>
                            <span class="strength-bar"></span>
                        </div>
                        <div id="strengthLabel" class="strength-label"></div>
                    </div>
                </div>

                <div class="field">
                    <label for="confirmPassword">Confirm Password <span id="matchIndicator" class="match-indicator"></span></label>
                    <div style="position:relative;">
                        <input type="password" name="confirmPassword" id="confirmPassword" autocomplete="new-password" required placeholder="Repeat password" style="width:100%;padding:11px 40px 11px 14px;">
                        <button type="button" class="eye-toggle" onclick="togglePassword(this)" style="position:absolute;right:12px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:#9ca3af;padding:0;display:none;align-items:center;justify-content:center;width:20px;height:20px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="passError" class="alert" style="display:none;">Passwords do not match.</div>
                <button type="submit" class="submit-btn">Create Free Account </button>
            </form>

            <p class="terms">By registering, you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></p>
            <p class="bottom-link">Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a></p>
        </div>
    </main>
</div>

<script>
    (function () {
        var testimonials = [
            {
                avatar: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200",
                quote: "\"MindEase helped me build a gentle daily reflection routine that actually sticks.\"",
                name: "Sarah K."
            },
            {
                avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
                quote: "\"I started tracking my mood for a week and quickly understood my stress triggers.\"",
                name: "James M."
            }
        ];

        var testimonialAvatar = document.getElementById("testimonialAvatar");
        var testimonialQuote = document.getElementById("testimonialQuote");
        var testimonialName = document.getElementById("testimonialName");
        var dots = document.querySelectorAll(".dot");
        var currentIndex = 0;
        var intervalId;

        function renderTestimonial(index) {
            currentIndex = index;
            testimonialAvatar.src = testimonials[index].avatar;
            testimonialQuote.textContent = testimonials[index].quote;
            testimonialName.textContent = testimonials[index].name;
            for (var i = 0; i < dots.length; i++) {
                dots[i].classList.toggle("active", i === index);
            }
        }

        function startRotation() {
            intervalId = setInterval(function () {
                var next = (currentIndex + 1) % testimonials.length;
                renderTestimonial(next);
            }, 4000);
        }

        for (var d = 0; d < dots.length; d++) {
            dots[d].addEventListener("click", function () {
                var idx = Number(this.getAttribute("data-index"));
                renderTestimonial(idx);
                clearInterval(intervalId);
                startRotation();
            });
        }

        renderTestimonial(0);
        startRotation();

        document.querySelectorAll('input[type="password"], input[type="text"]').forEach(function(input) {
          const btn = input.parentElement.querySelector('.eye-toggle');
          if (!btn) return;
          btn.style.display = 'none';
          input.addEventListener('input', function() {
            btn.style.display = this.value.length > 0 ? 'flex' : 'none';
          });
        });

        window.togglePassword = function togglePassword(btn) {
          const input = btn.parentElement.querySelector('input');
          if (!input) return;
          if (input.type === 'password') {
            input.type = 'text';
            btn.style.color = '#2b7a78';
          } else {
            input.type = 'password';
            btn.style.color = '#9ca3af';
          }
        }

        var password = document.getElementById("password");
        var confirmPassword = document.getElementById("confirmPassword");
        var strengthBars = document.querySelectorAll("#strengthBars .strength-bar");
        var strengthLabel = document.getElementById("strengthLabel");
        var matchIndicator = document.getElementById("matchIndicator");

        function updateStrength() {
            var value = password.value;
            var score = 0;
            if (value.length >= 8) score++;
            if (/[A-Z]/.test(value)) score++;
            if (/\d/.test(value)) score++;
            if (/[^A-Za-z0-9]/.test(value)) score++;

            var color = "#e5e7eb";
            var label = "";
            if (score === 1) {
                color = "#ef4444";
                label = "Weak";
            } else if (score === 2) {
                color = "#f59e0b";
                label = "Fair";
            } else if (score === 3) {
                color = "#10b981";
                label = "Good";
            } else if (score === 4) {
                color = "#059669";
                label = "Strong";
            }

            for (var i = 0; i < strengthBars.length; i++) {
                strengthBars[i].style.background = i < score ? color : "#e5e7eb";
            }
            strengthLabel.textContent = label;
            strengthLabel.style.color = color;
        }

        function updateMatch() {
            var confirmValue = confirmPassword.value;
            if (!confirmValue) {
                matchIndicator.textContent = "";
                return;
            }
            if (confirmValue === password.value) {
                matchIndicator.textContent = "✓";
                matchIndicator.style.color = "#10b981";
            } else {
                matchIndicator.textContent = "✗";
                matchIndicator.style.color = "#f87171";
            }
        }

        password.addEventListener("input", function () {
            updateStrength();
            updateMatch();
        });
        confirmPassword.addEventListener("input", updateMatch);
        updateStrength();
    })();
</script>
</body>
</html>


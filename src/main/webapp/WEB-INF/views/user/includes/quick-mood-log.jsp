<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section class="mood-widget" id="quick-mood-log">
    <h4>Quick Mood Log</h4>
    <p class="mood-sub">How are you feeling right now?</p>

    <form id="moodLogForm" method="post" action="${pageContext.request.contextPath}/user/log-mood">
        <input type="hidden" name="returnUrl" value="/user/dashboard">
        <div class="mood-emojis">
            <button type="button" class="mood-option" data-score="1">😞<span class="mood-opt-label">1</span></button>
            <button type="button" class="mood-option" data-score="2">😕<span class="mood-opt-label">2</span></button>
            <button type="button" class="mood-option" data-score="3">😐<span class="mood-opt-label">3</span></button>
            <button type="button" class="mood-option" data-score="4">🙂<span class="mood-opt-label">4</span></button>
            <button type="button" class="mood-option" data-score="5">😊<span class="mood-opt-label">5</span></button>
        </div>

        <input type="hidden" id="moodScore" name="score">
        <label for="moodNote" style="position:absolute;left:-9999px;">Quick note</label>
        <textarea id="moodNote" name="note" class="mood-note" rows="3" maxlength="500"
                  placeholder="Write a quick note (optional)..."></textarea>
        <div style="text-align:right;font-size:0.72rem;color:rgba(255,255,255,0.6);margin-top:4px;">
            <span id="moodNoteCount">0</span>/500
        </div>
        <button id="moodSubmit" class="mood-submit" type="submit" disabled>Save Mood</button>
    </form>
</section>
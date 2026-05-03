document.addEventListener("DOMContentLoaded", function () {
    var form = document.getElementById("registerForm");
    if (form) {
        form.addEventListener("submit", function (e) {
            var password = document.getElementById("password").value;
            var confirm = document.getElementById("confirmPassword").value;
            var errorDiv = document.getElementById("passError");
            if (password !== confirm) {
                e.preventDefault();
                errorDiv.style.display = "block";
            } else {
                errorDiv.style.display = "none";
            }
        });
    }
});


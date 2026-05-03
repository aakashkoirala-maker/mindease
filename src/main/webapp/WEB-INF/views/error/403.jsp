<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>403 - Access Denied</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0f4f4;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #1f2937;
            padding: 20px;
        }
        .error-card {
            width: 100%;
            max-width: 520px;
            background: #ffffff;
            border-radius: 16px;
            padding: 36px 28px;
            box-shadow: 0 8px 24px rgba(43, 122, 120, 0.12);
            text-align: center;
        }
        .code {
            font-size: 3.2rem;
            line-height: 1;
            font-weight: 800;
            color: #2b7a78;
            margin-bottom: 10px;
        }
        h1 {
            font-size: 1.25rem;
            margin-bottom: 10px;
        }
        p {
            color: #6b7280;
            margin-bottom: 22px;
        }
        .home-link {
            display: inline-block;
            background: linear-gradient(135deg, #2b7a78, #3aafa9);
            color: #ffffff;
            text-decoration: none;
            border-radius: 999px;
            padding: 10px 22px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="error-card">
    <div class="code">403</div>
    <h1>Access Denied</h1>
    <p>You do not have permission to view this page.</p>
    <a class="home-link" href="${pageContext.request.contextPath}/">Go Home</a>
</div>
</body>
</html>


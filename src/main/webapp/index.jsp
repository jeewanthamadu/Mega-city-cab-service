<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(126deg, #ffffff, #8e8fd0);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333; /* Dark gray text */
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.8); /* Light white with transparency */
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            color: #4a5568; /* Darker gray */
            margin: 0;
            font-weight: 600;
        }

        .login-header h2 {
            color: #718096; /* Medium gray */
            margin: 5px 0 0;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #718096;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 15px;
            background-color: #f9f9f9; /* Very light gray */
            color: #333;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .login-button {
            background: linear-gradient(135deg, #4299e1, #3182ce); /* Light blue gradient */
            color: white;
            padding: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .login-button:hover {
            background: linear-gradient(135deg, #3182ce, #4299e1);
        }

        .error-message {
            color: #e53e3e; /* Red error */
            text-align: center;
            margin-top: 15px;
        }

        .form-group i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
        }

        .notification-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }

        .notification {
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px 20px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .notification.show {
            opacity: 1;
        }

        .notification.success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .notification.error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .notification .icon {
            margin-right: 10px;
            font-size: 18px;
        }

        .notification .close-btn {
            margin-left: auto;
            cursor: pointer;
            font-weight: bold;
            color: #888;
        }

        .notification .close-btn:hover {
            color: #333;
        }
    </style>
    <script>
        function showNotification(message, type = 'success') {
            console.log("showNotification called with message:", message, "and type:", type); // Debug log

            const container = document.querySelector('.notification-container') || createNotificationContainer();
            const notification = document.createElement('div');
            notification.classList.add('notification', 'show', type);

            // Choose icon based on type
            const iconContent = (type === 'error' ? '❌' : '✅');

            // Notification Content
            notification.innerHTML = `
        <span class="icon">${iconContent}</span>
        <span class="message"></span>
        <span class="close-btn" onclick="this.parentElement.remove()">×</span>
    `;

            notification.querySelector('.message').textContent = message;

            // Append to container
            container.appendChild(notification);

            // Auto-remove after 3 seconds
            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => notification.remove(), 500); // Remove from DOM after animation
            }, 3000);
        }

        // Helper to create notification container if not present
        function createNotificationContainer() {
            const container = document.createElement('div');
            container.classList.add('notification-container');
            document.body.appendChild(container);
            return container;
        }
       /* window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');

            if (success) {
                showNotification(decodeURIComponent(success), 'success');
            } else if (error) {
                showNotification(decodeURIComponent(error), 'error');
            }
        };*/
    </script>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h1>Mega City Cab Admin Login</h1>
    </div>

    <form action="login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>

        <button type="submit" class="login-button">Login</button>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            <%= request.getParameter("error") %>
        </div>
        <% } %>
    </form>
</div>

<script>
    window.onload = function () {
        // Retrieve messages from session
        const successMessageSession = "<%= session.getAttribute("successMessage") %>";
        const errorMessageSession = "<%= session.getAttribute("errorMessage") %>";

        // Retrieve messages from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const successUrl = urlParams.get('success');
        const errorUrl = urlParams.get('error');

        // Display session messages
        if (successMessageSession && successMessageSession !== "null") {
            showNotification(successMessageSession, 'success');
            <% session.removeAttribute("successMessage"); %>
        } else if (errorMessageSession && errorMessageSession !== "null") {
            showNotification(errorMessageSession, 'error');
            <% session.removeAttribute("errorMessage"); %>
        }

        // Display URL parameter messages
        if (successUrl) {
            showNotification(decodeURIComponent(successUrl), 'success');
        } else if (errorUrl) {
            showNotification(decodeURIComponent(errorUrl), 'error');
        }
    };
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login Page</title>

  <style>

    /* Icon Style */
    .notification .icon {
      margin-right: 10px;
      font-size: 18px;
    }

    /* Close Button */
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
      console.log("Message received:", message); // Debug log

      const container = document.querySelector('.notification-container') || createNotificationContainer();
      const notification = document.createElement('div');
      notification.classList.add('notification', 'show', type);

      // Choose icon based on type
     // const icon = type === 'error' ? '❌' : '✅';
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

    // On page load, check URL params for messages
    window.onload = function() {
      const urlParams = new URLSearchParams(window.location.search);
      const success = urlParams.get('success');
      const error = urlParams.get('error');

      if (success) {
        showNotification(decodeURIComponent(success), 'success'); // Decode and show success
      } else if (error) {
        showNotification(decodeURIComponent(error), 'error'); // Decode and show error
      }
    };
  </script>

  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-container {
      background-color: white;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 400px;
    }

    .login-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .login-header h2 {
      color: #333;
      margin: 0;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      color: #555;
    }

    .form-group input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 14px;
    }

    .login-button {
      background-color: #4CAF50;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
    }

    .login-button:hover {
      background-color: #45a049;
    }

    .error-message {
      color: #ff0000;
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-header">
    <h1>Mega City Cab Admin Module</h1>
    <h2>Login</h2>
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
</body>
</html>

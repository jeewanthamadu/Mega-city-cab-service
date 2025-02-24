<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Driver</title>

    <style>
        /* Notification container */
        .notification-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }

        /* Notification style */
        .notification {
            background-color: white; /* White background */
            color: black; /* Default text color */
            padding: 12px 20px;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            min-width: 250px;
            font-family: Arial, sans-serif;
            font-size: 14px;
            border-left: 5px solid #4CAF50; /* Default green border for success */
            opacity: 0;
            transform: translateX(100%);
            transition: transform 0.5s ease, opacity 0.5s ease;
            display: flex;
            align-items: center;
        }

        /* Show notification */
        .notification.show {
            opacity: 1;
            transform: translateX(0);
        }

        /* Success Notification */
        .notification.success {
            border-left-color: #4CAF50; /* Green border */
        }

        /* Error Notification */
        .notification.error {
            border-left-color: #f44336; /* Red border */
        }

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

        /* Body Style */
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
            position: relative;
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

        /* Loading Spinner */
        .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top: 4px solid #4CAF50;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        /* Blur effect for background */
        .blur {
            filter: blur(5px);
            pointer-events: none;
        }

        /* Animation for spinner */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    <script>
        function showNotification(message, type = 'success') {
            console.log("Message received:", message); // Debug log

            const container = document.querySelector('.notification-container') || createNotificationContainer();
            const notification = document.createElement('div');
            notification.classList.add('notification', 'show', type);

            const iconContent = (type === 'error' ? '❌' : '✅');

            notification.innerHTML = `
        <span class="icon">${iconContent}</span>
        <span class="message"></span>
        <span class="close-btn" onclick="this.parentElement.remove()">×</span>
      `;

            notification.querySelector('.message').textContent = message;

            container.appendChild(notification);

            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => notification.remove(), 500);
            }, 3000);
        }

        function createNotificationContainer() {
            const container = document.createElement('div');
            container.classList.add('notification-container');
            document.body.appendChild(container);
            return container;
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');

            if (success) {
                showNotification(decodeURIComponent(success), 'success');
            } else if (error) {
                showNotification(decodeURIComponent(error), 'error');
            }
        };

        // Adding loader and blur effect when the form is submitted
        document.querySelector('form').onsubmit = function(event) {
            event.preventDefault(); // Prevent default form submission

            const form = event.target;
            const loginButton = form.querySelector('.login-button');
            const loader = document.createElement('div');
            loader.classList.add('loader');
            form.appendChild(loader);

            // Blur the background
            document.body.classList.add('blur');

            // Simulate a delay (you can remove this in production)
            setTimeout(function() {
                // Remove loader and blur after submission
                loader.remove();
                document.body.classList.remove('blur');

                // Simulate form submission (you can submit the form here or use AJAX)
                form.submit(); // Uncomment to actually submit form
            }, 3000); // Replace 3000 with actual server response time if using AJAX
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

        .form-container {
            background-color: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            height: auto;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 2px solid #4CAF50;
        }

        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 35px rgba(0, 0, 0, 0.15);
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            color: #4CAF50;
            margin: 0;
            font-size: 32px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            /*border-bottom: 3px solid #4CAF50;*/
            display: inline-block;
            padding-bottom: 5px;
        }

        .form-header h2 {
            color: #555;
            margin: 10px 0 0;
            font-size: 22px;
            font-weight: 500;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
            z-index: 1;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s ease;
            background: none;
            position: relative;
            z-index: 2;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .form-group label {
            position: absolute;
            top: 12px;
            left: 12px;
            background-color: white;
            padding: 0 4px;
            color: #777;
            font-size: 14px;
            transition: all 0.3s ease;
            pointer-events: none;
            z-index: 3;
        }

        .form-group input:focus + label,
        .form-group input:not(:placeholder-shown) + label,
        .form-group select:focus + label,
        .form-group select:valid + label {
            top: -10px;
            left: 10px;
            font-size: 12px;
            color: #4CAF50;
        }

        .form-group select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' width='24' height='24'%3E%3Cpath fill='%23666' d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
        }

        .form-group select:invalid {
            color: #777;
        }

        .form-group .radio-group {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            position: relative;
            z-index: 1;
        }

        .form-group input[type="radio"] {
            width: auto;
            margin-right: 5px;
        }

        .form-group label.inline {
            display: flex;
            align-items: center;
            margin-right: 15px;
        }

        .submit-button {
            background-color: #4CAF50;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: not-allowed;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            transition: background-color 0.3s ease, transform 0.2s ease;
            opacity: 0.6;
            position: relative;
            z-index: 0;
        }

        .submit-button.enabled {
            cursor: pointer;
            opacity: 1;
        }

        .submit-button.enabled:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        .error-message {
            color: #ff0000;
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 20px;
            }

            .form-header h1 {
                font-size: 24px;
            }

            .form-header h2 {
                font-size: 18px;
            }

            .form-group .radio-group {
                flex-direction: column;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('form');
            const inputs = form.querySelectorAll('input[required], select[required]');
            const submitButton = form.querySelector('.submit-button');

            function checkFormValidity() {
                let allFilled = true;
                inputs.forEach(input => {
                    if ((input.type === 'radio' && !form.querySelector(`input[name="${input.name}"]:checked`)) || (!input.value && input.type !== 'radio')) {
                        allFilled = false;
                    }
                });
                if (allFilled) {
                    submitButton.classList.add('enabled');
                    submitButton.disabled = false;
                } else {
                    submitButton.classList.remove('enabled');
                    submitButton.disabled = true;
                }
            }

            inputs.forEach(input => {
                input.addEventListener('input', checkFormValidity);
                if (input.type === 'radio' || input.tagName.toLowerCase() === 'select') {
                    input.addEventListener('change', checkFormValidity);
                }
            });

            checkFormValidity();
        });
    </script>
</head>
<body>
<div class="form-container">
    <div class="form-header">
        <h1>Driver Registration</h1>
    </div>

    <form action="addDriver" method="post">
        <div class="form-group">
            <input type="text" id="driverName" name="driverName" placeholder=" " required>
            <label for="driverName">Driver Name</label>
        </div>

        <div class="form-group">
            <input type="number" id="age" name="age" placeholder=" " required>
            <label for="age">Age</label>
        </div>

        <div class="form-group">
            <input type="email" id="email" name="email" placeholder=" " required>
            <label for="email">Email</label>
        </div>

        <div class="form-group">
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder=" " required>
            <label for="phoneNumber">Phone Number</label>
        </div>

        <div class="form-group">
            <input type="text" id="nic" name="nic" placeholder=" " required>
            <label for="nic">NIC</label>
        </div>

        <div class="form-group">
            <input type="text" id="licenseNumber" name="licenseNumber" placeholder=" " required>
            <label for="licenseNumber">License Number</label>
        </div>

    <%--    <div class="form-group">
            <label>Vehicle Type</label>
            <div class="radio-group">
                <label class="inline"><input type="radio" id="lightVehicle" name="vehicleType" value="Light" required> Light Vehicle</label>
                <label class="inline"><input type="radio" id="heavyVehicle" name="vehicleType" value="Heavy" required> Heavy Vehicle</label>
            </div>
        </div>--%>

        <div class="form-group">
            <select id="gearType" name="gearType" required>
                <option value="" disabled selected hidden>Select Gear Type</option>
                <option value="Manual">Manual</option>
                <option value="Auto">Auto</option>
                <option value="Both">Both</option>
            </select>
            <label for="gearType">Gear Type</label>
        </div>

        <button type="submit" class="submit-button" disabled>Add Driver</button>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            <%= request.getParameter("error") %>
        </div>
        <% } %>
    </form>
</div>
</body>
</html>

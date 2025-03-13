<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mega City</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #e3e3e3;
                margin: 0;
                padding: 20px;
                color: #333;
            }

            .dashboard-welcome {
                backdrop-filter: blur(10px);
                border-radius: 15px;
                color: #7000ff;
            }

            .dashboard-welcome h1 {
                font-size: 2.5em;
                margin-bottom: 10px;
                font-weight: 600;
                text-shadow:
                        1px 1px 2px rgba(0, 0, 0, 0.2),
                        2px 2px 4px rgba(0, 0, 0, 0.1),
                        3px 3px 6px rgba(0, 0, 0, 0.05);
            }
            .dashboard-welcome p {
                font-size: 1.1em;
                text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.1);
            }

            /* Enhanced Manage Button */
            .manage-widget {
                position: absolute;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #6a11cb, #2575fc); /* Gradient with purple and blue */
                padding: 15px 25px;
                border-radius: 25px; /* More rounded */
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.25);
                cursor: pointer;
                color: white;
                font-weight: 600;
                font-size: 1.1em;
                display: flex;
                align-items: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .manage-widget:hover {
                transform: translateY(-8px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            }

            .manage-widget i {
                margin-right: 10px;
                animation: spin 2s linear infinite; /* Icon spin */
            }

            @keyframes spin {
                100% {
                    transform: rotate(360deg);
                }
            }

            /* Enhanced Manage Options */
            .manage-options {
                display: none;
                position: absolute;
                top: 70px;
                right: 20px;
                background: linear-gradient(166deg, #b9b19d, #e3d8d8);
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
                padding: 20px;
                z-index: 1001;
                width: 220px;
                animation: fadeIn 0.3s ease-in-out; /* Fade-in animation */
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .manage-options a {
                display: block;
                padding: 12px 18px;
                margin-bottom: 8px;
                text-decoration: none;
                color: #333;
                border-radius: 20px; /* Rounded links */
                background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .manage-options a:last-child {
                margin-bottom: 0;
            }

            .manage-options a:hover {
                transform: scale(1.05); /* Slight scale on hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            /* Dashboard Widgets */
            h2 {
                color: #4a5568;
                margin-bottom: 30px;
                text-align: center;
                font-size: 2.5em;
                font-weight: 600;
            }

            .dashboard-widgets {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 25px;
                margin-top: 30px;
            }

            .widget {
                background: linear-gradient(135deg, #ffffff, #e6e6e6);
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                cursor: default;
            }

            .widget:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
            }

            .widget i {
                font-size: 3em;
                margin-bottom: 20px;
                color: #4299e1;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            }

            .widget h3 {
                font-size: 2.2em;
                margin-bottom: 10px;
                color: #2d3748;
                font-weight: 600;
            }

            .widget p {
                font-size: 1.1em;
                color: #718096;
                margin: 0;
            }

            /* Widget Specific Colors */
            .widget-vehicles i { color: #48bb78; }
            .widget-drivers i { color: #3182ce; }
            .widget-customers i { color: #e53e3e; }
            .widget-rentals i { color: #d69e2e; }
            .widget-revenue i { color: #9f7aea; }
            .widget-completed i { color: #4299e1; }
            .widget-pending i { color: #dd6b20; }

            /* Responsive Design */
            @media (max-width: 768px) {
                .dashboard-widgets {
                    grid-template-columns: 1fr;
                }
            }

            /* Button Styles */
            .dashboard-buttons {
                text-align: center;
                margin-top: 30px;
            }

            .dashboard-buttons button {
                padding: 12px 25px;
                margin: 0 10px;
                border: none;
                border-radius: 8px;
                background-color: #4299e1;
                color: white;
                font-size: 1.1em;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .dashboard-buttons button:hover {
                background-color: #3182ce;
            }

            /* Extra Styles Added as Classes */
            .manage-widget {
                position: absolute;
                top: 20px;
                right: 20px;
                background: linear-gradient(135deg, #ffffff, #e6e6e6);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                cursor: pointer;
            }

            .manage-options {
                display: none;
                position: absolute;
                top: 70px; /* Adjust as needed */
                right: 20px;
                background-color: white;
                border: 1px solid #ccc;
                border-radius: 5px;
                padding: 10px;
                z-index: 1001;
            }

            .manage-options a {
                display: block;
                padding: 8px;
                text-decoration: none;
                color: #333;
            }

            .manage-options a:hover {
                background-color: #f0f0f0;
            }

            .main-content {
                margin-top: 20px;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                display: none;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .main-content > div {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 80%;
                max-width: 600px;
            }

            .blur-background {
                filter: blur(5px);
            }

        </style>
    </head>
    <body>
    <div id="content-area">
        <div class="dashboard-welcome">
            <h1>Welcome</h1>
        </div>
        <div class="manage-widget" onclick="toggleManageOptions()" style="background: linear-gradient(135deg, #FF6B6B, #FF8E53); color: white; padding: 10px 15px; border-radius: 5px; cursor: pointer; display: inline-flex; align-items: center;">
            <i class="fas fa-cog" style="margin-right: 5px;"></i> Manage
        </div>
        <div class="manage-options">
            <a href="#" onclick="loadPage('addRental'); return false;">Add Rental</a>
            <a href="#" onclick="loadPage('addVehicle'); return false;">Manage Vehicles</a>
            <a href="#" onclick="loadPage('addCustomer'); return false;">Manage Customers</a>
            <a href="#" onclick="loadPage('addDriver'); return false;">Manage Drivers</a>
            <a href="#" onclick="loadPage('addReport'); return false;">Generate Report</a>
            <a href="#" onclick="loadPage('viewHistory'); return false;">View History</a>
        </div>
        <div class="dashboard-widgets">
            <div class="widget widget-vehicles">
                <i class="fas fa-car"></i>
                <h3>${totalVehicles}</h3>
                <p>Vehicles</p>
            </div>

            <div class="widget widget-drivers">
                <i class="fas fa-id-card"></i>
                <h3>${driverCount}</h3>
                <p>Drivers</p>
            </div>

            <div class="widget widget-customers">
                <i class="fas fa-user"></i>
                <h3>${totalCustomers}</h3>
                <p>Customers</p>
            </div>

            <div class="widget widget-rentals">
                <i class="fas fa-handshake"></i>
                <h3>${totalRentals}</h3>
                <p>Rentals</p>
            </div>

            <div class="widget widget-revenue">
                <i class="fas fa-car-side"></i>
                <h3>${availableVehicles}</h3>
                <p>Available Vehicles</p>
            </div>

            <div class="widget widget-completed">
                <i class="fas fa-check-circle"></i>
                <h3>${completedRentals}</h3>
                <p>Completed Rentals</p>
            </div>

            <div class="widget widget-pending">
                <i class="fas fa-clock"></i>
                <h3>${pendingCount}</h3>
                <p>Pending Rentals</p>
            </div>

            <div class="widget widget-income">
                <i class="fas fa-dollar-sign"></i>
                <h3>${totalIncome}</h3>
                <p>Total Income</p>
            </div>
        </div>
    </div>
    <script>
        function toggleManageOptions() {
            var options = document.querySelector('.manage-options');
            options.style.display = options.style.display === 'block' ? 'none' : 'block';
        }

        function loadPage(page) {
            fetch(page)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('content-area').innerHTML = data; // Replace content
                    document.querySelector('.manage-options').style.display = 'none';
                })
                .catch(error => console.error('Error loading page:', error));
        }

        function refreshData() {
            alert("Refreshing data..."); // Replace with your refresh logic
        }

        function viewReports() {
            alert("Viewing reports..."); // Replace with your reports logic
        }
    </script>
    </body>
    </html>

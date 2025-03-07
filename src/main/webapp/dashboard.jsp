<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
            background-color: #f4f6f9;
        }

        /* Sidebar */
        .sidebar {
            width: 240px;
            background-color: #1e3a56;
            color: #fff;
            padding: 20px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            height: 100vh;
            overflow-y: auto;
        }

        .sidebar .dashboard-header {
            font-size: 1.8em;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            font-size: 1.2em;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #295580;
        }

        /* Content Area */
        .content {
            margin-left: 260px;
            padding: 20px;
            width: calc(100% - 260px);
            overflow: auto;
        }

        /* Dashboard Widgets */
        .dashboard-widgets {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            /* Responsive grid */
            gap: 60px;
            margin-top: 30px;
            /* Ensure there's space above the widgets */
            grid-auto-rows: 200px;
            /* Consistent height for widgets */
        }

        /* Widget Styles */
        .widget {
            background-color: #28a745;
            /* Default green background */
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            font-size: 1.5em;
            color: #fff;
            font-weight: bold;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            height: 100%;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out, background-color 0.3s ease; /* Added transition */

        }

        .widget:hover {
            /*background-color: #218838;*/
            transform: translateY(-5px); /* Added lift effect */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* Enhanced shadow */
            opacity: inherit;
            /* Darker shade of green on hover */
        }


        .widget i {
            font-size: 3em;
            margin-bottom: 10px;
            flex-shrink: 0;
            /* Prevent icon from shrinking */
            padding-top: 15px; /* Add padding to the top of the icon */
        }

        /* Widget Specific Colors */
        .widget-vehicles {
            background-color: #28a745;
        }

        .widget-drivers {
            background-color: #007bff;
        }

        .widget-rentals {
            background-color: #ffc107;
        }

        .widget-completed {
            background-color: #dc3545;
        }

        .widget-pending {
            background-color: #17a2b8;
        }

        .widget-revenue {
            background-color: #6610f2;
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 1200px) {
            .dashboard-widgets {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                /* Ensure a bit more space between widgets */
            }
        }

        @media (max-width: 992px) {
            .dashboard-widgets {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                /* Make columns adjust to smaller screens */
            }

            .sidebar {
                width: 200px;
            }

            .content {
                margin-left: 220px;
                width: calc(100% - 220px);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 180px;
            }

            .content {
                margin-left: 200px;
                width: calc(100% - 200px);
            }

            .dashboard-widgets {
                grid-template-columns: 1fr;
                /* Stack widgets on small screens */
            }
        }

        @media (max-width: 576px) {
            .sidebar {
                width: 150px;
            }

            .content {
                margin-left: 170px;
                width: calc(100% - 170px);
            }

            .dashboard-widgets {
                grid-template-columns: 1fr;
                /* Ensure widgets are stacked */
            }
        }
    </style>
</head>
<body onload="loadInitialDashboard()">

<div class="sidebar">
    <div class="dashboard-header">Easy</div>
    <a href="#" class="active" onclick="loadPage('dashboard')"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    <a href="#" onclick="loadPage('manageRentals')"><i class="fas fa-car"></i> Manage Rentals</a>
    <a href="#" onclick="loadPage('manageVehicles')"><i class="fas fa-truck"></i> Manage Vehicles</a>
    <a href="#" onclick="loadPage('manageCustomers')"><i class="fas fa-users"></i> Manage Customers</a>
    <a href="#" onclick="loadPage('manageDrivers')"><i class="fas fa-user-tie"></i> Manage Drivers</a>
    <div class="sidebar-footer">
        <a href="#" onclick="loadPage('logout')"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<div class="content" id="main-content">
</div>

<script>
    // Function to load initial dashboard content
    function loadInitialDashboard() {
        fetch('dashboard-initial') // Fetch the dashboard controller
            .then(response => response.text())
            .then(data => {
                document.getElementById('main-content').innerHTML = data;
            })
            .catch(error => {
                console.error('Error fetching dashboard:', error);
            });
    }

    // Function to load content dynamically
    function loadPage(page) {
        let url = '';

        switch (page) {
            case 'dashboard':
                loadInitialDashboard(); // Load initial dashboard content
                url = 'dashboard';
                return;
            case 'manageRentals':
                url = 'addRental';
                break;
            case 'manageVehicles':
                url = 'addVehicle';
                break;
            case 'manageCustomers':
                url = 'addCustomer';
                break;
            case 'manageDrivers':
                url = 'addDriver';
                break;
            case 'logout':
                window.location.href = 'logout.jsp';
                return;
            // ... other cases
            default:
                console.warn('Unknown page:', page); // Add a default case
                return;
        }

        if (url) {
            fetch(url)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('main-content').innerHTML = data;
                    history.pushState({page: page}, page, page);
                })
                .catch(error => console.error('Error loading page:', error));
        }
    }

    // Handle back/forward buttons
    window.onpopstate = function (event) {
        if (event.state) {
            loadPage(event.state.page);
        }
    };
</script>

</body>
</html>
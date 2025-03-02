<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
            width: 220px;
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
            transition: width 0.3s ease;
        }

        .sidebar .dashboard-header {
            font-size: 1.6em;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            font-size: 1.1em;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
        }

        .sidebar a:hover {
            background-color: #295580;
        }

        .sidebar .sidebar-footer {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
        }

        /* Top Bar */
        .top-bar {
            background-color: #295580;
            color: #fff;
            padding: 15px;
            position: fixed;
            top: 0;
            left: 260px;
            width: calc(100% - 260px);
            z-index: 200;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: left 0.3s ease;
        }

        .content {
            margin-left: 260px;
            /*margin-top: 70px;*/
            padding: 20px;
            width: calc(100% - 260px);
            transition: margin-left 0.3s ease;
            overflow: auto;
        }

        /* Dashboard Widgets */
        .dashboard-widgets {
            display: flex;
            gap: 20px;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        .widget {
            background-color: #ecf0f1;
            padding: 20px;
            border-radius: 10px;
            width: 22%;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .widget i {
            font-size: 2em;
            margin-bottom: 10px;
        }

        /* Chart Section */
        .chart-container {
            display: flex;
            gap: 20px;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        .chart {
            width: 45%;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="dashboard-header">Dashboard</div>
    <a href="#" onclick="loadPage('addRental')"><i class="fas fa-car"></i> Manage Rentals</a>
    <a href="#" onclick="loadPage('addVehicle')"><i class="fas fa-truck"></i> Manage Vehicles</a>
    <a href="#" onclick="loadPage('addCustomer')"><i class="fas fa-users"></i> Manage Customers</a>
    <a href="#" onclick="loadPage('addDriver')"><i class="fas fa-users"></i> Manage Drivers</a>
    <div class="sidebar-footer">
        <a href="#" onclick="loadPage('logout.jsp')"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<div class="content" id="main-content">
    <h2>Welcome to the Dashboard</h2>
    <p>Select an option from the sidebar.</p>

    <div class="dashboard-widgets">
        <div class="widget">
            <i class="fas fa-car"></i>
            <h3>${totalVehicles}</h3>
            <p>Vehicles</p>
        </div>
        <div class="widget">
            <i class="fas fa-users"></i>
            <h3>${driverCount}</h3>
            <p>Drivers</p>
        </div>
        <div class="widget">
            <i class="fas fa-cogs"></i>
            <h3>${totalRentals}</h3>
            <p>Rentals</p>
        </div>
        <div class="widget">
            <i class="fas fa-clock"></i>
            <h3>${pendingCount}</h3>
            <p>Pending Rentals</p>
        </div>
    </div>
</div>

<script>
    function loadPage(page) {
        fetch(page)
            .then(response => response.text())
            .then(html => {
                document.getElementById('main-content').innerHTML = html;
            })
            .catch(error => console.error('Error loading page:', error));
    }
</script>

</body>
</html>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
            width: 220px;
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
            transition: width 0.3s ease;
        }

        .sidebar .dashboard-header {
            font-size: 1.6em;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            font-size: 1.1em;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
        }

        .sidebar a:hover {
            background-color: #295580;
        }

        .sidebar .sidebar-footer {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
        }

        .top-bar {
            background-color: #295580;
            color: #fff;
            padding: 15px;
            position: fixed;
            top: 0;
            left: 260px;
            width: calc(100% - 260px);
            z-index: 200;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: left 0.3s ease;
        }

        .content {
            margin-left: 260px;
            padding: 20px;
            width: calc(100% - 260px);
            transition: margin-left 0.3s ease;
            overflow: auto;
        }

        .dashboard-widgets {
            display: flex;
            gap: 20px;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        .widget {
            background-color: #ecf0f1;
            padding: 20px;
            border-radius: 10px;
            width: 22%;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .widget i {
            font-size: 2em;
            margin-bottom: 10px;
        }

        .recent-activity {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .recent-activity h3 {
            margin-bottom: 10px;
        }

        .notification {
            padding: 10px;
            margin-bottom: 10px;
            background-color: #ffeb3b;
            color: #333;
            border-radius: 5px;
        }

        /* Chart Section */
        .chart-container {
            display: flex;
            gap: 20px;
            justify-content: space-around;
            margin-bottom: 30px;
        }

        .chart {
            width: 45%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="dashboard-header">Dashboard</div>
    <a href="#" onclick="loadPage('addRental')"><i class="fas fa-car"></i> Manage Rentals</a>
    <a href="#" onclick="loadPage('addVehicle')"><i class="fas fa-truck"></i> Manage Vehicles</a>
    <a href="#" onclick="loadPage('addCustomer')"><i class="fas fa-users"></i> Manage Customers</a>
    <a href="#" onclick="loadPage('addDriver')"><i class="fas fa-users"></i> Manage Drivers</a>
    <div class="sidebar-footer">
        <a href="#" onclick="loadPage('logout.jsp')"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<div class="content" id="main-content">
    <h2>Welcome to the Dashboard</h2>
    <p>Select an option from the sidebar.</p>

    <!-- Notification Center -->
    <div class="notification">You have 3 new rental requests pending approval.</div>

    <div class="dashboard-widgets">
        <div class="widget">
            <i class="fas fa-car"></i>
            <h3>${totalVehicles}</h3>
            <p>Vehicles</p>
        </div>
        <div class="widget">
            <i class="fas fa-users"></i>
            <h3>${driverCount}</h3>
            <p>Drivers</p>
        </div>
        <div class="widget">
            <i class="fas fa-cogs"></i>
            <h3>${totalRentals}</h3>
            <p>Rentals</p>
        </div>
        <div class="widget">
            <i class="fas fa-clock"></i>
            <h3>${pendingCount}</h3>
            <p>Pending Rentals</p>
        </div>
    </div>

    <!-- Recent Activity Feed -->
    <div class="recent-activity">
        <h3>Recent Activity</h3>
        <ul>
            <li>New rental added by John Doe on March 2, 2025</li>
            <li>New vehicle added: Toyota Prius on March 1, 2025</li>
            <li>Driver Mike Smith completed rental #10245</li>
        </ul>
    </div>

    <!-- Chart Section -->
    <div class="chart-container">
        <div class="chart">
            <h3>Rental Trends</h3>
            <canvas id="rentalChart"></canvas>
        </div>
        <div class="chart">
            <h3>Vehicle Availability</h3>
            <canvas id="vehicleChart"></canvas>
        </div>
    </div>
</div>

<script>
    function loadPage(page) {
        fetch(page)
            .then(response => response.text())
            .then(html => {
                document.getElementById('main-content').innerHTML = html;
            })
            .catch(error => console.error('Error loading page:', error));
    }

    // Rental Trends Chart
    const rentalChart = document.getElementById('rentalChart').getContext('2d');
    new Chart(rentalChart, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
            datasets: [{
                label: 'Rentals',
                data: [12, 19, 15, 25, 30],
                borderColor: '#4e73df',
                fill: false,
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Vehicle Availability Chart
    const vehicleChart = document.getElementById('vehicleChart').getContext('2d');
    new Chart(vehicleChart, {
        type: 'pie',
        data: {
            labels: ['Available', 'Occupied', 'In Maintenance'],
            datasets: [{
                label: 'Vehicle Status',
                data: [40, 15, 10],
                backgroundColor: ['#28a745', '#dc3545', '#ffc107'],
                hoverOffset: 4
            }]
        }
    });
</script>

</body>
</html>

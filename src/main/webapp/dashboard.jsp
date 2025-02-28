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
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      height: 100vh;
      background-color: #f4f4f4;
    }
    .sidebar {
      width: 250px;
      background: #2c3e50;
      color: white;
      padding-top: 20px;
      display: flex;
      flex-direction: column;
      height: 100vh;
      position: fixed;
      left: 0;
      top: 0;
    }
    .sidebar a {
      padding: 15px;
      color: white;
      text-decoration: none;
      display: flex;
      align-items: center;
      font-size: 16px;
    }
    .sidebar a:hover {
      background: #34495e;
    }
    .sidebar i {
      margin-right: 10px;
    }
    .sidebar .dashboard-header {
      padding: 20px;
      font-size: 24px;
      font-weight: bold;
      color: white;
      text-align: center;
      background-color: #34495e;
    }
    .content {
      flex: 1;
      padding: 20px;
      margin-left: 250px; /* Ensure content does not overlap sidebar */
      background: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      min-height: 100vh;
      overflow: auto;
    }

    .dashboard-widgets {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); /* Makes it responsive */
      gap: 20px;
      margin-bottom: 20px;
    }

    .widget {
      padding: 20px;
      border-radius: 10px;
      text-align: center;
      color: white;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      font-size: 20px;
      margin-bottom: 15px;
    }

    .widget i {
      font-size: 40px;
      margin-bottom: 10px;
    }

    /* Widget Colors */
    .widget-vehicles {
      background: #28a745;
    }

    .widget-drivers {
      background: #007bff;
    }

    .widget-rentals {
      background: #ffc107;
    }

    .widget-pending {
      background: #e74c3c;
    }

    .widget h3 {
      font-size: 28px;
      margin: 0;
    }

    .widget p {
      font-size: 18px;
      margin-top: 5px;
    }

    /* Chart Container */
    .chart-container {
      margin-top: 30px;
      display: flex;
      justify-content: space-between;
      gap: 20px;
      flex-wrap: wrap; /* Allow charts to wrap on smaller screens */
    }

    .chart {
      width: 100%;
      max-width: 600px;
      height: 300px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Styles for dynamic content */
    .dynamic-style {
      display: none;
    }

    .activity-feed {
      margin-top: 30px;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .activity-feed h3 {
      font-size: 20px;
      margin-bottom: 15px;
    }

    .activity-item {
      font-size: 16px;
      margin-bottom: 10px;
    }

  </style>
</head>
<body>

<div class="sidebar">
  <div class="dashboard-header">Dashboard</div>
  <a href="#" onclick="loadPage('addRental')"><i class="fas fa-car"></i> Manage Rentals</a>
  <a href="#" onclick="loadPage('addVehicle')"><i class="fas fa-truck"></i> Manage Vehicles</a>
  <a href="#" onclick="loadPage('addCustomer')"><i class="fas fa-users"></i> Manage Customers</a>
</div>

<div class="content" id="main-content">
  <h2>Welcome to the Dashboard</h2>
  <p>Select an option from the sidebar.</p>

  <!-- Dashboard Widgets -->
  <div class="dashboard-widgets">
    <div class="widget widget-vehicles">
      <i class="fas fa-car"></i>
      <h3>${vehicleCount}</h3>
      <p>Vehicles</p>
    </div>
    <div class="widget widget-drivers">
      <i class="fas fa-users"></i>
      <h3>${driverCount}</h3>
      <p>Drivers</p>
    </div>
    <div class="widget widget-rentals">
      <i class="fas fa-cogs"></i>
      <h3>${rentalCount}</h3>
      <p>Rentals</p>
    </div>
    <div class="widget widget-pending">
      <i class="fas fa-clock"></i>
      <h3>${pendingCount}</h3>
      <p>Pending Rentals</p>
    </div>
  </div>

  <!-- Chart Section -->
  <div class="chart-container">
    <!-- Bar Chart Example -->
    <div class="chart" id="rentalsChart">
      <canvas id="barChart"></canvas>
    </div>
    <div class="chart">
      <!-- Example of another chart, can be pie, line, etc. -->
      <canvas id="pieChart"></canvas>
    </div>
  </div>

  <!-- Activity Feed -->
  <div class="activity-feed">
    <h3>Recent Activity</h3>
    <div class="activity-item">Rental #12345 was added by Admin.</div>
    <div class="activity-item">Vehicle #67890 was returned by Customer A.</div>
    <div class="activity-item">Driver #54321 assigned to Rental #12346.</div>
  </div>

  <!-- Dynamic Content -->
  <div class="dynamic-content">
    <h4>Select an option from the sidebar to manage data.</h4>
  </div>
</div>

<script>
  // Function to load pages dynamically based on the sidebar selection
  function loadPage(page) {
    fetch(page)
            .then(response => response.text())
            .then(html => {
              const parser = new DOMParser();
              const doc = parser.parseFromString(html, 'text/html');

              // Extract content from the page and update the main content
              const newContent = doc.querySelector('.container');
              if (newContent) {
                document.getElementById('main-content').innerHTML = newContent.innerHTML;
              }

              // Remove previous dynamic styles
              document.querySelectorAll('.dynamic-style').forEach(styleTag => styleTag.remove());

              // Extract and apply new styles if there are any
              const styleTags = doc.querySelectorAll('style');
              styleTags.forEach(style => {
                const newStyle = document.createElement('style');
                newStyle.classList.add('dynamic-style');
                newStyle.innerHTML = style.innerHTML;
                document.head.appendChild(newStyle);
              });
            })
            .catch(error => console.error('Error loading page:', error));
  }

  // Chart.js Bar Chart Example
  const ctxBar = document.getElementById('barChart').getContext('2d');
  new Chart(ctxBar, {
    type: 'bar',
    data: {
      labels: ['January', 'February', 'March', 'April', 'May'],
      datasets: [{
        label: 'Rentals',
        data: [30, 50, 40, 60, 90],
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });

  // Chart.js Pie Chart Example
  const ctxPie = document.getElementById('pieChart').getContext('2d');
  new Chart(ctxPie, {
    type: 'pie',
    data: {
      labels: ['Rent', 'Return', 'Cancel'],
      datasets: [{
        data: [50, 30, 20],
        backgroundColor: ['#28a745', '#ffc107', '#e74c3c'],
        hoverOffset: 4
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false // Ensures it resizes properly
    }
  });
</script>

</body>
</html>

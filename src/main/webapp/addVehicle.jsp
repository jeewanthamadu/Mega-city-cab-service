<%@ page import="com.example.icbt.entity.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f0f0, #e8e8e8);
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            padding: 30px;
        }
        h1 {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #2d3748;
            text-align: center;
        }
        .form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
        }
        .search-bar {
            margin-bottom: 40px;
            text-align: center;
            margin-top: 40px;
        }

        .search-bar input {
            width: 80%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background: #f9f9f9;
            color: #333;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: 5px;
            color: #718096;
            font-weight: 500;
        }
        .form-group input, .form-group select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .submit-button {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        .search-bar {
            margin: 20px auto;
            text-align: center;
            width: 80%;
        }
        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.8);
        }
        thead {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            position: sticky;
            top: 0;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        .action-buttons button {
            margin-right: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }
        .edit-button {
            background-color: #FFC107;
        }
        .delete-button {
            background-color: #F44336;
        }
        .dashboard-button {
            position: fixed;
            top: 20px;
            left: 20px;
            background-color: #4299e1;
            padding: 10px;
            border-radius: 50%;
            color: white;
            font-size: 20px;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>

</head>
<body>
<a href="dashboard" class="dashboard-button"><i class="fas fa-home"></i></a>

<div class="container">
    <h1>Vehicle Management</h1>
    <form action="addVehicle" method="post" class="form">
        <div class="form-group">
            <label for="brand">Brand</label>
            <input type="text" id="brand" name="brand" required />
        </div>
        <div class="form-group">
            <label for="model">Model</label>
            <input type="text" id="model" name="model" required />
        </div>
        <div class="form-group">
            <label for="number">Vehicle Number</label>
            <input type="text" id="number" name="number" required />
        </div>
        <div class="form-group">
            <label for="year">Year</label>
            <input type="number" id="year" name="year" min="1900" max="2099" required />
        </div>
        <div class="form-group">
            <label for="gearMode">Gear Mode</label>
            <select id="gearMode" name="gearMode" required>
                <option value="">Select Gear Mode</option>
                <option value="Manual">Manual</option>
                <option value="Automatic">Automatic</option>
            </select>
        </div>
        <div class="form-group">
            <label for="color">Color</label>
            <input type="text" id="color" name="color" required />
        </div>
        <div class="form-group">
            <label for="value">Value ($)</label>
            <input type="number" id="value" name="value" step="0.01" required />
        </div>
        <div class="form-group">
            <label for="availability">Availability</label>
            <select id="availability" name="availability" required>
                <option value="true">Available</option>
                <option value="false">Not Available</option>
            </select>
        </div>
        <button type="submit" class="submit-button">Add Vehicle</button>
    </form>
    <div class="search-bar">
        <input type="text" id="search" placeholder="Search vehicles..." onkeyup="filterTable()" />
    </div>
    <div class="table-container">
        <table id="vehicleTable">
            <thead>
            <tr>
                <th>Brand</th>
                <th>Model</th>
                <th>Number</th>
                <th>Year</th>
                <th>Gear Mode</th>
                <th>Color</th>
                <th>Value ($)</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% List<Vehicle> vehicleList = (List<Vehicle>) request.getAttribute("vehicleList");
                if (vehicleList != null) {
                    for (Vehicle vehicle : vehicleList) { %>
            <tr>
                <td><%= vehicle.getBrand() %></td>
                <td><%= vehicle.getModel() %></td>
                <td><%= vehicle.getVehicleNumber() %></td>
                <td><%= vehicle.getYear() %></td>
                <td><%= vehicle.getGearMode() %></td>
                <td><%= vehicle.getColor() %></td>
                <td><%= vehicle.getValue() %></td>
                <td><%= vehicle.isAvailability() ? "Available" : "Not Available" %></td>
                <td class="action-buttons">
                    <button class="edit-button"><i class="fas fa-edit"></i></button>
                    <button class="delete-button"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
            <% }
            } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterTable() {
        const input = document.getElementById("search");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("vehicleTable");
        const trs = table.getElementsByTagName("tr");
        for (let i = 1; i < trs.length; i++) {
            let showRow = false;
            const tds = trs[i].getElementsByTagName("td");
            for (let j = 0; j < tds.length - 1; j++) {
                if (tds[j].innerText.toLowerCase().includes(filter)) {
                    showRow = true;
                    break;
                }
            }
            trs[i].style.display = showRow ? "" : "none";
        }
    }
</script>

</body>
</html>

<%--
<%@ page import="com.example.icbt.entity.Vehicle" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
        }

        .container {
            display: flex;
            flex-direction: column;
            gap: 40px;
            width: 90%;
            max-width: 1200px;
            margin-top: 40px;
        }

        .form-table-container {
            background-color: #fff;
            padding: 30px;
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 2px solid #4CAF50;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            font-size: 28px;
            color: #4CAF50;
            margin: 0;
        }

        .form {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* Creates three equal columns */
            gap: 20px;
            align-items: center;
            margin-bottom: 40px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .submit-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 20px;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: #ff0000;
            text-align: center;
            margin-top: 10px;
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
        }

        /* Scrollable Table */
        .table-container {
            max-height: 400px; /* Adjust this to your preferred max height */
            overflow-y: auto; /* Enables vertical scroll */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* Ensures that the table columns will not resize */
        }

        thead {
            background-color: #4CAF50;
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
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

        .action-buttons button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-table-container">
        <div class="form-header">
            <h1>Vehicle Management</h1>
        </div>

        <form action="addVehicle" method="post" class="form">
            <div class="form-group">
                <label for="brand">Brand</label>
                <input type="text" id="brand" name="brand" placeholder="Enter brand" required/>
            </div>

            <div class="form-group">
                <label for="model">Model</label>
                <input type="text" id="model" name="model" placeholder="Enter model" required/>
            </div>

            <div class="form-group">
                <label for="number">Vehicle Number</label>
                <input type="text" id="number" name="number" placeholder="Enter vehicle number" required/>
            </div>

            <div class="form-group">
                <label for="year">Year</label>
                <input type="number" id="year" name="year" placeholder="Enter year" min="1900" max="2099" required/>
            </div>

            <div class="form-group">
                <label for="gearMode">Gear Mode</label>
                <select id="gearMode" name="gearMode" required>
                    <option value="" disabled selected>Select Gear Mode</option>
                    <option value="Manual">Manual</option>
                    <option value="Automatic">Automatic</option>
                    <option value="Semi-Automatic">Semi-Automatic</option>
                </select>
            </div>

            <div class="form-group">
                <label for="color">Color</label>
                <input type="text" id="color" name="color" placeholder="Enter color" required/>
            </div>

            <div class="form-group">
                <label for="seatCount">Seat Count</label>
                <input type="number" id="seatCount" name="seatCount" placeholder="Enter seat count" min="1" required/>
            </div>

            <button type="submit" class="submit-button">Add Vehicle</button>

            <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <%= request.getParameter("error") %>
            </div>
            <% } %>
        </form>

        <!-- Vehicle Records Table -->
        <div class="search-bar">
            <input type="text" id="search" placeholder="Search vehicles..." onkeyup="filterTable()"/>
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
                    <th>Seats</th>
                    <th>Availabilty</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% List<Vehicle> vehicleList = (List<Vehicle>) request.getAttribute("vehicleList");
                    if (vehicleList != null) {
                        for (Vehicle vehicle : vehicleList) { %>
                <tr>
                    <td><%= vehicle.getBrand() %>
                    </td>
                    <td><%= vehicle.getModel() %>
                    </td>
                    <td><%= vehicle.getVehicleNumber() %>
                    </td>
                    <td><%= vehicle.getYear() %>
                    </td>
                    <td><%= vehicle.getGearMode() %>
                    </td>
                    <td><%= vehicle.getColor() %>
                    </td>
                    <td><%= vehicle.getSeatCount() %>
                    </td>
                    <td><%= vehicle.isAvailability() %>
                    </td>
                    <td class="action-buttons">
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <% }
                } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function filterTable() {
        const input = document.getElementById("search");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("vehicleTable");
        const trs = table.getElementsByTagName("tr");

        for (let i = 1; i < trs.length; i++) {
            const tds = trs[i].getElementsByTagName("td");
            let showRow = false;
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
</html>--%>


<%@ page import="com.example.icbt.entity.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-direction: column;
            gap: 40px;
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .form-table-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 2px solid #4CAF50;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            font-size: 28px;
            color: #4CAF50;
            margin: 0;
        }

        .form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            align-items: center;
            margin-bottom: 40px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .submit-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 20px;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        .search-bar {
            margin-bottom: 40px;
            text-align: center;
        }

        .search-bar input {
            width: 80%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        /* Scrollable Table */
        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #4CAF50;
            color: white;
            position: sticky;
            top: 0;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
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

        .action-buttons button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-table-container">
        <div class="form-header">
            <h1>Vehicle Management</h1>
        </div>

        <form action="addVehicle" method="post" class="form">
            <div class="form-group">
                <label for="brand">Brand</label>
                <input type="text" id="brand" name="brand" placeholder="Enter brand" required/>
            </div>

            <div class="form-group">
                <label for="model">Model</label>
                <input type="text" id="model" name="model" placeholder="Enter model" required/>
            </div>

            <div class="form-group">
                <label for="number">Vehicle Number</label>
                <input type="text" id="number" name="number" placeholder="Enter vehicle number" required/>
            </div>

            <div class="form-group">
                <label for="year">Year</label>
                <input type="number" id="year" name="year" placeholder="Enter year" min="1900" max="2099" required/>
            </div>

            <div class="form-group">
                <label for="gearMode">Gear Mode</label>
                <select id="gearMode" name="gearMode" required>
                    <option value="" disabled selected>Select Gear Mode</option>
                    <option value="Manual">Manual</option>
                    <option value="Automatic">Automatic</option>
                    <option value="Semi-Automatic">Semi-Automatic</option>
                </select>
            </div>

            <div class="form-group">
                <label for="color">Color</label>
                <input type="text" id="color" name="color" placeholder="Enter color" required/>
            </div>

            <div class="form-group">
                <label for="seatCount">Seat Count</label>
                <input type="number" id="seatCount" name="seatCount" placeholder="Enter seat count" min="1" required/>
            </div>

            <button type="submit" class="submit-button">Add Vehicle</button>
        </form>

        <!-- Vehicle Records Table -->
        <div class="search-bar">
            <input type="text" id="search" placeholder="Search vehicles..." onkeyup="filterTable()"/>
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
                    <th>Seats</th>
                    <th>Availability</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Vehicle> vehicleList = (List<Vehicle>) request.getAttribute("vehicleList");
                    if (vehicleList != null) {
                        for (Vehicle vehicle : vehicleList) {
                %>
                <tr>
                    <td><%= vehicle.getBrand() %>
                    </td>
                    <td><%= vehicle.getModel() %>
                    </td>
                    <td><%= vehicle.getVehicleNumber() %>
                    </td>
                    <td><%= vehicle.getYear() %>
                    </td>
                    <td><%= vehicle.getGearMode() %>
                    </td>
                    <td><%= vehicle.getColor() %>
                    </td>
                    <td><%= vehicle.getSeatCount() %>
                    </td>
                    <td><%= vehicle.isAvailability() ? "Available" : "Not Available" %>
                    </td>
                    <td class="action-buttons">
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <% }
                } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function filterTable() {
        const input = document.getElementById("search").value.toLowerCase();
        const rows = document.querySelectorAll("#vehicleTable tbody tr");

        rows.forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(input) ? "" : "none";
        });
    }
</script>

</body>
</html>

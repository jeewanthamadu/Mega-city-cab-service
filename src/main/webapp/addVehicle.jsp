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
            /* Removed display: flex, justify-content, align-items, and height */
        }

        .container {
            /*width: 100%;
            max-width: 1200px;*/
            padding: 30px;
            background-color: #f4f7fa;
            /*box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            margin: 30px auto;*/
        }

        .form-header h1 {
            text-align: center;
            color: #4CAF50;
            margin-bottom: 30px;
        }

        .form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            background: #fff;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input, .form-group select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .submit-button {
            grid-column: span 3;
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .table-container {
            margin-top: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        thead {
            background-color: #4CAF50;
            color: white;
        }

        .action-buttons button {
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
    </style>
</head>
<body>

<div class="container">
    <div class="form-header">
        <h1>Vehicle Management</h1>
    </div>

    <form action="addVehicle" method="post" class="form">
        <div class="form-group">
            <label for="brand">Brand</label>
            <input type="text" id="brand" name="brand" required/>
        </div>
        <div class="form-group">
            <label for="model">Model</label>
            <input type="text" id="model" name="model" required/>
        </div>
        <div class="form-group">
            <label for="number">Vehicle Number</label>
            <input type="text" id="number" name="number" required/>
        </div>
        <div class="form-group">
            <label for="year">Year</label>
            <input type="number" id="year" name="year" min="1900" max="2099" required/>
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
            <input type="text" id="color" name="color" required/>
        </div>
        <div class="form-group">
            <label for="seatCount">Seat Count</label>
            <input type="number" id="seatCount" name="seatCount" min="1" required/>
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

    <div class="table-container">
        <table>
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

</body>
</html>



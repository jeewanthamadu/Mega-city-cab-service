<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rentals</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        button {
            padding: 10px 16px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            width: 100%;
        }

        button:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #28a745;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .search-bar {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .search-bar input {
            width: 70%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 style="text-align: center;">Manage Rentals</h2>
    <form class="form-container" action="addRental" method="post">
        <div class="form-group">
            <label for="vehicleId">Vehicle</label>
            <select name="vehicleId" id="vehicleId" required>
                <option value="">Select Vehicle</option>
                <c:forEach var="vehicle" items="${vehicleList}">
                    <option value="${vehicle.vehicleId}">${vehicle.model} (ID: ${vehicle.vehicleId})</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="driverId">Driver (Optional)</label>
            <select name="driverId" id="driverId">
                <option value="">Select Driver</option>
                <c:forEach var="driver" items="${driverList}">
                    <option value="${driver.driverId}">${driver.nic} (ID: ${driver.driverId})</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="customerId">Customer</label>
            <select name="customerId" id="customerId" required>
                <option value="">Select Customer</option>
                <c:forEach var="customer" items="${customerList}">
                    <option value="${customer.customerId}">${customer.nic} (ID: ${customer.customerId})</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="rentDate">Rent Date</label>
            <input type="date" name="rentDate" id="rentDate" required />
        </div>
        <div class="form-group">
            <label for="returnDate">Return Date</label>
            <input type="date" name="returnDate" id="returnDate" required />
        </div>
        <div class="form-group">
            <label for="description">Description</label>
            <textarea name="description" id="description" rows="4"></textarea>
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <select name="status" id="status" required>
                <option value="">Select Status</option>
                <option value="Rent">Rent</option>
                <option value="Return">Return</option>
                <option value="Cancel">Cancel</option>
                <option value="Complete">Complete</option>
            </select>
        </div>
        <button type="submit">Add Rental</button>
    </form>

    <div class="search-bar">
        <input type="text" placeholder="Search rentals...">
    </div>

    <table>
        <thead>
        <tr>
            <th>Rental ID</th>
            <th>Vehicle ID</th>
            <th>Driver ID</th>
            <th>Customer ID</th>
            <th>Rent Date</th>
            <th>Return Date</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="rental" items="${rentalList}">
            <tr>
                <td>${rental.rentalId}</td>
                <td>${rental.vehicleId}</td>
                <td>${rental.driverId != null ? rental.driverId : 'None'}</td>
                <td>${rental.customerId}</td>
                <td>${rental.rentDate}</td>
                <td>${rental.returnDate}</td>
                <td>${rental.status}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>

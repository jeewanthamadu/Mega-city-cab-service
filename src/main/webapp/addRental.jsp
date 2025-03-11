<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rentals</title>
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

        .form-table-container {
            padding: 30px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h1 {
            color: #4a5568;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #718096;
            font-weight: 500;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            background: #f9f9f9;
            color: #333;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
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
            margin-top: 20px;
            transition: background 0.3s ease;
        }

        .submit-button:hover {
            background: linear-gradient(135deg, #3182ce, #4299e1);
        }

        .error-message, .success-message {
            color: #e53e3e;
            text-align: center;
            margin-top: 10px;
        }

        .success-message{
            color: green;
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

        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        thead {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
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
            transition: background 0.3s ease;
        }

        .edit-button {
            background-color: #FFC107;
        }

        .delete-button, .return-button {
            background-color: #F44336;
        }

        .action-buttons button:hover {
            opacity: 0.8;
        }

        .dashboard-button {
            position: fixed;
            top: 20px;
            left: 20px;
            background: linear-gradient(110deg, #2f5575, #006fd7);
            color: white;
            padding: 10px;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 20px;
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease, transform 0.2s ease;
            overflow: hidden;
            position: relative;
            z-index: 100;
        }

        .dashboard-button:hover {
            background: linear-gradient(135deg, #3182ce, #4299e1);
            transform: translateY(-2px);
        }

        .dashboard-button::before {
            content: '';
            position: absolute;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1;
        }

        .dashboard-button:hover::before {
            width: 150%;
            height: 150%;
        }

        .dashboard-button i {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body>

<a href="dashboard" class="dashboard-button"><i class="fas fa-home"></i></a>

<div class="container">
    <div class="form-header">
        <h1>Manage Rentals</h1>
    </div>

    <form class="form" action="addRental" method="post">
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
        <button type="submit" class="submit-button">Add Rental</button>
        <% if (request.getParameter("error") != null) { %>
        <div class="error-message"><%= request.getParameter("error") %></div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
        <div class="success-message"><%= request.getParameter("success") %></div>
        <% } %>
    </form>

    <div class="search-bar">
        <input type="text" id="search" placeholder="Search rentals..." onkeyup="filterTable()"/>
    </div>

    <div class="table-container">
        <table id="rentalTable">
            <thead>
            <tr>
                <th>Rental ID</th>
                <th>Vehicle ID</th>
                <th>Driver ID</th>
                <th>Customer ID</th>
                <th>Rent Date</th>
                <th>Return Date</th>
                <th>Status</th>
                <th>Action</th>
                <th>Cost</th>
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
                <td>${rental.cost}</td>
                    <td class="action-buttons">
                        <c:if test="${rental.status == 'Rent'}">
                            <form action="returnVehicle" method="post">
                                <input type="hidden" name="rentalId" value="${rental.rentalId}">
                                <button class="return-button"><i class="fas fa-undo"></i></button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    function filterTable() {
        const input = document.getElementById("search");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("rentalTable");
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
</html>
<%@ page import="com.example.icbt.entity.Driver" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Management</title>

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

        .table-container {
            max-height: 400px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
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

        .email-cell:hover::after {
            content: attr(data-full-email);
            position: absolute;
            background-color: #333;
            color: white;
            padding: 5px;
            border-radius: 4px;
            white-space: nowrap;
            z-index: 10;
        }

        .email-cell {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 200px; /* Adjust as needed */
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
            <h1>Driver Management</h1>
        </div>

        <form action="addDriver" method="post" class="form">
            <div class="form-group">
                <label for="driverName">Driver Name</label>
                <input type="text" id="driverName" name="driverName" placeholder="Enter driver name" required/>
            </div>

            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age" placeholder="Enter age" required/>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter email" required/>
            </div>

            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter phone number" required/>
            </div>

            <div class="form-group">
                <label for="nic">NIC</label>
                <input type="text" id="nic" name="nic" placeholder="Enter NIC" required/>
            </div>

            <div class="form-group">
                <label for="licenseNumber">License Number</label>
                <input type="text" id="licenseNumber" name="licenseNumber" placeholder="Enter license number" required/>
            </div>

            <div class="form-group">
                <label for="gearType">Gear Type</label>
                <select id="gearType" name="gearType" required>
                    <option value="" disabled selected>Select Gear Type</option>
                    <option value="Manual">Manual</option>
                    <option value="Auto">Auto</option>
                    <option value="Both">Both</option>
                </select>
            </div>

            <button type="submit" class="submit-button">Add Driver</button>
        </form>

        <div class="search-bar">
            <input type="text" id="search" placeholder="Search drivers..." onkeyup="filterTable()"/>
        </div>

        <div class="table-container">
            <table id="driverTable">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>NIC</th>
                    <th>License</th>
                    <th>Gear Type</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% List<Driver> driverList = (List<Driver>) request.getAttribute("driverList");
                    if (driverList != null) {
                        for (Driver driver : driverList) { %>
                <tr>
                    <td><%= driver.getDriverName() %>
                    </td>
                    <td><%= driver.getAge() %>
                    </td>
                    <td class="email-cell" data-full-email="<%= driver.getEmail() %>"><%= driver.getEmail() %>
                    </td>
                    <td><%= driver.getPhoneNumber() %>
                    </td>
                    <td><%= driver.getNic() %>
                    </td>
                    <td><%= driver.getLicenseNumber() %>
                    </td>
                    <td><%= driver.getGearType() %>
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
        const table = document.getElementById("driverTable");
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
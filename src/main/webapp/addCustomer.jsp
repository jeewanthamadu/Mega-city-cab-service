<%@ page import="com.example.icbt.entity.Customer" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>

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

        .form-group input {
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
            <h1>Customer Management</h1>
        </div>

        <form action="addCustomer" method="post" class="form">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter name" required/>
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
                <label for="age">Age</label>
                <input type="number" id="age" name="age" placeholder="Enter age" min="18" required/>
            </div>

            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter phone number" required/>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter email" required/>
            </div>

            <button type="submit" class="submit-button">Add Customer</button>

            <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <%= request.getParameter("error") %>
            </div>
            <% } %>
        </form>

        <div class="search-bar">
            <input type="text" id="search" placeholder="Search customers..." onkeyup="filterTable()"/>
        </div>

        <div class="table-container">
            <table id="customerTable">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>NIC</th>
                    <th>License Number</th>
                    <th>Age</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
                    if (customerList != null) {
                        for (Customer customer : customerList) { %>
                <tr>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getNic() %></td>
                    <td><%= customer.getLicenseNumber() %></td>
                    <td><%= customer.getAge() %></td>
                    <td><%= customer.getPhoneNumber() %></td>
                    <td><%= customer.getEmail() %></td>
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
        const table = document.getElementById("customerTable");
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

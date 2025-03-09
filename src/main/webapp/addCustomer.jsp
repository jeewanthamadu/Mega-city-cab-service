<%@ page import="com.example.icbt.entity.Customer" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f0f0, #e8e8e8);
            margin: 0;
            padding: 0;
            color: #333;
            position: relative; /* Add this line */
            top: 10px; /* Add this line */
            right: 10px; /* Add this line */
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

        .form-group input, .form-group select {
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

        .error-message {
            color: #e53e3e;
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

        .delete-button {
            background-color: #F44336;
        }

        .action-buttons button:hover {
            opacity: 0.8;
        }

        .dashboard-button {
            position: fixed; /* Change to fixed */
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
            z-index: 100; /* High z-index to ensure it's on top */
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
            top: 50%; /* Center the circle */
            left: 50%; /* Center the circle */
            transform: translate(-50%, -50%); /* Correct transform */
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1; /* Place the circle behind the icon */
        }

        .dashboard-button:hover::before {
            width: 150%;
            height: 150%;
        }

        .dashboard-button i {
            position: relative;
            z-index: 1; /* Ensure icon is above the circle */
        }
    </style>
</head>
<body>

<a href="dashboard" class="dashboard-button"><i class="fas fa-home"></i></a>

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
            <div class="error-message"><%= request.getParameter("error") %></div>
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
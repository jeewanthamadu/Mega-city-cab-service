<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.icbt.model.Booking" %>

<!DOCTYPE html>
<html>
<head>
  <title>Booking List</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      padding: 20px;
    }
    table {
      width: 80%;
      border-collapse: collapse;
      margin: auto;
      background-color: white;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    th, td {
      padding: 12px;
      border: 1px solid #ddd;
      text-align: center;
    }
    th {
      background-color: #4CAF50;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    a {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #4CAF50;
      text-decoration: none;
    }
  </style>
</head>
<body>
<h2 style="text-align:center;">Booking List</h2>

<table>
  <tr>
    <th>ID</th>
    <th>Customer Name</th>
    <th>Pickup Location</th>
    <th>Dropoff Location</th>
  </tr>
  <%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    if (bookings != null && !bookings.isEmpty()) {
      for (Booking booking : bookings) {
  %>
  <tr>
    <td><%= booking.getId() %></td>
    <td><%= booking.getCustomerName() %></td>
    <td><%= booking.getPickupLocation() %></td>
    <td><%= booking.getDropoffLocation() %></td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="4">No bookings found.</td>
  </tr>
  <%
    }
  %>
</table>

<a href="index.jsp">Back to Booking Form</a>

</body>
</html>

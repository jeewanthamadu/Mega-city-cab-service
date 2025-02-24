<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.icbt.model.Booking" %>
<!DOCTYPE html>
<html>
<head>
  <title>Cab Booking Dashboard</title>
  <style>
    body { font-family: Arial, background: #f4f4f4; padding: 20px; }
    .container { display: flex; justify-content: space-between; }
    form, table { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    form { max-width: 400px; width: 45%; }
    table { width: 50%; border-collapse: collapse; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
    th { background-color: #4CAF50; color: white; }
    button { background: #4CAF50; color: white; padding: 10px; width: 100%; border: none; cursor: pointer; }
    button:disabled { background: gray; cursor: not-allowed; }
  </style>
</head>
<body>
<h1>Cab Booking Dashboard</h1>

<div class="container">
  <!-- Booking Form -->
  <form action="hello-servlet" method="post">
    <h2>New Booking</h2>
    <label>Booking ID:</label>
    <input type="number" name="id" required>

    <label>Customer Name:</label>
    <input type="text" name="customerName" required>

    <label>Pickup Location:</label>
    <input type="text" name="pickupLocation" required>

    <label>Dropoff Location:</label>
    <input type="text" name="dropoffLocation" required>

    <button type="submit">Book Now</button>
  </form>

  <!-- Bookings Table -->
  <table>
    <tr>
      <th>ID</th>
      <th>Customer Name</th>
      <th>Pickup</th>
      <th>Dropoff</th>
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
    <tr><td colspan="4">No bookings available.</td></tr>
    <%
      }
    %>
  </table>
</div>
</body>
</html>

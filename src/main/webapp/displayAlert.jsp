<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Vehicle</title>
  <script>
    window.onload = function() {
      const urlParams = new URLSearchParams(window.location.search);
      const success = urlParams.get('success');
      const error = urlParams.get('error');

      if (success) {
        alert(success); // Success Alert
      } else if (error) {
        alert(error); // Error Alert
      }
    };
  </script>
</head>
<body>
<!-- Your existing form here -->
</body>
</html>
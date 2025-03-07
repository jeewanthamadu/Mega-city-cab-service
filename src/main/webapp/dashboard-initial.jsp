<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Welcome to the Dashboard</h2>
<div class="dashboard-widgets">
    <div class="widget widget-vehicles">
        <i class="fas fa-car"></i>
        <h3>${totalVehicles}</h3>
        <p>Vehicles</p>
    </div>

    <div class="widget widget-drivers">
        <i class="fas fa-users"></i>
        <h3>${driverCount}</h3>
        <p>Drivers</p>
    </div>

    <div class="widget widget-customers">
        <i class="fas fa-user"></i>
        <h3>${totalRentals}</h3>
        <p>Total Rentals</p>
    </div>

    <div class="widget widget-rentals">
        <i class="fas fa-handshake"></i>
        <h3>${pendingCount}</h3>
        <p>Pending Rentals</p>
    </div>

    <div class="widget widget-revenue">
        <i class="fas fa-dollar-sign"></i>
        <h3>${availableVehicles}</h3>
        <p>Available Vehicles</p>
    </div>

    <div class="widget widget-completed">
        <i class="fas fa-check-circle"></i>
        <h3>${completedRentals}</h3>
        <p>Completed Rentals</p>
    </div>

    <div class="widget widget-pending">
        <i class="fas fa-clock"></i>
        <h3>${pendingRentals}</h3>
        <p>Pending Rentals</p>
    </div>
</div>
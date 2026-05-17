<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<div class="w3-card w3-white w3-padding w3-round-large w3-margin">

    <h2 class="w3-text-theme">Welcome 👋</h2>

    <p class="w3-large">
        Login successful! Hello <strong>${user.name}</strong>.
    </p>

    <hr>

    <h4>What can you do now?</h4>

    <div class="w3-row-padding">

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-home"></i> Main Page</h5>
                <p>View the main feed with posts and updates from the community.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-calendar"></i> Eventos</h5>
                <p>Check upcoming “diades” and detailed information about each event.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-user"></i> Profile</h5>
                <p>View and edit your personal information and preferences.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-sign-out"></i> Logout</h5>
                <p>End your session safely and return to login screen.</p>
            </div>
        </div>

    </div>

</div>

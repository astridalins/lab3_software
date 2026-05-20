<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<div style="background-image: url('assets/castell_colors_closeup.jpg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<c:choose>

    <c:when test="${not empty user}">

        <div id="${user.id}"
             class="w3-container w3-card w3-round w3-white w3-padding w3-margin-bottom">

            <div class="w3-center">

                <h2 class="w3-text-theme">Perfil</h2>

                <img src="${user.picture}"
                     class="w3-circle"
                     style="height:120px;width:120px"
                     alt="Avatar">

                <h3>${user.name}</h3>

            </div>

            <hr>

            <p><b>Username:</b> ${user.username}</p>

            <p><b>Email:</b> ${user.email}</p>

            <p><b>Localitat:</b> ${user.location}</p>

            <p><b>Tipus usuari:</b> ${user.userType}</p>

            <p><b>Colla:</b> ${user.colla}</p>

            <p><b>Posicions:</b> ${user.posicions}</p>

        </div>

    </c:when>

    <c:otherwise>

        <div class="w3-panel w3-yellow">
            <p>No hi ha usuari logejat.</p>
        </div>

    </c:otherwise>

</c:choose>
</div>
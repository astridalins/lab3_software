<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div style="background-image: url('assets/castell_lateral.png'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-card w3-white w3-padding w3-round-large w3-margin">

    <h2 class="w3-text-theme">Benvingut 👋</h2>

    <p class="w3-large">
        Inici de sessió correcte! Hola <strong>${sessionScope.user.name}</strong>.
    </p>

    <hr>

    <h4>Què pots fer ara?</h4>

    <div class="w3-row-padding">

        <div class="w3-col m6 w3-margin-bottom">
            <a class="menu" href="MainPage" style="text-decoration:none;color:inherit">
                <div class="w3-panel w3-light-grey w3-round w3-hover-theme" style="cursor:pointer">
                    <h5><i class="fa fa-newspaper-o"></i> Forums</h5>
                    <p>Consulta i participa als fòrums privat, de colla i general.</p>
                </div>
            </a>
        </div>

        <div class="w3-col m6 w3-margin-bottom">
            <a class="menu" href="Eventos" style="text-decoration:none;color:inherit">
                <div class="w3-panel w3-light-grey w3-round w3-hover-theme" style="cursor:pointer">
                    <h5><i class="fa fa-calendar"></i> Esdeveniments</h5>
                    <p>Consulta les properes diades i la informació detallada de cada esdeveniment.</p>
                </div>
            </a>
        </div>

        <div class="w3-col m6 w3-margin-bottom">
            <a class="menu" href="Profile" style="text-decoration:none;color:inherit">
                <div class="w3-panel w3-light-grey w3-round w3-hover-theme" style="cursor:pointer">
                    <h5><i class="fa fa-user"></i> Perfil</h5>
                    <p>Consulta i edita la teva informació personal i preferències.</p>
                </div>
            </a>
        </div>

        <div class="w3-col m6 w3-margin-bottom">
            <a class="menu" href="Logout" style="text-decoration:none;color:inherit">
                <div class="w3-panel w3-light-grey w3-round w3-hover-red" style="cursor:pointer">
                    <h5><i class="fa fa-sign-out"></i> Tancar sessió</h5>
                    <p>Finalitza la sessió de manera segura i torna a la pantalla d'inici de sessió.</p>
                </div>
            </a>
        </div>

    </div>

</div>
</div>

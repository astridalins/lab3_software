<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<div class="w3-card w3-white w3-padding w3-round-large w3-margin">

    <h2 class="w3-text-theme">Benvingut 👋</h2>

    <p class="w3-large">
        Inici de sessió correcte! Hola <strong>${user.name}</strong>.
    </p>

    <hr>

    <h4>Què pots fer ara?</h4>

    <div class="w3-row-padding">

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-home"></i> Pàgina principal</h5>
                <p>Consulta el mur principal amb publicacions i actualitzacions de la comunitat.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-calendar"></i> Esdeveniments</h5>
                <p>Consulta les properes diades i la informació detallada de cada esdeveniment.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-user"></i> Perfil</h5>
                <p>Consulta i edita la teva informació personal i preferències.</p>
            </div>
        </div>

        <div class="w3-col m6">
            <div class="w3-panel w3-light-grey w3-round">
                <h5><i class="fa fa-sign-out"></i> Tancar sessió</h5>
                <p>Finalitza la sessió de manera segura i torna a la pantalla d’inici de sessió.</p>
            </div>
        </div>

    </div>

</div>
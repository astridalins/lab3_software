<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
<c:when test="${empty posts}">
    <p class="w3-opacity w3-center">No hi ha publicacions encara.</p>
</c:when>
<c:otherwise>
<c:forEach var="p" items="${posts}">
    <div id="${p.id}" class="w3-container w3-card w3-section w3-white w3-round w3-animate-opacity"><br>
        <img src="${user.picture}" alt="Avatar" class="w3-left w3-circle w3-margin-right" style="width:60px">
        <span class="w3-right w3-opacity"> ${p.postDateTime} </span>
        <h4> ${p.uname} </h4><br>
        <hr class="w3-clear">
        <p> ${p.content} </p>
        <button type="button" class="delPost w3-button w3-red w3-margin-bottom">
            <i class="fa fa-trash"></i> &nbsp;Eliminar
        </button>
    </div>
</c:forEach>
</c:otherwise>
</c:choose>

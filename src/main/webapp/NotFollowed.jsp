<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
<c:when test="${empty users}">
    <p class="w3-opacity w3-center">Ja segueixes a tothom!</p>
</c:when>
<c:otherwise>
<h5 class="w3-opacity">Suggeriments</h5>
<c:forEach var="u" items="${users}">
    <div id="${u.id}" class="w3-container w3-card w3-round w3-white w3-center w3-section">
        <p class="w3-opacity">Suggeriment de seguidor</p>
        <img src="${u.picture}" alt="Avatar" style="width:50%"><br>
        <div class="w3-padding-small">${u.name}</div>
        <button type="button" class="followUser w3-row w3-button w3-green w3-section">
            <i class="fa fa-user-plus"></i> &nbsp;Seguir
        </button>
    </div>
</c:forEach>
</c:otherwise>
</c:choose>

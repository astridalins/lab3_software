<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
});
</script>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-container w3-padding">

    <%-- Banner informatiu per a usuari anònim --%>
    <div class="w3-card w3-white w3-round w3-padding w3-margin-bottom"
         style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px">
        <div>
            <i class="fa fa-globe w3-text-theme"></i>
            <strong class="w3-text-theme"> Posts públics</strong>
            <span class="w3-text-grey w3-small"> — Inicia sessió per publicar, fer like i seguir usuaris</span>
        </div>
        <div style="display:flex; gap:8px">
            <a class="menu w3-button w3-theme w3-round w3-small" href="Login">
                <i class="fa fa-sign-in"></i> Login
            </a>
            <a class="menu w3-button w3-light-grey w3-round w3-small" href="Register">
                <i class="fa fa-user-plus"></i> Registre
            </a>
        </div>
    </div>

    <%-- Llista de posts públics (read-only) --%>
    <c:choose>
        <c:when test="${empty totsPosts}">
            <p class="w3-panel w3-white w3-round w3-opacity">No hi ha posts públics.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="p" items="${totsPosts}">
                <div class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
                    <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                         class="w3-left w3-circle w3-margin-right"
                         style="width:48px;height:48px;object-fit:cover">
                    <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
                    <strong>${p.uname}</strong><br>
                    <hr class="w3-clear">
                    <p>${p.content}</p>
                    <c:if test="${not empty p.imagePath}">
                        <img src="${p.imagePath}" alt="imatge"
                             style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
                    </c:if>
                    <%-- Like desactivat per a anònims --%>
                    <button type="button" disabled
                            class="w3-button w3-light-grey w3-round w3-small"
                            title="Inicia sessió per fer like">
                        <i class="fa fa-thumbs-up"></i> ${p.likeCount}
                    </button>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>
</div>

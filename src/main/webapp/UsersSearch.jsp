<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
});
</script>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-container w3-padding">

    <h2 class="w3-text-white" style="text-shadow:1px 1px 4px #000">Gestió de seguidors</h2>

    <!-- ═══════════════ USUARIS QUE SEGUEIXES ═══════════════ -->
    <h4 class="w3-text-white" style="text-shadow:1px 1px 4px #000">
        <i class="fa fa-users"></i> A qui segueixes
    </h4>

    <c:choose>
        <c:when test="${empty followedUsers}">
            <p class="w3-panel w3-white w3-round w3-opacity">
                Encara no segueixes ningú.
            </p>
        </c:when>
        <c:otherwise>
            <div class="w3-row-padding">
                <c:forEach var="u" items="${followedUsers}">
                    <div id="${u.id}" class="w3-col m3 w3-margin-bottom">
                        <div class="w3-card w3-white w3-padding w3-center w3-round w3-animate-opacity">
                            <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                                 style="width:70px;height:70px;border-radius:50%;object-fit:cover"
                                 alt="Avatar">
                            <h5 class="w3-margin-top">${u.name}</h5>
                            <p class="w3-opacity w3-small">@${u.username}</p>
                            <button type="button" class="unfollowUser w3-button w3-red w3-round w3-block w3-margin-top">
                                <i class="fa fa-user-times"></i> Deixar de seguir
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <hr class="w3-border-white" style="margin:24px 0">

    <!-- ═══════════════ SUGGERIMENTS ═══════════════ -->
    <h4 class="w3-text-white" style="text-shadow:1px 1px 4px #000">
        <i class="fa fa-user-plus"></i> Suggeriments
    </h4>

    <c:choose>
        <c:when test="${empty notFollowedUsers}">
            <p class="w3-panel w3-white w3-round w3-opacity">
                Ja segueixes a tothom!
            </p>
        </c:when>
        <c:otherwise>
            <div class="w3-row-padding">
                <c:forEach var="u" items="${notFollowedUsers}">
                    <div id="${u.id}" class="w3-col m3 w3-margin-bottom">
                        <div class="w3-card w3-white w3-padding w3-center w3-round w3-animate-opacity">
                            <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                                 style="width:70px;height:70px;border-radius:50%;object-fit:cover"
                                 alt="Avatar">
                            <h5 class="w3-margin-top">${u.name}</h5>
                            <p class="w3-opacity w3-small">@${u.username}</p>
                            <button type="button" class="followUser w3-button w3-green w3-round w3-block w3-margin-top">
                                <i class="fa fa-user-plus"></i> Seguir
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</div>

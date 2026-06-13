<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
});

function cercaUsuaris() {
    const q = document.getElementById('searchInput').value.toLowerCase().trim();
    let total = 0;

    document.querySelectorAll('.user-card').forEach(function(card) {
        const username = card.getAttribute('data-username').toLowerCase();
        const matches  = !q || username.includes(q);
        card.style.display = matches ? '' : 'none';
        if (matches) total++;
    });

    // Amaga/mostra NOMÉS les capçaleres de secció, no els contenidors
    document.querySelectorAll('.section-header').forEach(function(h) {
        h.style.display = q ? 'none' : '';
    });

    const countEl = document.getElementById('searchCount');
    if (q) {
        countEl.textContent = total + (total === 1 ? ' coincidència' : ' coincidències') + ' per a "' + q + '"';
        countEl.style.display = 'block';
    } else {
        countEl.style.display = 'none';
    }
}
</script>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-container w3-padding">

<!-- ═══ CARD ÚNICA ═══════════════════════════════════════════════════════ -->
<div class="w3-card w3-white w3-round w3-padding">

    <h2 class="w3-text-theme"><i class="fa fa-users"></i> Gestió de seguidors</h2>

    <!-- ── Buscador ── -->
    <div class="w3-row w3-margin-bottom">
        <div class="w3-col" style="width:calc(100% - 110px)">
            <input id="searchInput" type="text" class="w3-input w3-border w3-round-left"
                   placeholder="Cerca per username..."
                   oninput="cercaUsuaris()"
                   onkeydown="if(event.key==='Enter') cercaUsuaris()">
        </div>
        <div class="w3-col" style="width:110px">
            <button onclick="cercaUsuaris()"
                    class="w3-button w3-theme w3-round-right w3-block">
                <i class="fa fa-search"></i> Cerca
            </button>
        </div>
    </div>
    <p id="searchCount" class="w3-text-theme w3-small" style="display:none; margin-top:-8px"></p>

    <!-- ═══ A QUI SEGUEIXES ═══════════════════════════════════════════════ -->
    <div class="section-header">
        <hr class="w3-border" style="margin:8px 0 12px">
        <h4 class="w3-text-theme"><i class="fa fa-heart"></i> A qui segueixes</h4>
    </div>

    <c:choose>
        <c:when test="${empty followedUsers}">
            <p class="w3-text-grey w3-small">Encara no segueixes ningú.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="u" items="${followedUsers}">
                <div id="${u.id}" class="user-card"
                     data-username="${u.username}"
                     style="display:flex; align-items:center; gap:14px;
                            padding:10px 0; border-bottom:1px solid #f0f0f0;">
                    <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                         style="width:50px;height:50px;border-radius:50%;object-fit:cover;flex-shrink:0">
                    <div style="flex:1; min-width:0">
                        <strong>${u.name}</strong>
                        <p class="w3-opacity w3-small" style="margin:0">@${u.username}</p>
                    </div>
                    <button type="button" class="viewProfile w3-button w3-blue w3-round" data-uid="${u.id}" style="flex-shrink:0">
                        <i class="fa fa-eye"></i>
                    </button>
                    <c:if test="${sessionScope.user.admin != 1}">
                    <button type="button" class="unfollowUser w3-button w3-red w3-round" style="flex-shrink:0">
                        <i class="fa fa-user-times"></i> Deixar de seguir
                    </button>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <!-- ═══ SUGGERIMENTS ══════════════════════════════════════════════════ -->
    <div class="section-header">
        <hr class="w3-border" style="margin:16px 0 12px">
        <h4 class="w3-text-theme"><i class="fa fa-user-plus"></i> Suggeriments</h4>
    </div>

    <c:choose>
        <c:when test="${empty notFollowedUsers}">
            <p class="w3-text-grey w3-small">Ja segueixes a tothom!</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="u" items="${notFollowedUsers}">
                <div id="${u.id}" class="user-card"
                     data-username="${u.username}"
                     style="display:flex; align-items:center; gap:14px;
                            padding:10px 0; border-bottom:1px solid #f0f0f0;">
                    <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                         style="width:50px;height:50px;border-radius:50%;object-fit:cover;flex-shrink:0">
                    <div style="flex:1; min-width:0">
                        <strong>${u.name}</strong>
                        <p class="w3-opacity w3-small" style="margin:0">@${u.username}</p>
                    </div>
                    <button type="button" class="viewProfile w3-button w3-blue w3-round" data-uid="${u.id}" style="flex-shrink:0">
                        <i class="fa fa-eye"></i>
                    </button>
                    <c:if test="${sessionScope.user.admin != 1}">
                    <button type="button" class="followUser w3-button w3-green w3-round" style="flex-shrink:0">
                        <i class="fa fa-user-plus"></i> Seguir
                    </button>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>
<!-- ═══ FI CARD ÚNICA ═══════════════════════════════════════════════════ -->

</div>
</div>

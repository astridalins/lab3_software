<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
});

function cercaAnon() {
    const q = document.getElementById('anonSearchInput').value.toLowerCase().trim();
    let total = 0;
    document.querySelectorAll('.anon-user-card').forEach(function(card) {
        const username = card.getAttribute('data-username').toLowerCase();
        const matches  = !q || username.includes(q);
        card.style.display = matches ? '' : 'none';
        if (matches) total++;
    });
    const countEl = document.getElementById('anonSearchCount');
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

<div class="w3-card w3-white w3-round w3-padding">

    <h2 class="w3-text-theme"><i class="fa fa-users"></i> Cerca d'usuaris</h2>
    <p class="w3-text-grey w3-small">
        <i class="fa fa-info-circle"></i>
        Inicia sessió per seguir usuaris i veure el seu contingut privat.
    </p>

    <%-- Buscador --%>
    <div class="w3-row w3-margin-bottom">
        <div class="w3-col" style="width:calc(100% - 110px)">
            <input id="anonSearchInput" type="text" class="w3-input w3-border w3-round-left"
                   placeholder="Cerca per username..."
                   oninput="cercaAnon()"
                   onkeydown="if(event.key==='Enter') cercaAnon()">
        </div>
        <div class="w3-col" style="width:110px">
            <button onclick="cercaAnon()"
                    class="w3-button w3-theme w3-round-right w3-block">
                <i class="fa fa-search"></i> Cerca
            </button>
        </div>
    </div>
    <p id="anonSearchCount" class="w3-text-theme w3-small" style="display:none; margin-top:-8px"></p>

    <hr class="w3-border" style="margin:8px 0 12px">

    <c:choose>
        <c:when test="${empty allUsers}">
            <p class="w3-text-grey w3-small">No hi ha usuaris registrats.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="u" items="${allUsers}">
                <div class="anon-user-card"
                     data-username="${u.username}"
                     style="display:flex; align-items:center; gap:14px;
                            padding:10px 0; border-bottom:1px solid #f0f0f0;">
                    <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                         style="width:50px;height:50px;border-radius:50%;object-fit:cover;flex-shrink:0">
                    <div style="flex:1; min-width:0">
                        <strong>${u.name}</strong>
                        <p class="w3-opacity w3-small" style="margin:0">@${u.username}</p>
                        <p class="w3-small w3-text-grey" style="margin:0">${u.userType}</p>
                    </div>
                    <button type="button"
                            class="anonViewProfile w3-button w3-blue w3-round"
                            data-uid="${u.id}" style="flex-shrink:0">
                        <i class="fa fa-eye"></i> Veure
                    </button>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>
</div>
</div>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
    showTab('privat');
});

function showTab(name) {
    ['privat','colla','tots'].forEach(function(t) {
        document.getElementById('tab-' + t).style.display = (t === name) ? 'block' : 'none';
    });
    document.querySelectorAll('.tab-btn').forEach(function(b) {
        b.classList.remove('w3-theme');
        b.classList.add('w3-light-grey');
    });
    var active = document.getElementById('btn-' + name);
    if (active) {
        active.classList.remove('w3-light-grey');
        active.classList.add('w3-theme');
    }
}
</script>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-container w3-padding">

    <h2 class="w3-text-white" style="text-shadow:1px 1px 4px #000">
        <i class="fa fa-newspaper-o"></i> Forums
    </h2>

    <!-- ── TAB BUTTONS ────────────────────────────────────────────────────── -->
    <div class="w3-bar w3-card w3-white w3-round w3-margin-bottom">
        <button id="btn-privat" class="tab-btn w3-bar-item w3-button w3-theme w3-round"
                onclick="showTab('privat')">
            <i class="fa fa-lock"></i> Privat
        </button>
        <c:if test="${not empty collaPosts or
                     (sessionScope.user.userType == 'CASTELLER' and not empty sessionScope.user.colla)}">
            <button id="btn-colla" class="tab-btn w3-bar-item w3-button w3-light-grey w3-round"
                    onclick="showTab('colla')">
                <i class="fa fa-users"></i> Colla
            </button>
        </c:if>
        <button id="btn-tots" class="tab-btn w3-bar-item w3-button w3-light-grey w3-round"
                onclick="showTab('tots')">
            <i class="fa fa-globe"></i> Tots
        </button>
    </div>

    <%-- ══════════════════════ TAB PRIVAT ══════════════════════ --%>
    <div id="tab-privat">
        <div class="w3-card w3-white w3-padding w3-round w3-margin-bottom">
            <p class="w3-opacity"><i class="fa fa-lock"></i> Només tu pots veure aquests posts.</p>
            <textarea id="txt-privat" class="w3-input w3-border w3-round" rows="3"
                      placeholder="Escriu un post privat..."></textarea>
            <button class="submitPost w3-button w3-theme w3-round w3-margin-top"
                    data-visibility="1" data-textarea="txt-privat">
                <i class="fa fa-send"></i> Publicar
            </button>
        </div>

        <c:choose>
            <c:when test="${empty privatPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity">No tens posts privats encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${privatPosts}">
                    <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
                        <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                             class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
                        <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
                        <strong>${p.uname}</strong><br>
                        <hr class="w3-clear">
                        <p>${p.content}</p>
                        <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                data-liked="${p.likedByMe}">
                            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                        </button>
                        <c:if test="${p.uid == sessionScope.user.id}">
                            <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- ══════════════════════ TAB COLLA ══════════════════════ --%>
    <div id="tab-colla" style="display:none">
        <div class="w3-card w3-white w3-padding w3-round w3-margin-bottom">
            <p class="w3-opacity"><i class="fa fa-users"></i>
                Fòrum intern de <strong>${sessionScope.user.colla}</strong>.
                Només el veuen els integrants castellers de la colla.
            </p>
            <textarea id="txt-colla" class="w3-input w3-border w3-round" rows="3"
                      placeholder="Escriu un missatge per a la colla..."></textarea>
            <button class="submitPost w3-button w3-theme w3-round w3-margin-top"
                    data-visibility="2" data-textarea="txt-colla">
                <i class="fa fa-send"></i> Publicar
            </button>
        </div>

        <c:choose>
            <c:when test="${empty collaPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity">No hi ha posts de colla encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${collaPosts}">
                    <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
                        <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                             class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
                        <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
                        <strong>${p.uname}</strong><br>
                        <hr class="w3-clear">
                        <p>${p.content}</p>
                        <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                data-liked="${p.likedByMe}">
                            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                        </button>
                        <c:if test="${p.uid == sessionScope.user.id}">
                            <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- ══════════════════════ TAB TOTS ══════════════════════ --%>
    <div id="tab-tots" style="display:none">
        <div class="w3-card w3-white w3-padding w3-round w3-margin-bottom">
            <p class="w3-opacity"><i class="fa fa-globe"></i> Visible per a tots els usuaris.</p>
            <textarea id="txt-tots" class="w3-input w3-border w3-round" rows="3"
                      placeholder="Escriu un post públic..."></textarea>
            <button class="submitPost w3-button w3-theme w3-round w3-margin-top"
                    data-visibility="0" data-textarea="txt-tots">
                <i class="fa fa-send"></i> Publicar
            </button>
        </div>

        <c:choose>
            <c:when test="${empty totsPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity">No hi ha posts públics encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${totsPosts}">
                    <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
                        <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                             class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
                        <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
                        <strong>${p.uname}</strong><br>
                        <hr class="w3-clear">
                        <p>${p.content}</p>
                        <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                data-liked="${p.likedByMe}">
                            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                        </button>
                        <c:if test="${p.uid == sessionScope.user.id}">
                            <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

</div>
</div>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
    showUPTab('privat');
});

function showUPTab(name) {
    ['privat','public'].forEach(function(t) {
        document.getElementById('uptab-' + t).style.display = (t === name) ? 'block' : 'none';
    });
    document.querySelectorAll('.uptab-btn').forEach(function(b) {
        b.classList.remove('w3-theme');
        b.classList.add('w3-light-grey');
    });
    var active = document.getElementById('upbtn-' + name);
    if (active) { active.classList.remove('w3-light-grey'); active.classList.add('w3-theme'); }
}
</script>

<div style="background-image: url('assets/castell_colors_closeup.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">

<c:set var="u" value="${targetUser}" />

<!-- ══ HEADER CARD ══════════════════════════════════════════════════════ -->
<div class="w3-card w3-white w3-round w3-padding w3-margin-bottom">
  <div class="w3-center">
    <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
         class="w3-circle" style="width:100px;height:100px;object-fit:cover" alt="Avatar">
    <h3>${u.name}</h3>
    <p class="w3-opacity">@${u.username}</p>
  </div>
  <hr>
  <p><b>Localitat:</b> ${empty u.location ? '—' : u.location}</p>
  <p><b>Tipus:</b> ${u.userType}</p>
  <c:if test="${u.userType == 'CASTELLER'}">
    <p><b>Colla:</b> ${empty u.colla ? '—' : u.colla}</p>
    <p><b>Posicions:</b> ${empty u.posicions ? '—' : u.posicions}</p>
  </c:if>
</div>

<!-- ══ TABS ════════════════════════════════════════════════════════════ -->
<div class="w3-bar w3-card w3-white w3-round w3-margin-bottom">
  <button id="upbtn-privat" class="uptab-btn w3-bar-item w3-button w3-theme w3-round"
          onclick="showUPTab('privat')">
    <i class="fa fa-lock"></i> Privat
  </button>
  <button id="upbtn-public" class="uptab-btn w3-bar-item w3-button w3-light-grey w3-round"
          onclick="showUPTab('public')">
    <i class="fa fa-globe"></i> Públic
  </button>
</div>

<%-- ══ TAB PRIVAT ══════════════════════════════════════════════════════ --%>
<div id="uptab-privat">
  <c:choose>
    <c:when test="${not isFollowing}">
      <div class="w3-panel w3-card w3-white w3-round w3-padding w3-center">
        <i class="fa fa-lock w3-xxlarge w3-text-grey" style="margin-bottom:12px;display:block"></i>
        <p class="w3-text-grey">Encara no segueixes a aquesta persona.</p>
        <p class="w3-text-grey w3-small">Segueix-la per veure el seu contingut privat.</p>
      </div>
    </c:when>
    <c:when test="${empty privatPosts}">
      <p class="w3-panel w3-white w3-round w3-opacity">Aquesta persona no té posts privats.</p>
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
          <c:if test="${not empty p.imagePath}">
            <img src="${p.imagePath}" alt="imatge del post"
                 style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
          </c:if>
          <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                  data-liked="${p.likedByMe}">
            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
          </button>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>

<%-- ══ TAB PÚBLIC ══════════════════════════════════════════════════════ --%>
<div id="uptab-public" style="display:none">
  <c:choose>
    <c:when test="${empty publicPosts}">
      <p class="w3-panel w3-white w3-round w3-opacity">Aquesta persona no té posts públics.</p>
    </c:when>
    <c:otherwise>
      <c:forEach var="p" items="${publicPosts}">
        <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
          <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
               class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
          <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
          <strong>${p.uname}</strong><br>
          <hr class="w3-clear">
          <p>${p.content}</p>
          <c:if test="${not empty p.imagePath}">
            <img src="${p.imagePath}" alt="imatge del post"
                 style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
          </c:if>
          <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                  data-liked="${p.likedByMe}">
            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
          </button>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>

</div>

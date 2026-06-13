<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<script>
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
    showProfileTab('privat');
});

function showProfileTab(name) {
    ['privat','public','respostes'].forEach(function(t) {
        document.getElementById('ptab-' + t).style.display = (t === name) ? 'block' : 'none';
    });
    document.querySelectorAll('.ptab-btn').forEach(function(b) {
        b.classList.remove('w3-theme');
        b.classList.add('w3-light-grey');
    });
    var active = document.getElementById('pbtn-' + name);
    if (active) { active.classList.remove('w3-light-grey'); active.classList.add('w3-theme'); }
}

function editProfile() {
    document.getElementById('view-mode').style.display = 'none';
    document.getElementById('edit-mode').style.display  = 'block';
}

function cancelEdit() {
    document.getElementById('edit-mode').style.display  = 'none';
    document.getElementById('view-mode').style.display = 'block';
    document.getElementById('editProfileForm').reset();
    document.querySelectorAll('.field-error').forEach(function(el){ el.textContent = ''; });
}
</script>

<div style="background-image: url('assets/castell_colors_closeup.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">

<c:choose>
<c:when test="${not empty sessionScope.user}">
<c:set var="u" value="${sessionScope.user}" />

  <!-- ══════════════ VIEW MODE ══════════════ -->
  <div id="view-mode" class="w3-card w3-white w3-round w3-padding w3-margin-bottom">

    <div class="w3-center">
      <h2 class="w3-text-theme">Perfil</h2>
      <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
           class="w3-circle" style="width:120px;height:120px;object-fit:cover" alt="Avatar">
      <h3>${u.name}</h3>
      <p class="w3-opacity">@${u.username}</p>
    </div>

    <hr>

    <p><b>Email:</b> ${u.email}</p>
    <p><b>Localitat:</b> ${u.location}</p>
    <p><b>Tipus:</b> ${u.userType}</p>
    <c:if test="${u.userType == 'CASTELLER'}">
      <p><b>Colla:</b> ${empty u.colla ? '—' : u.colla}</p>
      <p><b>Posicions:</b> ${empty u.posicions ? '—' : u.posicions}</p>
    </c:if>

    <div class="w3-right">
      <button type="button" onclick="editProfile()"
              class="w3-button w3-theme w3-round w3-margin-top">
        <i class="fa fa-pencil"></i> Editar perfil
      </button>
    </div>
    <div class="w3-clear"></div>
  </div>

  <!-- ══════════════ EDIT MODE ══════════════ -->
  <div id="edit-mode" style="display:none"
       class="w3-card w3-white w3-round w3-padding w3-margin-bottom">

    <h3 class="w3-text-theme"><i class="fa fa-pencil"></i> Editar perfil</h3>
    <hr>

    <form id="editProfileForm">

      <div class="w3-margin-bottom">
        <label class="w3-text-grey">Nom</label>
        <input class="w3-input w3-border w3-round" type="text" name="name"
               value="${u.name}" minlength="5" maxlength="20" required>
        <span class="field-error w3-text-red w3-small" id="err-name"></span>
      </div>

      <div class="w3-margin-bottom">
        <label class="w3-text-grey">Email</label>
        <input class="w3-input w3-border w3-round" type="email" name="email"
               value="${u.email}" required>
        <span class="field-error w3-text-red w3-small" id="err-email"></span>
      </div>

      <div class="w3-margin-bottom">
        <label class="w3-text-grey">Localitat</label>
        <input class="w3-input w3-border w3-round" type="text" name="location"
               value="${u.location}" pattern="[a-zA-ZÀ-ÿ\s]+" required>
        <span class="field-error w3-text-red w3-small" id="err-location"></span>
      </div>

      <c:if test="${u.userType == 'CASTELLER'}">
        <div class="w3-margin-bottom">
          <label class="w3-text-grey">Colla castellera</label>
          <input class="w3-input w3-border w3-round" list="collesList"
                 name="colla" value="${u.colla}" placeholder="Escriu o selecciona una colla">
          <datalist id="collesList">
            <c:forEach var="c" items="${colles}">
                <option value="${c.name}">
            </c:forEach>
          </datalist>
          <span class="field-error w3-text-red w3-small" id="err-colla"></span>
        </div>

        <div class="w3-margin-bottom">
          <label class="w3-text-grey">Posicions (pots seleccionar diverses)</label>
          <select class="w3-select w3-border w3-round" name="posicions" multiple size="8">
            <option value="baixos"      ${fn:contains(u.posicions,'baixos')      ? 'selected':''}> Baixos</option>
            <option value="contraforts" ${fn:contains(u.posicions,'contraforts') ? 'selected':''}> Contraforts</option>
            <option value="agulles"     ${fn:contains(u.posicions,'agulles')     ? 'selected':''}> Agulles</option>
            <option value="laterals"    ${fn:contains(u.posicions,'laterals')    ? 'selected':''}> Laterals</option>
            <option value="ventalls"    ${fn:contains(u.posicions,'ventalls')    ? 'selected':''}> Ventalls</option>
            <option value="segons"      ${fn:contains(u.posicions,'segons')      ? 'selected':''}> Segons</option>
            <option value="terços"      ${fn:contains(u.posicions,'terços')      ? 'selected':''}> Terços</option>
            <option value="quarts"      ${fn:contains(u.posicions,'quarts')      ? 'selected':''}> Quarts</option>
            <option value="quints"      ${fn:contains(u.posicions,'quints')      ? 'selected':''}> Quints</option>
            <option value="sisens"      ${fn:contains(u.posicions,'sisens')      ? 'selected':''}> Sisens</option>
            <option value="setens"      ${fn:contains(u.posicions,'setens')      ? 'selected':''}> Setens</option>
            <option value="dosos"       ${fn:contains(u.posicions,'dosos')       ? 'selected':''}> Dosos</option>
            <option value="acotxador"   ${fn:contains(u.posicions,'acotxador')   ? 'selected':''}> Acotxador</option>
            <option value="enxaneta"    ${fn:contains(u.posicions,'enxaneta')    ? 'selected':''}> Enxaneta</option>
            <option value="folre"       ${fn:contains(u.posicions,'folre')       ? 'selected':''}> Folre</option>
            <option value="manilles"    ${fn:contains(u.posicions,'manilles')    ? 'selected':''}> Manilles</option>
          </select>
          <span class="field-error w3-text-red w3-small" id="err-posicions"></span>
        </div>
      </c:if>

      <div class="w3-bar w3-margin-top">
        <button type="button" class="saveProfile w3-button w3-theme w3-round">
          <i class="fa fa-save"></i> Guardar canvis
        </button>
        <button type="button" onclick="cancelEdit()"
                class="w3-button w3-light-grey w3-round w3-margin-left">
          <i class="fa fa-times"></i> Cancel·lar
        </button>
      </div>

    </form>
  </div>

  <!-- ══════════════ POSTS SECTION ══════════════ -->
  <div class="w3-margin-top">
    <div class="w3-bar w3-card w3-white w3-round w3-margin-bottom">
      <button id="pbtn-privat" class="ptab-btn w3-bar-item w3-button w3-theme w3-round"
              onclick="showProfileTab('privat')">
        <i class="fa fa-lock"></i> Privat
      </button>
      <button id="pbtn-public" class="ptab-btn w3-bar-item w3-button w3-light-grey w3-round"
              onclick="showProfileTab('public')">
        <i class="fa fa-globe"></i> Públic
      </button>
      <button id="pbtn-respostes" class="ptab-btn w3-bar-item w3-button w3-light-grey w3-round"
              onclick="showProfileTab('respostes')">
        <i class="fa fa-reply"></i> Respostes
      </button>
    </div>

    <%-- TAB PRIVAT --%>
    <div id="ptab-privat">
      <c:choose>
        <c:when test="${empty ownPrivatPosts}">
          <p class="w3-panel w3-white w3-round w3-opacity">No tens posts privats.</p>
        </c:when>
        <c:otherwise>
          <c:forEach var="p" items="${ownPrivatPosts}">
            <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
              <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                   class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
              <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
              <strong>${p.uname}</strong><br>
              <hr class="w3-clear">
              <p class="post-text">${p.content}</p>
              <div class="post-edit-box" style="display:none; margin-top:8px">
                <textarea class="w3-input w3-border w3-round" rows="3"></textarea>
                <div style="margin-top:6px">
                  <button type="button" class="saveEdit w3-button w3-theme w3-round w3-small">
                    <i class="fa fa-save"></i> Guardar
                  </button>
                  <button type="button" class="cancelEdit w3-button w3-light-grey w3-round w3-small">
                    <i class="fa fa-times"></i> Cancel·lar
                  </button>
                </div>
              </div>
              <c:if test="${not empty p.imagePath}">
                <img src="${p.imagePath}" alt="imatge del post"
                     style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
              </c:if>
              <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                      data-liked="${p.likedByMe}">
                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
              </button>
              <button type="button" class="editPost w3-button w3-blue w3-round w3-small">
                <i class="fa fa-pencil"></i> Editar
              </button>
              <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                <i class="fa fa-trash"></i> Eliminar
              </button>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <%-- TAB RESPOSTES --%>
    <div id="ptab-respostes" style="display:none">
      <c:choose>
        <c:when test="${empty ownReplies}">
          <p class="w3-panel w3-white w3-round w3-opacity">Encara no has fet cap resposta.</p>
        </c:when>
        <c:otherwise>
          <c:forEach var="r" items="${ownReplies}">
            <div id="${r.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
              <div class="w3-margin-bottom" style="background:#e8f4fd; border-radius:6px; padding:6px 10px; font-size:12px; color:#555">
                <i class="fa fa-reply" style="color:#2196F3"></i>
                <strong>Resposta</strong>
                <c:if test="${not empty r.parentUname}"> a <em>${r.parentUname}</em></c:if>:
                <c:if test="${not empty r.parentText}">
                  "<c:out value="${r.parentText.length() > 80 ? r.parentText.substring(0,80).concat('…') : r.parentText}"/>"
                </c:if>
              </div>
              <img src="${empty r.userPicture ? 'assets/default_avatar.png' : r.userPicture}"
                   class="w3-left w3-circle w3-margin-right" style="width:40px;height:40px;object-fit:cover">
              <span class="w3-right w3-opacity w3-small">${r.postDateTime}</span>
              <strong>${r.uname}</strong><br>
              <hr class="w3-clear">
              <p>${r.content}</p>
              <c:if test="${not empty r.imagePath}">
                <img src="${r.imagePath}" style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
              </c:if>
              <button type="button"
                      class="likeToggle w3-button w3-round w3-small ${r.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                      data-liked="${r.likedByMe}">
                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${r.likeCount}</span>
              </button>
              <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                <i class="fa fa-trash"></i> Eliminar
              </button>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <%-- TAB PÚBLIC --%>
    <div id="ptab-public" style="display:none">
      <c:choose>
        <c:when test="${empty ownPublicPosts}">
          <p class="w3-panel w3-white w3-round w3-opacity">No tens posts públics.</p>
        </c:when>
        <c:otherwise>
          <c:forEach var="p" items="${ownPublicPosts}">
            <div id="${p.id}" class="w3-card w3-white w3-round w3-padding w3-margin-bottom w3-animate-opacity">
              <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                   class="w3-left w3-circle w3-margin-right" style="width:48px;height:48px;object-fit:cover">
              <span class="w3-right w3-opacity w3-small">${p.postDateTime}</span>
              <strong>${p.uname}</strong><br>
              <hr class="w3-clear">
              <p class="post-text">${p.content}</p>
              <div class="post-edit-box" style="display:none; margin-top:8px">
                <textarea class="w3-input w3-border w3-round" rows="3"></textarea>
                <div style="margin-top:6px">
                  <button type="button" class="saveEdit w3-button w3-theme w3-round w3-small">
                    <i class="fa fa-save"></i> Guardar
                  </button>
                  <button type="button" class="cancelEdit w3-button w3-light-grey w3-round w3-small">
                    <i class="fa fa-times"></i> Cancel·lar
                  </button>
                </div>
              </div>
              <c:if test="${not empty p.imagePath}">
                <img src="${p.imagePath}" alt="imatge del post"
                     style="max-width:100%; border-radius:10px; margin-bottom:8px; display:block">
              </c:if>
              <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                      data-liked="${p.likedByMe}">
                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
              </button>
              <button type="button" class="editPost w3-button w3-blue w3-round w3-small">
                <i class="fa fa-pencil"></i> Editar
              </button>
              <button type="button" class="delPost w3-button w3-red w3-round w3-small">
                <i class="fa fa-trash"></i> Eliminar
              </button>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

</c:when>
<c:otherwise>
  <div class="w3-panel w3-yellow w3-round">
    <p>No hi ha usuari logejat.</p>
  </div>
</c:otherwise>
</c:choose>
</div>

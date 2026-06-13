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
        var el = document.getElementById('tab-' + t);
        if (el) el.style.display = (t === name) ? '' : 'none';
    });
    document.querySelectorAll('.tab-btn').forEach(function(b) {
        b.classList.remove('w3-theme');
        b.classList.add('w3-light-grey');
    });
    var active = document.getElementById('btn-' + name);
    if (active) { active.classList.remove('w3-light-grey'); active.classList.add('w3-theme'); }
}

function filterByColla(colla) {
    document.querySelectorAll('.colla-card').forEach(function(card) {
        card.style.display = (!colla || card.getAttribute('data-colla') === colla) ? '' : 'none';
    });
    var creator  = document.getElementById('colla-creator');
    var label    = document.getElementById('collaCreatorLabel');
    var noSelect = document.getElementById('colla-no-select');
    if (!colla) {
        creator.style.display  = 'none';
        noSelect.style.display = '';
    } else {
        creator.style.display  = '';
        noSelect.style.display = 'none';
        if (label) label.textContent = colla;
        var target = document.getElementById('collaTarget');
        if (target) target.value = colla;
    }
}
</script>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover;
            background-attachment: fixed; background-position: center;
            min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-container w3-padding">

<div style="display:flex; align-items:flex-start; gap:10px">

    <%-- ══ LEFT: TAB BUTTONS STACKED ══════════════════════════════════════ --%>
    <div style="flex-shrink:0; width:72px; padding-top:2px; position:sticky; top:58px">
        <button id="btn-privat" class="tab-btn w3-button w3-block w3-theme w3-round"
                onclick="showTab('privat')"
                style="margin-bottom:4px; padding:10px 4px; text-align:center; line-height:1.3">
            <i class="fa fa-lock" style="font-size:16px"></i><br>
            <span style="font-size:10px">Privat</span>
        </button>
        <c:if test="${sessionScope.user.admin == 1 or not empty collaPosts or
                     (sessionScope.user.userType == 'CASTELLER' and not empty sessionScope.user.colla)}">
        <button id="btn-colla" class="tab-btn w3-button w3-block w3-light-grey w3-round"
                onclick="showTab('colla')"
                style="margin-bottom:4px; padding:10px 4px; text-align:center; line-height:1.3">
            <i class="fa fa-users" style="font-size:16px"></i><br>
            <span style="font-size:10px">Colla</span>
        </button>
        </c:if>
        <button id="btn-tots" class="tab-btn w3-button w3-block w3-light-grey w3-round"
                onclick="showTab('tots')"
                style="padding:10px 4px; text-align:center; line-height:1.3">
            <i class="fa fa-globe" style="font-size:16px"></i><br>
            <span style="font-size:10px">Tots</span>
        </button>
    </div>

    <%-- ══ RIGHT: TAB CONTENT ══════════════════════════════════════════════ --%>
    <div style="flex:1; min-width:0">

    <%-- ══════════════════════ TAB PRIVAT ══════════════════════ --%>
    <div id="tab-privat">

        <%-- STICKY CREATOR — top --%>
        <div class="w3-card w3-white w3-round post-creator"
             style="padding:7px 10px; position:sticky; top:58px; z-index:5;
                    box-shadow:0 2px 8px rgba(0,0,0,.15); margin-bottom:8px">
            <div style="display:flex; gap:6px; align-items:center">
                <textarea id="txt-privat" class="w3-input w3-border w3-round" rows="1"
                          placeholder="Escriu un post privat..."
                          style="flex:1; resize:none; line-height:1.5; padding:4px 8px; font-size:13px"></textarea>
                <label class="w3-button w3-light-grey w3-round" style="cursor:pointer; flex-shrink:0; padding:5px 9px; margin:0; font-size:13px">
                    <i class="fa fa-image"></i>
                    <input type="file" class="postImage" accept="image/*" style="display:none">
                </label>
                <button class="submitPost w3-button w3-theme w3-round" style="flex-shrink:0; white-space:nowrap; font-size:13px; padding:5px 10px"
                        data-visibility="1" data-textarea="txt-privat">
                    <i class="fa fa-send"></i> Publicar
                </button>
            </div>
            <span class="imageFileName w3-small w3-text-grey" style="font-style:italic; display:block; margin-top:2px"></span>
        </div>

        <c:choose>
            <c:when test="${empty privatPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity w3-small">No tens posts privats encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${privatPosts}">
                    <div id="${p.id}" class="w3-card w3-white w3-round w3-animate-opacity"
                         style="margin-bottom:5px; padding:7px 10px">
                        <%-- Header row --%>
                        <div style="display:flex; align-items:center; gap:7px">
                            <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                                 class="w3-circle" style="width:30px;height:30px;object-fit:cover;flex-shrink:0">
                            <div style="flex:1; min-width:0; line-height:1.2">
                                <strong style="font-size:13px">${p.uname}</strong>
                                <span class="w3-opacity" style="font-size:10px; margin-left:5px">${p.postDateTime}</span>
                            </div>
                            <%-- Actions on right --%>
                            <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                    data-liked="${p.likedByMe}" style="padding:2px 7px; font-size:12px">
                                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                            </button>
                            <c:if test="${p.uid == sessionScope.user.id}">
                                <button type="button" class="editPost w3-button w3-blue w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </button>
                            </c:if>
                            <c:if test="${p.uid == sessionScope.user.id or sessionScope.user.admin == 1}">
                                <button type="button" class="delPost w3-button w3-red w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </c:if>
                        </div>
                        <%-- Content --%>
                        <p class="post-text" style="margin:5px 0 0; font-size:13px; padding-left:37px">${p.content}</p>
                        <div class="post-edit-box" style="display:none; margin-top:6px; padding-left:37px">
                            <textarea class="w3-input w3-border w3-round" rows="2" style="font-size:13px"></textarea>
                            <div style="margin-top:4px">
                                <button type="button" class="saveEdit w3-button w3-theme w3-round w3-small"><i class="fa fa-save"></i> Guardar</button>
                                <button type="button" class="cancelEdit w3-button w3-light-grey w3-round w3-small"><i class="fa fa-times"></i> Cancel·lar</button>
                            </div>
                        </div>
                        <c:if test="${not empty p.imagePath}">
                            <img src="${p.imagePath}" alt="imatge"
                                 style="max-width:100%; border-radius:8px; margin:5px 0 0 37px; display:block">
                        </c:if>
                        <%-- Replies --%>
                        <div style="margin-top:5px; padding-top:4px; border-top:1px solid #f2f2f2; padding-left:37px">
                            <button type="button" class="toggleReplies w3-button w3-light-grey w3-round w3-small"
                                    data-postid="${p.id}" style="padding:2px 8px; font-size:12px">
                                <i class="fa fa-comments"></i> <span class="replyCountText">${p.replyCount}</span> respostes
                            </button>
                            <div class="replies-container" style="display:none; margin-top:6px; padding-left:10px; border-left:3px solid #e0e0e0"></div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- ══════════════════════ TAB COLLA ══════════════════════ --%>
    <div id="tab-colla" style="display:none">

        <%-- STICKY CREATOR colla — top --%>
        <div id="colla-creator" class="w3-card w3-white w3-round post-creator"
             style="padding:7px 10px; position:sticky; top:58px; z-index:5;
                    box-shadow:0 2px 8px rgba(0,0,0,.15); margin-bottom:8px;
                    ${sessionScope.user.admin == 1 ? 'display:none;' : ''}">
            <input type="hidden" id="collaTarget" name="collaTarget" value="${sessionScope.user.colla}">
            <div style="display:flex; gap:6px; align-items:center">
                <c:if test="${sessionScope.user.admin == 1}">
                <span class="w3-small w3-text-grey" style="flex-shrink:0; white-space:nowrap; font-size:12px">
                    <i class="fa fa-users"></i> <span id="collaCreatorLabel">${sessionScope.user.colla}</span>
                </span>
                </c:if>
                <textarea id="txt-colla" class="w3-input w3-border w3-round" rows="1"
                          placeholder="Escriu un missatge per a la colla..."
                          style="flex:1; resize:none; line-height:1.5; padding:4px 8px; font-size:13px"></textarea>
                <label class="w3-button w3-light-grey w3-round" style="cursor:pointer; flex-shrink:0; padding:5px 9px; margin:0; font-size:13px">
                    <i class="fa fa-image"></i>
                    <input type="file" class="postImage" accept="image/*" style="display:none">
                </label>
                <button class="submitPost w3-button w3-theme w3-round" style="flex-shrink:0; white-space:nowrap; font-size:13px; padding:5px 10px"
                        data-visibility="2" data-textarea="txt-colla">
                    <i class="fa fa-send"></i> Publicar
                </button>
            </div>
            <span class="imageFileName w3-small w3-text-grey" style="font-style:italic; display:block; margin-top:2px"></span>
        </div>

        <%-- Casteller: colla header --%>
        <c:if test="${sessionScope.user.admin != 1 and not empty sessionScope.user.colla}">
        <div class="w3-center w3-margin-bottom" style="padding:4px 0">
            <span class="w3-tag w3-theme w3-round-large" style="font-size:14px; padding:6px 18px; letter-spacing:0.3px">
                <i class="fa fa-users"></i> &nbsp;${sessionScope.user.colla}
            </span>
        </div>
        </c:if>

        <%-- Admin: dropdown (also sticky, below creator) --%>
        <c:if test="${sessionScope.user.admin == 1}">
        <div class="w3-card w3-white w3-round" style="padding:6px 10px; position:sticky; top:58px; z-index:5;
                    box-shadow:0 2px 8px rgba(0,0,0,.12); margin-bottom:8px">
            <div style="display:flex; align-items:center; gap:8px">
                <span class="w3-text-grey w3-small" style="flex-shrink:0; font-size:12px"><i class="fa fa-filter"></i> Colla:</span>
                <select id="collaSelector" class="w3-select w3-border w3-round" style="flex:1; font-size:13px; padding:3px 6px"
                        onchange="filterByColla(this.value)">
                    <option value="">— Totes —</option>
                    <c:forEach var="c" items="${colles}">
                        <option value="${c.name}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div id="colla-no-select" class="w3-panel w3-white w3-round w3-center w3-text-grey w3-small"
             style="padding:8px; margin-bottom:8px">
            <i class="fa fa-arrow-up"></i> Selecciona una colla per filtrar i publicar.
        </div>
        </c:if>

        <c:choose>
            <c:when test="${empty collaPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity w3-small">No hi ha posts de colla encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${collaPosts}">
                    <div id="${p.id}" class="colla-card w3-card w3-white w3-round w3-animate-opacity"
                         style="margin-bottom:5px; padding:7px 10px" data-colla="${p.collaName}">
                        <div style="display:flex; align-items:center; gap:7px">
                            <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                                 class="w3-circle" style="width:30px;height:30px;object-fit:cover;flex-shrink:0">
                            <div style="flex:1; min-width:0; line-height:1.2">
                                <strong style="font-size:13px">${p.uname}</strong>
                                <c:if test="${sessionScope.user.admin == 1}">
                                    <span class="w3-tag w3-theme w3-round" style="margin-left:5px; font-size:9px; padding:1px 5px">
                                        <i class="fa fa-users"></i> ${p.collaName}
                                    </span>
                                </c:if>
                                <span class="w3-opacity" style="font-size:10px; margin-left:5px">${p.postDateTime}</span>
                            </div>
                            <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                    data-liked="${p.likedByMe}" style="padding:2px 7px; font-size:12px">
                                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                            </button>
                            <c:if test="${p.uid == sessionScope.user.id}">
                                <button type="button" class="editPost w3-button w3-blue w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </button>
                            </c:if>
                            <c:if test="${p.uid == sessionScope.user.id or sessionScope.user.admin == 1}">
                                <button type="button" class="delPost w3-button w3-red w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </c:if>
                        </div>
                        <p class="post-text" style="margin:5px 0 0; font-size:13px; padding-left:37px">${p.content}</p>
                        <div class="post-edit-box" style="display:none; margin-top:6px; padding-left:37px">
                            <textarea class="w3-input w3-border w3-round" rows="2" style="font-size:13px"></textarea>
                            <div style="margin-top:4px">
                                <button type="button" class="saveEdit w3-button w3-theme w3-round w3-small"><i class="fa fa-save"></i> Guardar</button>
                                <button type="button" class="cancelEdit w3-button w3-light-grey w3-round w3-small"><i class="fa fa-times"></i> Cancel·lar</button>
                            </div>
                        </div>
                        <c:if test="${not empty p.imagePath}">
                            <img src="${p.imagePath}" alt="imatge"
                                 style="max-width:100%; border-radius:8px; margin:5px 0 0 37px; display:block">
                        </c:if>
                        <div style="margin-top:5px; padding-top:4px; border-top:1px solid #f2f2f2; padding-left:37px">
                            <button type="button" class="toggleReplies w3-button w3-light-grey w3-round w3-small"
                                    data-postid="${p.id}" style="padding:2px 8px; font-size:12px">
                                <i class="fa fa-comments"></i> <span class="replyCountText">${p.replyCount}</span> respostes
                            </button>
                            <div class="replies-container" style="display:none; margin-top:6px; padding-left:10px; border-left:3px solid #e0e0e0"></div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- ══════════════════════ TAB TOTS ══════════════════════ --%>
    <div id="tab-tots" style="display:none">

        <%-- STICKY CREATOR — top --%>
        <div class="w3-card w3-white w3-round post-creator"
             style="padding:7px 10px; position:sticky; top:58px; z-index:5;
                    box-shadow:0 2px 8px rgba(0,0,0,.15); margin-bottom:8px">
            <div style="display:flex; gap:6px; align-items:center">
                <textarea id="txt-tots" class="w3-input w3-border w3-round" rows="1"
                          placeholder="Escriu un post públic..."
                          style="flex:1; resize:none; line-height:1.5; padding:4px 8px; font-size:13px"></textarea>
                <label class="w3-button w3-light-grey w3-round" style="cursor:pointer; flex-shrink:0; padding:5px 9px; margin:0; font-size:13px">
                    <i class="fa fa-image"></i>
                    <input type="file" class="postImage" accept="image/*" style="display:none">
                </label>
                <button class="submitPost w3-button w3-theme w3-round" style="flex-shrink:0; white-space:nowrap; font-size:13px; padding:5px 10px"
                        data-visibility="0" data-textarea="txt-tots">
                    <i class="fa fa-send"></i> Publicar
                </button>
            </div>
            <span class="imageFileName w3-small w3-text-grey" style="font-style:italic; display:block; margin-top:2px"></span>
        </div>

        <c:choose>
            <c:when test="${empty totsPosts}">
                <p class="w3-panel w3-white w3-round w3-opacity w3-small">No hi ha posts públics encara.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${totsPosts}">
                    <div id="${p.id}" class="w3-card w3-white w3-round w3-animate-opacity"
                         style="margin-bottom:5px; padding:7px 10px">
                        <div style="display:flex; align-items:center; gap:7px">
                            <img src="${empty p.userPicture ? 'assets/default_avatar.png' : p.userPicture}"
                                 class="w3-circle" style="width:30px;height:30px;object-fit:cover;flex-shrink:0">
                            <div style="flex:1; min-width:0; line-height:1.2">
                                <strong style="font-size:13px">${p.uname}</strong>
                                <span class="w3-opacity" style="font-size:10px; margin-left:5px">${p.postDateTime}</span>
                            </div>
                            <button type="button" class="likeToggle w3-button w3-round w3-small ${p.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                                    data-liked="${p.likedByMe}" style="padding:2px 7px; font-size:12px">
                                <i class="fa fa-thumbs-up"></i> <span class="likeCount">${p.likeCount}</span>
                            </button>
                            <c:if test="${p.uid == sessionScope.user.id}">
                                <button type="button" class="editPost w3-button w3-blue w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Editar">
                                    <i class="fa fa-pencil"></i>
                                </button>
                            </c:if>
                            <c:if test="${p.uid == sessionScope.user.id or sessionScope.user.admin == 1}">
                                <button type="button" class="delPost w3-button w3-red w3-round w3-small"
                                        style="padding:2px 7px; font-size:12px" title="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </c:if>
                        </div>
                        <p class="post-text" style="margin:5px 0 0; font-size:13px; padding-left:37px">${p.content}</p>
                        <div class="post-edit-box" style="display:none; margin-top:6px; padding-left:37px">
                            <textarea class="w3-input w3-border w3-round" rows="2" style="font-size:13px"></textarea>
                            <div style="margin-top:4px">
                                <button type="button" class="saveEdit w3-button w3-theme w3-round w3-small"><i class="fa fa-save"></i> Guardar</button>
                                <button type="button" class="cancelEdit w3-button w3-light-grey w3-round w3-small"><i class="fa fa-times"></i> Cancel·lar</button>
                            </div>
                        </div>
                        <c:if test="${not empty p.imagePath}">
                            <img src="${p.imagePath}" alt="imatge"
                                 style="max-width:100%; border-radius:8px; margin:5px 0 0 37px; display:block">
                        </c:if>
                        <div style="margin-top:5px; padding-top:4px; border-top:1px solid #f2f2f2; padding-left:37px">
                            <button type="button" class="toggleReplies w3-button w3-light-grey w3-round w3-small"
                                    data-postid="${p.id}" style="padding:2px 8px; font-size:12px">
                                <i class="fa fa-comments"></i> <span class="replyCountText">${p.replyCount}</span> respostes
                            </button>
                            <div class="replies-container" style="display:none; margin-top:6px; padding-left:10px; border-left:3px solid #e0e0e0"></div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    </div><%-- end right content --%>
</div><%-- end flex row --%>

</div>
</div>

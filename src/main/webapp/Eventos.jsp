<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<script>
/* Star rating — namespaced so it can be rebound on each load */
(function() {
    var currentRating = 0;
    function paint() {
        $('.star').each(function(i) { $(this).toggleClass('active', i < currentRating); });
    }
    $(document).off('mouseover.star mouseout.star click.star')
        .on('mouseover.star', '.star', function() {
            var idx = $(this).index();
            $('.star').each(function(i) { $(this).toggleClass('hover', i <= idx); });
        })
        .on('mouseout.star', '.star', function() {
            $('.star').removeClass('hover'); paint();
        })
        .on('click.star', '.star', function() {
            currentRating = $(this).index() + 1; paint();
            $('#ratingText').text('Has valorat amb ' + currentRating + ' estrella(es)');
        });
    paint();
    $('#lcolumn').html('');
    $('#rcolumn').html('');
})();
</script>

<%-- ══ CREATE DIADA MODAL ══════════════════════════════════════════════════ --%>
<div id="createDiadaModal"
     style="display:none; position:fixed; inset:0; z-index:1000;
            background:rgba(0,0,0,.5); align-items:center; justify-content:center">
    <div class="w3-card w3-white w3-round-large" style="width:420px; max-width:95vw; padding:24px">
        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:16px">
            <h3 style="margin:0"><i class="fa fa-calendar-plus-o w3-text-theme"></i> Nova Diada</h3>
            <button type="button" id="closeDiadaModal"
                    class="w3-button w3-light-grey w3-round w3-small"><i class="fa fa-times"></i></button>
        </div>
        <form id="createDiadaForm">
            <label class="w3-text-grey w3-small"><b>Nom de la diada *</b></label>
            <input type="text" name="name" class="w3-input w3-border w3-round w3-margin-bottom"
                   placeholder="Ex: Diada de Sant Joan" required>

            <label class="w3-text-grey w3-small"><b>Data *</b></label>
            <input type="date" name="dia" class="w3-input w3-border w3-round w3-margin-bottom" required>

            <label class="w3-text-grey w3-small"><b>Lloc</b></label>
            <input type="text" name="location" class="w3-input w3-border w3-round w3-margin-bottom"
                   placeholder="Ex: Barcelona, Plaça de Sant Jaume">

            <label class="w3-text-grey w3-small"><b>Colles participants</b></label>
            <div id="collesList" style="margin-top:4px; border:1px solid #ccc; border-radius:4px; padding:8px">
                <c:forEach var="c" items="${colles}">
                <label style="display:flex; align-items:center; gap:8px; padding:3px 0; cursor:pointer">
                    <input type="checkbox" name="colles" value="${c.name}" class="w3-check">
                    <span style="font-size:13px">${c.name}</span>
                </label>
                </c:forEach>
            </div>

            <div style="display:flex; gap:8px; justify-content:flex-end; margin-top:20px">
                <button type="button" id="cancelDiadaBtn"
                        class="w3-button w3-light-grey w3-round">Cancel·lar</button>
                <button type="button" id="submitDiadaBtn"
                        class="w3-button w3-theme w3-round">
                    <i class="fa fa-check"></i> Crear diada
                </button>
            </div>
        </form>
    </div>
</div>

<%-- ══ MAIN LAYOUT ══════════════════════════════════════════════════════════ --%>
<div style="background-image: url('assets/concurs.jpeg'); background-size:cover;
            background-attachment:fixed; background-position:center;
            min-height:100vh; margin:-50px -9999px; padding:50px 9999px 24px;">
<div class="w3-container w3-padding">
<div style="display:flex; gap:14px; align-items:flex-start; margin-top:10px">

    <%-- ══ LEFT: DIADES LIST ═══════════════════════════════════════════════ --%>
    <div style="flex-shrink:0; width:220px">
        <div class="w3-card w3-white w3-round" style="overflow:hidden">
            <div class="w3-theme w3-padding" style="padding:10px 14px">
                <strong><i class="fa fa-calendar"></i> Diades</strong>
            </div>
            <c:choose>
                <c:when test="${empty diades}">
                    <p class="w3-small w3-text-grey" style="padding:10px 14px; margin:0">
                        No hi ha diades registrades.
                    </p>
                </c:when>
                <c:otherwise>
                    <ul class="w3-ul" style="margin:0">
                        <c:forEach var="d" items="${diades}">
                            <li style="padding:0">
                                <a class="menu w3-button w3-block w3-left-align"
                                   href="Eventos?diadaId=${d.id}"
                                   style="padding:9px 14px; font-size:13px;
                                          ${not empty selected and selected.id == d.id ? 'background:var(--w3-theme); color:#fff;' : ''}">
                                    <strong style="display:block">${d.name}</strong>
                                    <span style="font-size:11px; opacity:.8">
                                        <i class="fa fa-calendar-o"></i> ${d.dia}
                                    </span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>

            <%-- Admin: yellow create button --%>
            <c:if test="${sessionScope.user.admin == 1}">
            <div style="padding:10px 14px; border-top:1px solid #eee">
                <button id="openCreateDiadaBtn"
                        class="w3-button w3-block w3-round"
                        style="background:#f5c518; color:#333; font-weight:bold">
                    <i class="fa fa-plus"></i> Nova diada
                </button>
            </div>
            </c:if>
        </div>
    </div>

    <%-- ══ RIGHT: DIADA DETAIL ══════════════════════════════════════════════ --%>
    <div style="flex:1; min-width:0">
        <div class="w3-card w3-white w3-round w3-padding">
            <c:choose>
                <c:when test="${not empty selected}">
                    <%-- Header --%>
                    <div style="display:flex; align-items:flex-start; justify-content:space-between; margin-bottom:12px">
                        <div>
                            <h2 style="margin:0 0 4px" class="w3-text-theme">${selected.name}</h2>
                            <span class="w3-opacity w3-small">
                                <i class="fa fa-calendar-o"></i> ${selected.dia}
                                &nbsp;·&nbsp;
                                <i class="fa fa-map-marker"></i> ${selected.location}
                            </span>
                        </div>
                        <c:if test="${sessionScope.user.admin == 1}">
                            <button type="button" class="deleteDiada w3-button w3-red w3-round w3-small"
                                    data-id="${selected.id}" data-name="${selected.name}"
                                    style="flex-shrink:0; margin-left:10px">
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </c:if>
                    </div>

                    <%-- Colles participants --%>
                    <c:if test="${not empty selected.colla}">
                    <div style="margin-bottom:14px">
                        <strong class="w3-small w3-text-grey">COLLES PARTICIPANTS</strong><br>
                        <c:forEach var="c" items="${selected.colles}">
                            <span class="w3-tag w3-theme w3-round-large"
                                  style="margin:3px 3px 0 0; font-size:12px; padding:3px 10px">
                                <i class="fa fa-users"></i> ${c}
                            </span>
                        </c:forEach>
                    </div>
                    </c:if>

                    <hr>

                    <%-- Star rating --%>
                    <div class="w3-margin-top">
                        <strong>Valora aquesta diada</strong>
                        <div class="rating" style="margin-top:6px">
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                        </div>
                        <p id="ratingText" class="w3-small w3-text-grey" style="margin-top:4px"></p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="w3-center" style="padding:40px 20px; color:#999">
                        <i class="fa fa-calendar fa-3x" style="margin-bottom:16px; display:block"></i>
                        <p>Selecciona una diada de la llista per veure els detalls.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
</div>
</div>

<style>
.star { font-size: 28px; color: #ccc; cursor: pointer; transition: color .15s; }
.star.hover, .star.active { color: #f5c518; }
</style>

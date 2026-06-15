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
            currentRating = $(this).index() + 1;
            paint();
            $('#ratingText').text('Has seleccionat ' + currentRating + ' estrella' + (currentRating > 1 ? 'es' : ''));
            $('#ratingValue').val(currentRating);
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
                    <div style="display:flex; align-items:flex-start; justify-content:space-between; margin-bottom:4px">
                        <div style="flex:1; min-width:0">
                            <div style="display:flex; align-items:center; gap:10px; flex-wrap:wrap">
                                <h2 style="margin:0" class="w3-text-theme">${selected.name}</h2>
                                <c:if test="${not empty avgRating}">
                                    <span style="background:#f5c518; color:#333; font-weight:bold;
                                                 padding:2px 10px; border-radius:20px; font-size:14px;
                                                 white-space:nowrap">
                                        ★ ${avgRating}
                                    </span>
                                </c:if>
                            </div>
                            <span class="w3-opacity w3-small" style="margin-top:4px; display:block">
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
                    <div style="margin:10px 0 14px">
                        <strong class="w3-small w3-text-grey">COLLES PARTICIPANTS</strong><br>
                        <c:forEach var="c" items="${selected.colles}">
                            <span class="w3-tag w3-theme w3-round-large"
                                  style="margin:3px 3px 0 0; font-size:12px; padding:3px 10px">
                                <i class="fa fa-users"></i> ${c}
                            </span>
                        </c:forEach>
                    </div>
                    </c:if>

                    <hr style="margin:14px 0">

                    <%-- ── Rating form (only if user can review and hasn't yet) ── --%>
                    <c:if test="${canReview and not hasReviewed}">
                    <div style="margin-bottom:16px; padding:12px; background:#f9f9f9; border-radius:6px">
                        <strong style="font-size:14px">Valora aquesta diada</strong>
                        <div class="rating" style="margin-top:6px">
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                            <span class="star">★</span>
                        </div>
                        <input type="hidden" id="ratingValue" value="0">
                        <p id="ratingText" class="w3-small w3-text-grey" style="margin:4px 0 8px"></p>
                        <button type="button" class="submitRating w3-button w3-theme w3-round w3-small"
                                data-diada="${selected.id}">
                            <i class="fa fa-star"></i> Enviar valoració
                        </button>
                    </div>
                    </c:if>

                    <c:if test="${canReview and hasReviewed}">
                    <div style="margin-bottom:16px; padding:10px 14px; background:#e8f5e9;
                                border-radius:6px; font-size:13px; color:#2e7d32">
                        <i class="fa fa-check-circle"></i> Ja has valorat aquesta diada.
                    </div>
                    </c:if>

                    <%-- ── Reviews list ── --%>
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <strong class="w3-small w3-text-grey">VALORACIONS (${reviews.size()})</strong>
                            <div style="margin-top:8px">
                                <c:forEach var="r" items="${reviews}">
                                <div style="display:flex; align-items:flex-start; gap:10px;
                                            padding:8px 0; border-bottom:1px solid #f0f0f0">
                                    <div style="width:32px; height:32px; border-radius:50%;
                                                background:var(--w3-theme); color:#fff;
                                                display:flex; align-items:center; justify-content:center;
                                                font-size:13px; font-weight:bold; flex-shrink:0">
                                        ${r.uname.substring(0,1).toUpperCase()}
                                    </div>
                                    <div style="flex:1; min-width:0">
                                        <div style="display:flex; align-items:center; justify-content:space-between">
                                            <span style="font-weight:bold; font-size:13px">${r.uname}</span>
                                            <span style="font-size:11px; color:#aaa">${r.createdDate}</span>
                                        </div>
                                        <div style="color:#f5c518; font-size:16px; line-height:1.3">
                                            <c:forEach begin="1" end="${r.value}" var="s">★</c:forEach><c:forEach begin="${r.value + 1}" end="5" var="s"><span style="color:#ddd">★</span></c:forEach>
                                        </div>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="w3-small w3-text-grey" style="margin:0">
                                Encara no hi ha valoracions per aquesta diada.
                            </p>
                        </c:otherwise>
                    </c:choose>

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

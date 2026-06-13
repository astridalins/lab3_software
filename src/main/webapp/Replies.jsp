<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:if test="${empty replies}">
    <p class="w3-small w3-text-grey" style="margin:4px 0 10px; font-style:italic">
        Sigues el primer en respondre!
    </p>
</c:if>

<c:forEach var="r" items="${replies}">
    <div id="${r.id}" class="w3-card w3-pale-blue w3-round w3-padding" style="margin-bottom:6px">
        <img src="${empty r.userPicture ? 'assets/default_avatar.png' : r.userPicture}"
             class="w3-left w3-circle w3-margin-right"
             style="width:32px;height:32px;object-fit:cover">
        <span class="w3-right w3-opacity" style="font-size:11px">${r.postDateTime}</span>
        <strong style="font-size:13px">${r.uname}</strong><br>
        <hr class="w3-clear" style="margin:4px 0">
        <p style="margin:4px 0; font-size:13px">${r.content}</p>
        <c:if test="${not empty r.imagePath}">
            <img src="${r.imagePath}" alt="imatge"
                 style="max-width:100%; border-radius:8px; margin:4px 0; display:block">
        </c:if>
        <button type="button"
                class="likeToggle w3-button w3-round w3-small ${r.likedByMe == 1 ? 'w3-blue' : 'w3-light-grey'}"
                data-liked="${r.likedByMe}" style="padding:2px 8px; font-size:12px">
            <i class="fa fa-thumbs-up"></i> <span class="likeCount">${r.likeCount}</span>
        </button>
        <c:if test="${not empty sessionScope.user and
                     (r.uid == sessionScope.user.id or sessionScope.user.admin == 1)}">
            <button type="button" class="delPost w3-button w3-red w3-round w3-small"
                    style="padding:2px 8px; font-size:12px">
                <i class="fa fa-trash"></i>
            </button>
        </c:if>
    </div>
</c:forEach>

<%-- Reply composer (only for logged-in users) --%>
<c:if test="${not empty sessionScope.user}">
<div class="reply-composer" style="margin-top:10px; display:flex; gap:8px; align-items:flex-start">
    <img src="${empty sessionScope.user.picture ? 'assets/default_avatar.png' : sessionScope.user.picture}"
         class="w3-circle" style="width:32px;height:32px;object-fit:cover;flex-shrink:0;margin-top:2px">
    <div style="flex:1">
        <input type="hidden" class="replyParentId" value="${parentPostId}">
        <textarea class="replyText w3-input w3-border w3-round" rows="2"
                  placeholder="Escriu una resposta..."></textarea>
        <button type="button" class="submitReply w3-button w3-theme w3-round w3-small"
                style="margin-top:6px">
            <i class="fa fa-reply"></i> Respondre
        </button>
    </div>
</div>
</c:if>

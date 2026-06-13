<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="user" value="${sessionScope.user}" />

<div class="w3-container w3-padding">

    <h2 class="w3-text-theme">Gestió d'usuaris</h2>

    <table class="w3-table w3-striped w3-bordered w3-hoverable">
        <tr class="w3-theme">
            <th>Foto</th>
            <th>ID</th>
            <th>Nom</th>
            <th>Username</th>
            <th>Email</th>
            <th>Tipus</th>
            <th>Acció</th>
        </tr>

        <c:forEach var="u" items="${users}">
            <tr id="user-row-${u.id}">
                <td>
                    <img src="${empty u.picture ? 'assets/default_avatar.png' : u.picture}"
                         style="width:40px;height:40px;border-radius:50%;object-fit:cover">
                </td>
                <td>${u.id}</td>
                <td>${u.name}</td>
                <td>@${u.username}</td>
                <td>${u.email}</td>
                <td>
                    <c:choose>
                        <c:when test="${u.admin == 1}">
                            <span class="w3-tag w3-dark-grey w3-round w3-small">Admin</span>
                        </c:when>
                        <c:otherwise>${u.userType}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${u.id == sessionScope.user.id}">
                            <span class="w3-text-grey w3-small">(tu)</span>
                        </c:when>
                        <c:otherwise>
                            <button type="button"
                                    class="deleteUser w3-button w3-red w3-round w3-small"
                                    data-uid="${u.id}" data-name="${u.name}">
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>


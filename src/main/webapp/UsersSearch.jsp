<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="user" value="${sessionScope.user}" />

<div class="w3-container w3-padding">

    <h2 class="w3-text-theme">Usuaris</h2>

    <!-- ================= ADMIN VIEW ================= -->
    <c:if test="${user != null && user.admin == 1}">

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

                <tr>
                    <td>
                        <img src="${u.picture}" style="width:40px;height:40px;border-radius:50%">
                    </td>
                    <td>${u.id}</td>
                    <td>${u.name}</td>
                    <td>${u.username}</td>
                    <td>${u.email}</td>
                    <td>${u.userType}</td>
                    <td>
                    <a href="javascript:void(0)"
                    class="w3-button w3-red w3-small"
                    onclick="showDeleteMessage()">
                        🗑
                    </a>
                    </td>
                </tr>

            </c:forEach>

        </table>

    </c:if>

    <!-- ================= NORMAL USER VIEW ================= -->
    <c:if test="${user == null || user.admin == 0}">

        <div class="w3-row-padding">

            <c:forEach var="u" items="${users}">

                <div class="w3-col m3 w3-margin-bottom">

                    <div class="w3-card w3-white w3-padding w3-center">

                        <img src="${u.picture}"
                             style="width:80px;height:80px;border-radius:50%">

                        <h4>${u.name}</h4>

                        <p>@${u.username}</p>

                        <p>${u.userType}</p>

                        <button class="w3-button w3-theme w3-round">
                            ➕ Seguir
                        </button>

                    </div>

                </div>

            </c:forEach>

        </div>

    </c:if>

</div>

<script>
function showDeleteMessage() {
    alert("⚠️ Aquesta funcionalitat encara no està implementada.\n\nCom a admin podràs eliminar usuaris en el futur.");
}
</script>
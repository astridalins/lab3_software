<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="user" value="${sessionScope.user}" />

<div class="w3-container w3-padding">

    <h2 class="w3-text-theme">Usuaris</h2>

    <!-- ================= NORMAL USER VIEW ================= -->

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

</div>


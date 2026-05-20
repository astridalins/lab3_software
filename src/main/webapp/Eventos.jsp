<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@ page import="epaw.lab3.model.User" %>

<div style="background-image: url('assets/concurs.jpeg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-row-padding" style="margin-top:20px;">


<!-- nateja -->
   <script>
    $('#lcolumn').html('');
    $('#rcolumn').html('');
  </script>

    <!-- ESQUERRA -->
    <div class="w3-col m3">

        <div class="w3-card w3-white w3-padding">

            <h3 class="w3-text-theme">
                Diades
            </h3>

            <ul class="w3-ul">

                <li>
                    <a class="menu w3-button w3-block w3-left-align"
                       href="Eventos?diada=SantJordi">

                        Diada Sant Jordi
                    </a>
                </li>

                <li>
                    <a class="menu w3-button w3-block w3-left-align"
                       href="Eventos?diada=Mercè">

                        Diada Mercè
                    </a>
                </li>

                <li>
                    <a class="menu w3-button w3-block w3-left-align"
                       href="Eventos?diada=Valls">

                        Diada Valls
                    </a>
                </li>

            </ul>

        </div>

    </div>

    <!-- DRETA -->
    <div class="w3-col m9">

        <div class="w3-card w3-white w3-padding"
             style="height:80vh;">

            <h2 class="w3-text-theme">
                ${diada}
            </h2>

            <c:choose>

                <c:when test="${diada == 'SantJordi'}">

                    <p>Informació de Sant Jordi...</p>

                    <!-- BOTÓ VALORACIÓ -->
                    <div class="w3-margin-top">

                        <button class="w3-button w3-theme" onclick="showRatingInfo()">
                            Valorar diada
                        </button>

                        <!-- ESTRELLES -->
                        <div class="rating" onmouseleave="resetStars()">

                            <span class="star" data-value="1" onclick="setRating(1)">★</span>
                            <span class="star" data-value="2" onclick="setRating(2)">★</span>
                            <span class="star" data-value="3" onclick="setRating(3)">★</span>
                            <span class="star" data-value="4" onclick="setRating(4)">★</span>
                            <span class="star" data-value="5" onclick="setRating(5)">★</span>

                        </div>

                        <p id="ratingText"></p>

                    </div>

                </c:when>

                <c:when test="${diada == 'Mercè'}">
                    <p>Informació de la Mercè...</p>

                    <!-- BOTÓ VALORACIÓ -->
                    <div class="w3-margin-top">

                        <button class="w3-button w3-theme" onclick="showRatingInfo()">
                            Valorar diada
                        </button>

                        <!-- ESTRELLES -->
                        <div class="rating" onmouseleave="resetStars()">

                            <span class="star" data-value="1" onclick="setRating(1)">★</span>
                            <span class="star" data-value="2" onclick="setRating(2)">★</span>
                            <span class="star" data-value="3" onclick="setRating(3)">★</span>
                            <span class="star" data-value="4" onclick="setRating(4)">★</span>
                            <span class="star" data-value="5" onclick="setRating(5)">★</span>

                        </div>

                        <p id="ratingText"></p>

                    </div>

                </c:when>

                <c:when test="${diada == 'Valls'}">
                    <p>Informació de Valls...</p>

                    <!-- BOTÓ VALORACIÓ -->
                    <div class="w3-margin-top">

                        <button class="w3-button w3-theme" onclick="showRatingInfo()">
                            Valorar diada
                        </button>

                        <!-- ESTRELLES -->
                        <div class="rating" onmouseleave="resetStars()">

                            <span class="star" data-value="1" onclick="setRating(1)">★</span>
                            <span class="star" data-value="2" onclick="setRating(2)">★</span>
                            <span class="star" data-value="3" onclick="setRating(3)">★</span>
                            <span class="star" data-value="4" onclick="setRating(4)">★</span>
                            <span class="star" data-value="5" onclick="setRating(5)">★</span>

                        </div>

                        <p id="ratingText"></p>

                    </div>

                </c:when>

                <c:otherwise>
                    <p>Selecciona una diada.</p>
                </c:otherwise>

            </c:choose>

            <c:if test="${sessionScope.user != null && sessionScope.user.admin == 1}">
                <button id="createPostBtn"
                        class="w3-button w3-theme w3-circle w3-xxlarge"
                        onclick="createPost()"
                        style="position: fixed; bottom: 30px; right: 30px;">
                    +
                </button>
            </c:if>
        </div>

    </div>
    
    <%-- ESTRELLES  --%>

        <script>

        let currentRating = 0;

        function initRating() {

            const stars = document.querySelectorAll(".star");

            stars.forEach((star, index) => {

                star.addEventListener("mouseover", () => {
                    highlight(index);
                });

                star.addEventListener("click", () => {
                    setRating(index + 1);
                });
            });

            const box = document.querySelector(".rating");
            if (box) {
                box.addEventListener("mouseleave", resetHover);
            }
        }

        function highlight(index) {

            const stars = document.querySelectorAll(".star");

            stars.forEach((star, i) => {
                if (i <= index) {
                    star.classList.add("hover");
                } else {
                    star.classList.remove("hover");
                }
            });
        }

        function resetHover() {

            const stars = document.querySelectorAll(".star");

            stars.forEach(star => {
                star.classList.remove("hover");
            });

            paintRating();
        }

        function createPost() {
            alert("Encara no està implementat 😄\nAquí podràs crear nous Eventos.");
        }

        function setRating(value) {
            currentRating = value;
            paintRating();

            document.getElementById("ratingText").innerText =
                "Has valorat amb " + value + " estrella(es)";
        }

        function paintRating() {

            const stars = document.querySelectorAll(".star");

            stars.forEach((star, i) => {
                star.classList.toggle("active", i < currentRating);
            });
        }

        /* 💬 MISSATGE BOTÓ */
        function showReviewMessage() {
            alert("Aquí podràs escriure les teves ressenyes i valorar la diada ⭐\n(encara no implementat)");
        }

        /* 🔥 IMPORTANT SPA */
        initRating();

        </script>
</div>
</div>
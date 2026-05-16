<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

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
                </c:when>

                <c:when test="${diada == 'Mercè'}">
                    <p>Informació de la Mercè...</p>
                </c:when>

                <c:when test="${diada == 'Valls'}">
                    <p>Informació de Valls...</p>
                </c:when>

                <c:otherwise>
                    <p>Selecciona una diada.</p>
                </c:otherwise>

            </c:choose>

        </div>

    </div>

</div>
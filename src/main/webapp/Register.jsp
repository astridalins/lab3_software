<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<div style="background-image: url('assets/manos2.jpg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div>

<form id="registerForm" action="Register" method="POST" enctype="multipart/form-data">

    <div>
        <label for="name" class="w3-text-theme">Name</label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="name" name="name" required minlength="5" maxlength="20"
            value="${user.name}" title="Name must be between 5 and 20 characters." />
    </div>

    <div>
        <label for="password" class="w3-text-theme">Password</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="password" name="password" required
            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$" value="${user.password}"
            title="Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*)." />
    </div>

    <div>
        <label for="confirmPassword" class="w3-text-theme">Repeat password</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="confirmPassword"
            name="confirmPassword" required value="${user.password}"
            title="Passwords must match" />
    </div>

    <div>
        <label for="picture" class="w3-text-theme">Profile Picture</label>
        <input class="w3-input w3-border w3-light-grey" type="file" id="picture" name="picture" accept="image/*" />
    </div>
    <div>
        <label class="w3-text-grey">Username</label>
        <input class="w3-input w3-border" 
            type="text" 
            id="username" 
            name="username"
            required
            minlength="4"
            value="${user.username}"
            title="Mínim 4 caràcters, ha de ser únic." />
    </div>

    <div>
        <label class="w3-text-grey">Localitat</label>
        <input class="w3-input w3-border"
            type="text"
            id="location"
            name="location"
            required
            pattern="[a-zA-ZÀ-ÿ\s]+"
            value="${user.location}"
            title="Només lletres, sense números ni símbols." />
    </div>

    <div>
        <label class="w3-text-grey">Tipus d'usuari</label>
        <select class="w3-select w3-border" id="userType" name="userType" required>
            <option value="">Selecciona un tipus...</option>
            <option value="casteller" ${user.userType == 'casteller' ? 'selected' : ''}>Casteller</option>
            <option value="espectador" ${user.userType == 'espectador' ? 'selected' : ''}>Espectador</option>
        </select>
    </div>

    <div id="posicionsContainer" style="display:none">
        <p>
            <label class="w3-text-grey">Posicions típiques</label>
            <select class="w3-select w3-border" id="posicions" name="posicions" multiple size="8">
                <option value="baixos"      ${fn:contains(user.posicions, 'baixos')      ? 'selected' : ''}>Baixos</option>
                <option value="contraforts" ${fn:contains(user.posicions, 'contraforts') ? 'selected' : ''}>Contraforts</option>
                <option value="agulles"     ${fn:contains(user.posicions, 'agulles')     ? 'selected' : ''}>Agulles</option>
                <option value="laterals"    ${fn:contains(user.posicions, 'laterals')    ? 'selected' : ''}>Laterals</option>
                <option value="ventalls"    ${fn:contains(user.posicions, 'ventalls')    ? 'selected' : ''}>Ventalls</option>
                <option value="segons"      ${fn:contains(user.posicions, 'segons')      ? 'selected' : ''}>Segons</option>
                <option value="terços"      ${fn:contains(user.posicions, 'terços')      ? 'selected' : ''}>Terços</option>
                <option value="quarts"      ${fn:contains(user.posicions, 'quarts')      ? 'selected' : ''}>Quarts</option>
                <option value="quints"      ${fn:contains(user.posicions, 'quints')      ? 'selected' : ''}>Quints</option>
                <option value="sisens"      ${fn:contains(user.posicions, 'sisens')      ? 'selected' : ''}>Sisens</option>
                <option value="setens"      ${fn:contains(user.posicions, 'setens')      ? 'selected' : ''}>Setens</option>
                <option value="dosos"       ${fn:contains(user.posicions, 'dosos')       ? 'selected' : ''}>Dosos</option>
                <option value="acotxador"   ${fn:contains(user.posicions, 'acotxador')   ? 'selected' : ''}>Acotxador</option>
                <option value="enxaneta"    ${fn:contains(user.posicions, 'enxaneta')    ? 'selected' : ''}>Enxaneta</option>
                <option value="folre"       ${fn:contains(user.posicions, 'folre')       ? 'selected' : ''}>Folre</option>
                <option value="manilles"    ${fn:contains(user.posicions, 'manilles')    ? 'selected' : ''}>Manilles</option>
            </select>
        </p>
    </div>

    <div id="collaContainer" style="display:none">
        <label class="w3-text-grey">Colla castellera</label>
        <input class="w3-input w3-border"
            list="collesList"
            name="colla"
            id="colla"
            value="${user.colla}"
            placeholder="Escriu o selecciona una colla" />
        <datalist id="collesList">
            <c:forEach var="c" items="${colles}">
                <option value="${c.name}">
            </c:forEach>
        </datalist>
    </div>

    <div>
        <label class="w3-text-grey">Email</label>
        <input class="w3-input w3-border"
            type="email"
            id="email"
            name="email"
            required
            value="${user.email}"
            title="Introdueix un email vàlid." />
    </div>
    //
    <button type="submit" class="w3-button w3-theme w3-section">Submit Registration</button>

</form>

</div>
</div>

<script>
	App.Errors = {
		  <c:forEach var="error" items="${errors}">
		    "${error.key}": "${error.value}",
		  </c:forEach>
	};
	App.initRegisterValidation(App.Errors);
</script>

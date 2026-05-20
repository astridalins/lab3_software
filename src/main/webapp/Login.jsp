<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div style="background-image: url('assets/castell_lila.jpg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div>

<form id="loginForm" action="Login" method="POST">

	<div>
		<label for="username" class="w3-text-theme">Username:</label> 
		<input type="text" class="w3-input w3-border w3-light-grey" 
		    id="username" name="username" required minlength="5" maxlength="20" value="${user.username}"
			title="Username must be between 5 and 20 characters." />
	</div>
	<div>
		<label for="password" class="w3-text-theme">Contrasenya:</label> 
		<input type="password" class="w3-input w3-border w3-light-grey" 
			id="password" name="password" required
			pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$"
			value="${user.password}"
			title="Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*)." />
	</div>

	<button type="submit" class="w3-button w3-theme w3-section"> Log in</button>

</form>


<script>
	App.Errors = {
	  <c:forEach var="error" items="${errors}">
	    "${error.key}": "${error.value}",
	  </c:forEach>
	};
	App.initLoginValidation(App.Errors);
</script>

</div>
</div>
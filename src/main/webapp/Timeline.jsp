<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<script type="text/javascript">
$(document).ready(function(){
    $('#lcolumn').html('');
    $('#rcolumn').html('');
    $('#iterator').load('Posts');
});
</script>

<div class="w3-container w3-card w3-round w3-white w3-section">
    <h6 class="w3-opacity"> ${user.name}, what's happening? </h6>
    <p id="postContent" contenteditable="true" class="w3-border w3-padding"> </p>
    <button id="addPost" type="button" class="w3-button w3-theme w3-section">
        <i class="fa fa-pencil"></i> &nbsp;Publicar
    </button>
</div>

<div id="iterator">
    <!-- Posts will be loaded here -->
</div>

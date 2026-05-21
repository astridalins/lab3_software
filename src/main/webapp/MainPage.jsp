<%-- solució dels accents --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div style="background-image: url('assets/castellers_colors.jpg'); background-size: cover; background-attachment: fixed; background-position: center; min-height: 100vh; margin: -50px -9999px; padding: 50px 9999px 24px;">
<div class="w3-col m12">

    <div class="w3-card w3-white w3-padding main-feed">

        <h3 class="w3-text-theme">Posts</h3>

        <!-- BOTONS FILTRE -->
        <div class="w3-center w3-margin-bottom">

            <button class="w3-button w3-theme w3-round" onclick="showPosts('public')">
                Públic
            </button>

            <button class="w3-button w3-dark-grey w3-round" onclick="showPosts('private')">
                Privat
            </button>

            <button class="w3-button w3-red w3-round" onclick="showPosts('colla')">
                Colla
            </button>

            <button class="w3-button w3-light-grey w3-round" onclick="showPosts('all')">
                Tots
            </button>

        </div>

        <!-- MISSATGE -->
        <div id="postsMessage"
             class="w3-panel w3-pale-blue w3-leftbar w3-border-blue w3-margin-bottom"
             style="display:none;">
        </div>

        <!-- POSTS -->

        <div class="post-card w3-card w3-margin w3-padding" data-type="public">
            <h4>Castell carregat a Vilafranca</h4>
            <p>Avui la colla ha aconseguit carregar un 3de9 amb folre! Gran actuació 💪</p>
        </div>

        <div class="post-card w3-card w3-margin w3-padding" data-type="colla">
            <h4>Assaig especial</h4>
            <p>Dijous fem assaig intensiu per preparar la diada de la Mercè.</p>
        </div>

        <div class="post-card w3-card w3-margin w3-padding" data-type="private">
            <h4>Objectiu temporada</h4>
            <p>Vols fer un 4de9 net abans de final d’any? Aquest és l’objectiu de la colla.</p>
        </div>

        <div class="post-card w3-card w3-margin w3-padding" data-type="public">
            <h4>Fotos de l’última actuació</h4>
            <p>Ja estan penjades les fotos al sistema. Podeu veure-les al perfil.</p>
        </div>

        <div class="post-card w3-card w3-margin w3-padding" data-type="colla">
            <h4>Reunió tècnica</h4>
            <p>Demà reunió amb els caps de colla per analitzar la progressió.</p>
        </div>

    </div>

</div>

<!-- BOTÓ FLOTANT + -->
<button id="createPostBtn"
        class="w3-button w3-theme w3-circle w3-xxlarge"
        onclick="createPost()">
    +
</button>

<!-- JAVASCRIPT -->
<script>

function showPosts(type) {

    const posts = document.querySelectorAll(".post-card");

    posts.forEach(post => {

        const postType = post.getAttribute("data-type");

        if (type === "all") {
            post.style.display = "block";
        }
        else if (postType === type) {
            post.style.display = "block";
        }
        else {
            post.style.display = "none";
        }
    });

    const msg = document.getElementById("postsMessage");
    msg.style.display = "block";

    if (type === "public") {
        msg.innerHTML = "Mostrant posts públics";
    }
    else if (type === "private") {
        msg.innerHTML = "Mostrant posts privats (només visibles per tu)";
    }
    else if (type === "colla") {
        msg.innerHTML = "Mostrant posts de la colla";
    }
    else {
        msg.innerHTML = "Mostrant tots els posts";
    }
}

function createPost() {
    alert("Encara no està implementat 😄\nAquí podràs crear nous posts amb AJAX.");
}

</script>
</div>

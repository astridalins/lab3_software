package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.CollaService;
import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Profile")
public class Profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user != null) {
            PostService svc = PostService.getInstance();
            request.setAttribute("ownPublicPosts", svc.getPublicPostsByUser(user.getId(), user.getId()));
            request.setAttribute("ownPrivatPosts", svc.getPrivatPostsByUser(user.getId(), user.getId()));
            request.setAttribute("ownReplies",     svc.getRepliesByUser(user.getId(), user.getId()));
        }
        request.setAttribute("colles", CollaService.getInstance().getTotes());
        request.getRequestDispatcher("Profile.jsp").forward(request, response); //connects to the profile page JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
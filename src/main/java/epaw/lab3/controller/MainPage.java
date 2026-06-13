package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.CollaService;
import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/MainPage")
public class MainPage extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null) {
            PostService svc = PostService.getInstance();
            request.setAttribute("totsPosts", svc.getTotsPosts(user.getId()));

            if (user.getAdmin() == 1) {
                // Admin sees all posts from every user
                request.setAttribute("privatPosts", svc.getAllPrivatPosts(user.getId()));
                request.setAttribute("collaPosts",  svc.getAllCollaPosts(user.getId()));
            } else {
                request.setAttribute("privatPosts", svc.getPrivatPosts(user.getId()));
                // Colla forum only for CASTELLER users who belong to a colla
                if ("CASTELLER".equals(user.getUserType()) &&
                        user.getColla() != null && !user.getColla().isBlank()) {
                    request.setAttribute("collaPosts",
                        svc.getCollaPosts(user.getColla(), user.getId()));
                }
            }
        }

        request.setAttribute("colles", CollaService.getInstance().getTotes());
        request.getRequestDispatcher("MainPage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

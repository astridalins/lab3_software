package epaw.lab3.controller;

import epaw.lab3.model.User;
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
            request.setAttribute("privatPosts", svc.getPrivatPosts(user.getId()));
            request.setAttribute("totsPosts",   svc.getTotsPosts(user.getId()));

            // Colla forum only for CASTELLER users who belong to a colla
            if ("CASTELLER".equals(user.getUserType()) &&
                    user.getColla() != null && !user.getColla().isBlank()) {
                request.setAttribute("collaPosts",
                    svc.getCollaPosts(user.getColla(), user.getId()));
            }
        }

        request.getRequestDispatcher("MainPage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

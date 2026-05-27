package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/UsersSearch")
public class UsersSearch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser != null) {
            UserService svc = UserService.getInstance();
            List<User> followed    = svc.getFollowedUsers(currentUser.getId(), 0, 100);
            List<User> notFollowed = svc.getNotFollowedUsers(currentUser.getId(), 0, 100);
            request.setAttribute("followedUsers",    followed);
            request.setAttribute("notFollowedUsers", notFollowed);
        }

        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("UsersSearch.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

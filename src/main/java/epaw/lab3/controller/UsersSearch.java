package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.repository.UserRepository;

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

        // Agafar usuari logat de la sessió
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Passar usuari actual al JSP
        request.setAttribute("currentUser", currentUser);

        // Agafar tots els usuaris de la BD
        List<User> users = UserRepository.getInstance().findAll();

        request.setAttribute("users", users);

        // Redirigir a la vista
        request.getRequestDispatcher("UsersSearch.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
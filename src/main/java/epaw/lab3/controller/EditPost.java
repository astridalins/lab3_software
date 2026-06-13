package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditPost")
public class EditPost extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) { response.getWriter().write("no-auth"); return; }

        String idParam = request.getParameter("id");
        String content = request.getParameter("content");
        if (idParam == null || content == null || content.trim().isEmpty()) {
            response.getWriter().write("empty");
            return;
        }

        try {
            int postId = Integer.parseInt(idParam);
            PostService.getInstance().update(postId, user.getId(), content.trim());
            response.getWriter().write("ok");
        } catch (NumberFormatException e) {
            response.getWriter().write("error");
        }
    }
}

package epaw.lab3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab3.model.User;
import epaw.lab3.service.LikeService;

import java.io.IOException;

@WebServlet("/UnlikePost")
public class UnlikePost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                try {
                    int postId = Integer.parseInt(request.getParameter("id"));
                    int newCount = LikeService.getInstance().unlike(user.getId(), postId);
                    response.setContentType("text/plain");
                    response.getWriter().write(String.valueOf(newCount));
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

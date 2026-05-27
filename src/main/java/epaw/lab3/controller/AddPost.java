package epaw.lab3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import epaw.lab3.model.Post;
import epaw.lab3.model.User;
import epaw.lab3.service.PostService;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/AddPost")
public class AddPost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                String content = request.getParameter("content");
                if (content != null && !content.trim().isEmpty()) {
                    int visibility = 0; // default: tots
                    try {
                        visibility = Integer.parseInt(request.getParameter("visibility"));
                    } catch (Exception ignored) {}

                    Post post = new Post();
                    post.setUid(user.getId());
                    post.setUname(user.getName());
                    post.setContent(content.trim());
                    post.setVisibility(visibility);
                    post.setPostDateTime(new Timestamp(System.currentTimeMillis()));
                    PostService.getInstance().add(post);
                }
            }
        }
        // No response body — AJAX caller will reload MainPage
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

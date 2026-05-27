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
import java.util.List;

@WebServlet("/Posts")
public class Posts extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Post> posts = null;
        User user = null;

        HttpSession session = request.getSession(false);
        if (session != null) {
            user = (User) session.getAttribute("user");
            if (user != null) {
                posts = PostService.getInstance().getPostsByUser(user.getId(), 0, 10);
            }
        }

        request.setAttribute("posts", posts);
        request.setAttribute("user", user);
        request.getRequestDispatcher("Posts.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

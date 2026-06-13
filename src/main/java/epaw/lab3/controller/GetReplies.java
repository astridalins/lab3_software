package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/GetReplies")
public class GetReplies extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User viewer = (session != null) ? (User) session.getAttribute("user") : null;
        int viewerId = (viewer != null) ? viewer.getId() : 0;

        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) { response.setStatus(400); return; }

        try {
            int postId = Integer.parseInt(postIdStr);
            request.setAttribute("replies",      PostService.getInstance().getRepliesByPost(postId, viewerId));
            request.setAttribute("parentPostId", postId);
            request.getRequestDispatcher("Replies.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.setStatus(400);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

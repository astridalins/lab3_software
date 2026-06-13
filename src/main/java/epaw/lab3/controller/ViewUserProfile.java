package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.repository.UserRepository;
import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/ViewUserProfile")
public class ViewUserProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User viewer = (session != null) ? (User) session.getAttribute("user") : null;

        String uidParam = request.getParameter("uid");
        if (uidParam == null || viewer == null) {
            response.sendRedirect("MainPage");
            return;
        }

        int targetId;
        try { targetId = Integer.parseInt(uidParam); }
        catch (NumberFormatException e) { response.sendRedirect("MainPage"); return; }

        UserRepository userRepo = UserRepository.getInstance();
        Optional<User> targetOpt = userRepo.findFullById(targetId);
        if (targetOpt.isEmpty()) { response.sendRedirect("MainPage"); return; }

        User target = targetOpt.get();
        boolean isFollowing = userRepo.isFollowing(viewer.getId(), targetId);

        PostService svc = PostService.getInstance();
        request.setAttribute("targetUser",  target);
        request.setAttribute("isFollowing", isFollowing);
        request.setAttribute("publicPosts", svc.getPublicPostsByUser(targetId, viewer.getId()));
        if (isFollowing) {
            request.setAttribute("privatPosts", svc.getPrivatPostsByUser(targetId, viewer.getId()));
        }

        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

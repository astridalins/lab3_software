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
        if (uidParam == null) {
            response.sendRedirect(viewer != null ? "MainPage" : "AnonMainPage");
            return;
        }

        int targetId;
        try { targetId = Integer.parseInt(uidParam); }
        catch (NumberFormatException e) {
            response.sendRedirect(viewer != null ? "MainPage" : "AnonMainPage");
            return;
        }

        UserRepository userRepo = UserRepository.getInstance();
        Optional<User> targetOpt = userRepo.findFullById(targetId);
        if (targetOpt.isEmpty()) {
            response.sendRedirect(viewer != null ? "MainPage" : "AnonMainPage");
            return;
        }

        User target = targetOpt.get();
        boolean isAnonymous = (viewer == null);
        int viewerId = isAnonymous ? 0 : viewer.getId();
        boolean isFollowing = !isAnonymous && userRepo.isFollowing(viewerId, targetId);

        PostService svc = PostService.getInstance();
        request.setAttribute("targetUser",  target);
        request.setAttribute("isFollowing", isFollowing);
        request.setAttribute("isAnonymous", isAnonymous);
        request.setAttribute("publicPosts", svc.getPublicPostsByUser(targetId, viewerId));
        if (isFollowing) {
            request.setAttribute("privatPosts", svc.getPrivatPostsByUser(targetId, viewerId));
        }
        request.setAttribute("userReplies", svc.getRepliesByUser(targetId, viewerId));

        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

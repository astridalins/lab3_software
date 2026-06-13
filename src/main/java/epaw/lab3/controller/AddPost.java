package epaw.lab3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import epaw.lab3.model.Post;
import epaw.lab3.model.User;
import epaw.lab3.service.PostService;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

@MultipartConfig(
    maxFileSize       = 5  * 1024 * 1024,  // 5 MB per file
    maxRequestSize    = 20 * 1024 * 1024,  // 20 MB total
    fileSizeThreshold =      1024 * 1024   // 1 MB: keep small parts in memory
)
@WebServlet("/AddPost")
public class AddPost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/plain;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null) { resp.getWriter().write("no-auth"); return; }
        User user = (User) session.getAttribute("user");
        if (user == null)    { resp.getWriter().write("no-auth"); return; }

        // ── 1. Save image first (this also triggers multipart parsing) ──────
        String imagePath = saveImage(req, user.getUsername());

        // ── 2. Read text fields with getParameter (works after getPart) ─────
        String content = req.getParameter("content");
        if (content == null) content = "";
        content = content.trim();

        int visibility = 0;
        try { visibility = Integer.parseInt(req.getParameter("visibility")); }
        catch (Exception ignored) {}

        // ── 3. Need at least text or image ───────────────────────────────────
        if (content.isEmpty() && imagePath == null) {
            resp.getWriter().write("empty");
            return;
        }

        // ── 4. Build and persist the post ────────────────────────────────────
        Post post = new Post();
        post.setUid(user.getId());
        post.setUname(user.getName());
        post.setContent(content);
        post.setVisibility(visibility);
        post.setPostDateTime(new Timestamp(System.currentTimeMillis()));
        post.setImagePath(imagePath);
        // ── 5. Handle reply (parent_id) ───────────────────────────────────────
        String parentIdStr = req.getParameter("parentId");
        if (parentIdStr != null && !parentIdStr.isBlank()) {
            try {
                post.setParentId(Integer.parseInt(parentIdStr));
                post.setVisibility(0);   // replies are always public-visibility
                post.setCollaName(null);
            } catch (NumberFormatException ignored) {}
        } else if (visibility == 2) {
            String collaTarget = req.getParameter("collaTarget");
            if (user.getAdmin() == 1 && collaTarget != null && !collaTarget.isBlank()) {
                post.setCollaName(collaTarget);
            } else {
                post.setCollaName(user.getColla());
            }
        }

        PostService.getInstance().add(post);
        resp.getWriter().write("ok");
    }

    /**
     * Saves the uploaded image to assets/posts/ inside the deployed webapp.
     * Returns the relative path (e.g. "assets/posts/anna_cast_2026-06-13_15-30-00.jpg")
     * or null if no file was uploaded or saving failed.
     */
    private String saveImage(HttpServletRequest req, String username) {
        try {
            Part part = req.getPart("image");
            if (part == null || part.getSize() == 0) return null;

            String original = part.getSubmittedFileName();
            if (original == null || !original.contains(".")) return null;

            String ext      = original.substring(original.lastIndexOf('.')).toLowerCase();
            String ts       = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date());
            String fileName = username + "_" + ts + ext;

            // webapp root: works with Maven Tomcat plugin and standalone Tomcat
            String webRoot  = req.getServletContext().getRealPath("/");
            if (webRoot == null) return null;

            Path dir = Paths.get(webRoot, "assets", "posts");
            Files.createDirectories(dir);

            try (InputStream in = part.getInputStream()) {
                Files.copy(in, dir.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
            }

            return "assets/posts/" + fileName;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}

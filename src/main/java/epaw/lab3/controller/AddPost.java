package epaw.lab3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import epaw.lab3.model.Post;
import epaw.lab3.model.User;
import epaw.lab3.service.PostService;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

@MultipartConfig(
    maxFileSize      = 5  * 1024 * 1024,   // 5 MB per file
    maxRequestSize   = 20 * 1024 * 1024,   // 20 MB total
    fileSizeThreshold = 64 * 1024          // keep parts < 64 KB in memory
)
@WebServlet("/AddPost")
public class AddPost extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final SimpleDateFormat TS_FMT = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) { response.getWriter().write("no-auth"); return; }
        User user = (User) session.getAttribute("user");
        if (user == null) { response.getWriter().write("no-auth"); return; }

        // ── read text fields via getPart (reliable in multipart context) ────
        String content = readPartAsString(request, "content");
        int visibility = 0;
        try { visibility = Integer.parseInt(readPartAsString(request, "visibility")); }
        catch (Exception ignored) {}

        // ── save image if provided ──────────────────────────────────────────
        String imagePath = null;
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String original   = filePart.getSubmittedFileName();
                String ext        = original.substring(original.lastIndexOf('.'));
                String fileName   = user.getUsername() + "_" + TS_FMT.format(new Date()) + ext;
                String uploadsDir = request.getServletContext().getRealPath("/assets/posts");
                if (uploadsDir != null) {
                    Files.createDirectories(Paths.get(uploadsDir));
                    try (InputStream in = filePart.getInputStream()) {
                        Files.copy(in, Paths.get(uploadsDir, fileName), StandardCopyOption.REPLACE_EXISTING);
                    }
                    imagePath = "assets/posts/" + fileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // need text OR image
        if (content.isEmpty() && imagePath == null) {
            response.getWriter().write("empty");
            return;
        }

        Post post = new Post();
        post.setUid(user.getId());
        post.setUname(user.getName());
        post.setContent(content);
        post.setVisibility(visibility);
        post.setPostDateTime(new Timestamp(System.currentTimeMillis()));
        post.setImagePath(imagePath);
        if (visibility == 2) post.setCollaName(user.getColla());

        PostService.getInstance().add(post);
        response.getWriter().write("ok");
    }

    /** Read a non-file multipart field as a trimmed String. */
    private String readPartAsString(HttpServletRequest req, String name) {
        try {
            Part part = req.getPart(name);
            if (part == null) return "";
            try (InputStream in = part.getInputStream()) {
                return new String(in.readAllBytes(), java.nio.charset.StandardCharsets.UTF_8).trim();
            }
        } catch (Exception e) {
            // fallback to getParameter
            String v = req.getParameter(name);
            return v != null ? v.trim() : "";
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

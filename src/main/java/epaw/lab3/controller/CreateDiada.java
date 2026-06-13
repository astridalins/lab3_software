package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.DiadaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CreateDiada")
public class CreateDiada extends HttpServlet {

    private final DiadaService svc = new DiadaService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        User user = (User) req.getSession(false).getAttribute("user");
        if (user == null || user.getAdmin() != 1) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String name     = req.getParameter("name");
        String dia      = req.getParameter("dia");
        String location = req.getParameter("location");
        String[] colles = req.getParameterValues("colles");

        if (name == null || name.isBlank() || dia == null || dia.isBlank()) {
            resp.getWriter().write("error");
            return;
        }

        String collaJoined = "";
        if (colles != null && colles.length > 0) {
            StringBuilder sb = new StringBuilder();
            for (String c : colles) {
                if (c != null && !c.isBlank()) {
                    if (sb.length() > 0) sb.append(", ");
                    sb.append(c.trim());
                }
            }
            collaJoined = sb.toString();
        }

        svc.createDiada(name.trim(), dia.trim(),
                location != null ? location.trim() : "",
                collaJoined);

        resp.getWriter().write("ok");
    }
}

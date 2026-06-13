package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.DiadaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteDiada")
public class DeleteDiada extends HttpServlet {

    private final DiadaService svc = new DiadaService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession(false).getAttribute("user");
        if (user == null || user.getAdmin() != 1) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            resp.getWriter().write("error");
            return;
        }

        try {
            svc.deleteDiada(Integer.parseInt(idStr));
            resp.getWriter().write("ok");
        } catch (NumberFormatException e) {
            resp.getWriter().write("error");
        }
    }
}

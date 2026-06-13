package epaw.lab3.controller;

import epaw.lab3.model.Diada;
import epaw.lab3.service.CollaService;
import epaw.lab3.service.DiadaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/Eventos")
public class Eventos extends HttpServlet {

    private final DiadaService svc = new DiadaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Diada> diades = svc.getAllDiades();
        req.setAttribute("diades", diades);

        String idStr = req.getParameter("diadaId");
        if (idStr != null && !idStr.isBlank()) {
            try {
                Diada selected = svc.getDiadaById(Integer.parseInt(idStr));
                req.setAttribute("selected", selected);
            } catch (NumberFormatException ignored) {}
        }

        req.setAttribute("colles", CollaService.getInstance().getTotes());
        req.getRequestDispatcher("Eventos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}

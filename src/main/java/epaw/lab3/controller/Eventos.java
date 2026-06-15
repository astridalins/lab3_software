package epaw.lab3.controller;

import epaw.lab3.model.Diada;
import epaw.lab3.model.User;
import epaw.lab3.service.CollaService;
import epaw.lab3.service.DiadaService;
import epaw.lab3.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/Eventos")
public class Eventos extends HttpServlet {

    private final DiadaService  diadaSvc  = new DiadaService();
    private final ReviewService reviewSvc = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Diada> diades = diadaSvc.getAllDiades();
        req.setAttribute("diades", diades);
        req.setAttribute("colles", CollaService.getInstance().getTotes());

        String idStr = req.getParameter("diadaId");
        if (idStr != null && !idStr.isBlank()) {
            try {
                Diada selected = diadaSvc.getDiadaById(Integer.parseInt(idStr));
                if (selected != null) {
                    req.setAttribute("selected", selected);
                    req.setAttribute("reviews",   reviewSvc.getByDiada(selected.getId()));
                    req.setAttribute("avgRating", reviewSvc.getAverage(selected.getId()));

                    HttpSession session = req.getSession(false);
                    User user = (session != null) ? (User) session.getAttribute("user") : null;
                    boolean canReview   = false;
                    boolean hasReviewed = false;
                    if (user != null && "CASTELLER".equals(user.getUserType())) {
                        String userColla = user.getColla();
                        if (userColla != null) {
                            for (String c : selected.getColles()) {
                                if (c.trim().equalsIgnoreCase(userColla.trim())) {
                                    canReview = true; break;
                                }
                            }
                        }
                        if (canReview) {
                            hasReviewed = reviewSvc.hasReviewed(selected.getId(), user.getId());
                        }
                    }
                    req.setAttribute("canReview",   canReview);
                    req.setAttribute("hasReviewed", hasReviewed);
                }
            } catch (NumberFormatException ignored) {}
        }

        req.getRequestDispatcher("Eventos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}

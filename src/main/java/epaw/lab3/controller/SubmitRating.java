package epaw.lab3.controller;

import epaw.lab3.model.Diada;
import epaw.lab3.model.User;
import epaw.lab3.service.DiadaService;
import epaw.lab3.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/SubmitRating")
public class SubmitRating extends HttpServlet {

    private final ReviewService reviewSvc = new ReviewService();
    private final DiadaService  diadaSvc  = new DiadaService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null) { resp.getWriter().write("noauth"); return; }
        User user = (User) session.getAttribute("user");
        if (user == null || !"CASTELLER".equals(user.getUserType())) {
            resp.getWriter().write("noauth"); return;
        }

        String diadaIdStr = req.getParameter("diadaId");
        String valueStr   = req.getParameter("value");
        if (diadaIdStr == null || valueStr == null) { resp.getWriter().write("error"); return; }

        int diadaId, value;
        try {
            diadaId = Integer.parseInt(diadaIdStr.trim());
            value   = Integer.parseInt(valueStr.trim());
        } catch (NumberFormatException e) { resp.getWriter().write("error"); return; }

        if (value < 1 || value > 5) { resp.getWriter().write("error"); return; }

        Diada diada = diadaSvc.getDiadaById(diadaId);
        if (diada == null) { resp.getWriter().write("error"); return; }

        String userColla = user.getColla();
        boolean authorized = false;
        if (userColla != null) {
            for (String c : diada.getColles()) {
                if (c.trim().equalsIgnoreCase(userColla.trim())) { authorized = true; break; }
            }
        }
        if (!authorized) { resp.getWriter().write("notauthorized"); return; }

        if (reviewSvc.hasReviewed(diadaId, user.getId())) {
            resp.getWriter().write("alreadyreviewed"); return;
        }

        reviewSvc.save(diadaId, user.getId(), value);
        resp.getWriter().write("ok");
    }
}

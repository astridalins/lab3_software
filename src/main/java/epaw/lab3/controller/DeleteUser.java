package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.AdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession(false);
        User admin = (session != null) ? (User) session.getAttribute("user") : null;
        if (admin == null || admin.getAdmin() != 1) {
            response.getWriter().write("no-auth");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) { response.getWriter().write("error"); return; }

        try {
            int targetId = Integer.parseInt(idParam);
            if (targetId == admin.getId()) {
                response.getWriter().write("self");
                return;
            }
            AdminService.getInstance().deleteUser(targetId);
            response.getWriter().write("ok");
        } catch (NumberFormatException e) {
            response.getWriter().write("error");
        }
    }
}

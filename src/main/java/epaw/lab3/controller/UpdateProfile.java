package epaw.lab3.controller;

import epaw.lab3.model.User;
import epaw.lab3.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) { response.setStatus(401); return; }
        User current = (User) session.getAttribute("user");
        if (current == null) { response.setStatus(401); return; }

        // Build updated user from form params
        User updated = new User();
        updated.setName(request.getParameter("name"));
        updated.setEmail(request.getParameter("email"));
        updated.setLocation(request.getParameter("location"));
        updated.setColla(request.getParameter("colla"));

        // Multi-select posicions → join with comma
        String[] posArr = request.getParameterValues("posicions");
        if (posArr != null && posArr.length > 0)
            updated.setPosicions(String.join(",", posArr));
        else
            updated.setPosicions(null);

        Map<String, String> errors = UserService.getInstance().updateProfile(updated, current);

        if (errors.isEmpty()) {
            // Sync session user with saved values
            current.setName(updated.getName());
            current.setEmail(updated.getEmail());
            current.setLocation(updated.getLocation());
            current.setColla(updated.getColla());
            current.setPosicions(updated.getPosicions());

            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("ok");
        } else {
            response.setStatus(400);
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder json = new StringBuilder("{");
            errors.forEach((k, v) ->
                json.append("\"").append(k).append("\":\"")
                    .append(v.replace("\"", "\\\"")).append("\","));
            if (json.charAt(json.length() - 1) == ',')
                json.setCharAt(json.length() - 1, '}');
            else
                json.append("}");
            response.getWriter().write(json.toString());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

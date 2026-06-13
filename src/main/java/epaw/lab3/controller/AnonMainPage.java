package epaw.lab3.controller;

import epaw.lab3.service.PostService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AnonMainPage")
public class AnonMainPage extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // userId=0 → likedByMe always 0 (anonymous cannot like)
        request.setAttribute("totsPosts", PostService.getInstance().getTotsPosts(0));
        request.getRequestDispatcher("AnonMainPage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

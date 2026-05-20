// package epaw.lab3.controller;

// import epaw.lab3.repository.UserRepository;
// import epaw.lab3.model.User;

// import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
// import jakarta.servlet.http.*;

// import java.io.IOException;

// @WebServlet("/DeleteUser")
// public class DeleteUser extends HttpServlet {

//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {

//         HttpSession session = request.getSession(false);
//         User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

//         // només admin pot eliminar
//         if (currentUser == null || currentUser.getAdmin() != 1) {
//             response.sendRedirect("MainPage");
//             return;
//         }

//         // agafar id usuari a eliminar
//         int id = Integer.parseInt(request.getParameter("id"));

//         // eliminar de BD
//         UserRepository.getInstance().deleteById(id);

//         // tornar a la llista
//         response.sendRedirect("UsersSearch");
//     }
// }
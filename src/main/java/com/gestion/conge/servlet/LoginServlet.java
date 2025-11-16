package com.gestion.conge.servlet;

import com.gestion.conge.dao.UtilisateurDAO;
import com.gestion.conge.model.Utilisateur;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO userDao = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Utilisateur u = userDao.findByEmail(email);
        if (u != null && BCrypt.checkpw(password, u.getMotDePasse())) {
            HttpSession session = req.getSession();
            session.setAttribute("user", u);
            String role = u.getRole();
            if ("ADMIN".equalsIgnoreCase(role)) resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            else if ("MANAGER".equalsIgnoreCase(role)) resp.sendRedirect(req.getContextPath() + "/manager/dashboard");
            else resp.sendRedirect(req.getContextPath() + "/employe/dashboard");
        } else {
            req.setAttribute("error", "Email ou mot de passe incorrect");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
package com.gestion.conge.servlet;
import com.gestion.conge.dao.UtilisateurDAO;
import com.gestion.conge.model.Utilisateur;

import com.gestion.conge.dao.UtilisateurDAO;
import com.gestion.conge.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;


@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}



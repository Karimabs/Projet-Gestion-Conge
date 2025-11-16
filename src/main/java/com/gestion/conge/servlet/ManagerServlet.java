package com.gestion.conge.servlet;

import com.gestion.conge.dao.DemandeCongeDAO;
import com.gestion.conge.model.DemandeConge;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manager/dashboard")
public class ManagerServlet extends HttpServlet {
    private DemandeCongeDAO demandeDAO = new DemandeCongeDAO();


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        List<DemandeConge> demandes = demandeDAO.findByStatut("EN_ATTENTE");

        req.setAttribute("demandes", demandes);

        // <-- MODIFICATION IMPORTANTE
        // Correction du chemin vers votre JSP
        req.getRequestDispatcher("/WEB-INF/manager/dashboard.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            Integer id = Integer.valueOf(req.getParameter("id"));
            DemandeConge d = demandeDAO.findById(id);

            if (d != null) {
                if ("accepter".equals(action)) {
                    d.setStatut("ACCEPTEE");
                } else if ("refuser".equals(action)) {
                    d.setStatut("REFUSEE");
                }
                demandeDAO.save(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/manager/dashboard");
    }
}
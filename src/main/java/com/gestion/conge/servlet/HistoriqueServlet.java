package com.gestion.conge.servlet;

import com.gestion.conge.dao.DemandeCongeDAO;
import com.gestion.conge.model.DemandeConge;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/manager/historique")
public class HistoriqueServlet extends HttpServlet {
    private DemandeCongeDAO demandeDAO = new DemandeCongeDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String termeRecherche = req.getParameter("recherche");
        List<DemandeConge> demandesHistorique;


        if (termeRecherche != null && !termeRecherche.trim().isEmpty()) {

            String[] noms = termeRecherche.trim().split("\\s+");

            if (noms.length == 1) {

                demandesHistorique = demandeDAO.findProcessedByExactSingleName(noms[0]);

            } else if (noms.length >= 2) {

                demandesHistorique = demandeDAO.findProcessedByExactFullName(noms[0], noms[1]);

            } else {

                demandesHistorique = Collections.emptyList();
            }

        } else {

            List<DemandeConge> acceptees = demandeDAO.findByStatut("ACCEPTEE");
            List<DemandeConge> refusees = demandeDAO.findByStatut("REFUSEE");

            demandesHistorique = new ArrayList<>(acceptees);
            demandesHistorique.addAll(refusees);
        }

        req.setAttribute("demandesHistorique", demandesHistorique);
        req.getRequestDispatcher("/manager/historique.jsp").forward(req, resp);
    }
}
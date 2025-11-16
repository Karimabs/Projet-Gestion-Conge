package com.gestion.conge.servlet;

import com.gestion.conge.dao.DemandeCongeDAO;
import com.gestion.conge.model.DemandeConge;
import com.gestion.conge.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/employe/dashboard")
public class EmployeServlet extends HttpServlet {

    private DemandeCongeDAO demandeDAO = new DemandeCongeDAO();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Utilisateur user = (Utilisateur) session.getAttribute("user");
        String action = req.getParameter("action");

        if ("modifier".equals(action)) {

            try {
                Integer id = Integer.valueOf(req.getParameter("id"));
                DemandeConge d = demandeDAO.findById(id);


                if (d != null && d.getUtilisateur().getId().equals(user.getId()) && "EN_ATTENTE".equals(d.getStatut())) {
                    req.setAttribute("demande", d); // Passe l'objet demande à la JSP
                    req.getRequestDispatcher("/WEB-INF/employe/modifierDemande.jsp").forward(req, resp);
                } else {

                    resp.sendRedirect(req.getContextPath() + "/employe/dashboard");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/employe/dashboard");
            }
        } else {

            List<DemandeConge> demandes = demandeDAO.findByUtilisateur(user);
            req.setAttribute("demandes", demandes);
            req.getRequestDispatcher("/WEB-INF/employe/dashboard.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "envoyer";
        }

        try {
            if ("annuler".equals(action)) {

                Integer id = Integer.valueOf(req.getParameter("id"));
                DemandeConge d = demandeDAO.findById(id);

                if (d != null && d.getUtilisateur().getId().equals(user.getId()) && "EN_ATTENTE".equals(d.getStatut())) {
                    demandeDAO.delete(d);
                }

            } else if ("envoyer".equals(action)) {

                Date dateDebut = dateFormat.parse(req.getParameter("dateDebut"));
                Date dateFin = dateFormat.parse(req.getParameter("dateFin"));
                String typeConge = req.getParameter("typeConge");
                String note = req.getParameter("note");

                DemandeConge nouvelleDemande = new DemandeConge();

                nouvelleDemande.setUtilisateur(user);
                nouvelleDemande.setDateDebut(dateDebut);
                nouvelleDemande.setDateFin(dateFin);
                nouvelleDemande.setTypeConge(typeConge);
                nouvelleDemande.setNote(note);
                nouvelleDemande.setStatut("EN_ATTENTE");

                demandeDAO.save(nouvelleDemande);

            } else if ("modifier".equals(action)) {

                Integer id = Integer.valueOf(req.getParameter("id"));
                DemandeConge d = demandeDAO.findById(id);

                if (d != null && d.getUtilisateur().getId().equals(user.getId()) && "EN_ATTENTE".equals(d.getStatut())) {

                    d.setDateDebut(dateFormat.parse(req.getParameter("dateDebut")));
                    d.setDateFin(dateFormat.parse(req.getParameter("dateFin")));
                    d.setTypeConge(req.getParameter("typeConge"));
                    d.setNote(req.getParameter("note"));


                    demandeDAO.save(d);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/employe/dashboard");
    }
}
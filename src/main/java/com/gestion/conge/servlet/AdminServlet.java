package com.gestion.conge.servlet;

import com.gestion.conge.dao.UtilisateurDAO; // Vous devez avoir ce DAO
import com.gestion.conge.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("modifier".equals(action)) {

            try {
                Integer id = Integer.valueOf(req.getParameter("id"));
                Utilisateur u = utilisateurDAO.findById(id);
                if (u != null) {
                    req.setAttribute("utilisateur", u);
                    req.getRequestDispatcher("/admin/modifierUtilisateur.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            }
        } else {

            List<Utilisateur> users = utilisateurDAO.findAll();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            if ("creer".equals(action)) {
                // --- LOGIQUE DE CRÉATION ---
                String prenom = req.getParameter("prenom");
                String nom = req.getParameter("nom");
                String email = req.getParameter("email");
                String motDePasse = req.getParameter("password");
                String role = req.getParameter("role");

                Utilisateur newUser = new Utilisateur(nom, prenom, email, motDePasse, role);
                utilisateurDAO.save(newUser);

            } else if ("supprimer".equals(action)) {
                Integer id = Integer.valueOf(req.getParameter("id"));
                Utilisateur u = utilisateurDAO.findById(id);
                if (u != null) {
                    utilisateurDAO.delete(u);
                }

            } else if ("sauvegarder".equals(action)) {

                Integer id = Integer.valueOf(req.getParameter("id"));
                Utilisateur u = utilisateurDAO.findById(id);

                if (u != null) {
                    u.setPrenom(req.getParameter("prenom"));
                    u.setNom(req.getParameter("nom"));
                    u.setEmail(req.getParameter("email"));
                    u.setRole(req.getParameter("role"));


                    String mdp = req.getParameter("password");
                    if (mdp != null && !mdp.isEmpty()) {

                        u.setMotDePasse(mdp);
                    }
                    utilisateurDAO.save(u);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();

        }


        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
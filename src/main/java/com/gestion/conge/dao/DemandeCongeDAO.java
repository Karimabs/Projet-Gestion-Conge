package com.gestion.conge.dao;

import com.gestion.conge.model.DemandeConge;
import com.gestion.conge.model.Utilisateur;
import com.gestion.conge.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.Collections;
import java.util.List;

public class DemandeCongeDAO {

    public void save(DemandeConge d) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.saveOrUpdate(d);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public DemandeConge findById(Integer id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(DemandeConge.class, id);
        }
    }

    public List<DemandeConge> findByStatut(String statut) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery("FROM DemandeConge d WHERE d.statut = :statut", DemandeConge.class)
                    .setParameter("statut", statut)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();

            return Collections.emptyList();
        }
    }

    public List<DemandeConge> findByUtilisateur(Utilisateur u) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM DemandeConge WHERE utilisateur = :u", DemandeConge.class)
                    .setParameter("u", u)
                    .list();
        }
    }
    public List<DemandeConge> findProcessedByExactSingleName(String terme) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT d FROM DemandeConge d JOIN d.utilisateur u " +
                    "WHERE (d.statut = 'ACCEPTEE' OR d.statut = 'REFUSEE') " +
                    "AND (LOWER(u.nom) = :terme OR LOWER(u.prenom) = :terme)";

            return session.createQuery(hql, DemandeConge.class)
                    // Pas de "%" -> correspondance exacte
                    .setParameter("terme", terme.toLowerCase())
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public List<DemandeConge> findProcessedByExactFullName(String part1, String part2) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT d FROM DemandeConge d JOIN d.utilisateur u " +
                    "WHERE (d.statut = 'ACCEPTEE' OR d.statut = 'REFUSEE') " +
                    "AND ( (LOWER(u.nom) = :part1 AND LOWER(u.prenom) = :part2) OR " +
                    "      (LOWER(u.nom) = :part2 AND LOWER(u.prenom) = :part1) )";

            return session.createQuery(hql, DemandeConge.class)
                    // Pas de "%" -> correspondance exacte
                    .setParameter("part1", part1.toLowerCase())
                    .setParameter("part2", part2.toLowerCase())
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }


    public List<DemandeConge> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM DemandeConge", DemandeConge.class).list();
        }
    }

    public void delete(DemandeConge d) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.delete(d);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}

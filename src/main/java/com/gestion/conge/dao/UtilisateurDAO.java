package com.gestion.conge.dao;

import com.gestion.conge.model.Utilisateur;
import com.gestion.conge.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class UtilisateurDAO {

    public void save(Utilisateur u) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.saveOrUpdate(u);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public Utilisateur findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Utilisateur WHERE email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .uniqueResult();
        }
    }

    public Utilisateur findById(Integer id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Utilisateur.class, id);
        }
    }

    public List<Utilisateur> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Utilisateur", Utilisateur.class).list();
        }
    }

    public void delete(Utilisateur u) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.delete(u);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}

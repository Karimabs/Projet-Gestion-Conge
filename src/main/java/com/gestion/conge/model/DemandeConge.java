package com.gestion.conge.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "demande_conge")
public class DemandeConge {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;


    @Temporal(TemporalType.DATE)
    @Column(name = "date_debut")
    private Date dateDebut;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_fin")
    private Date dateFin;

    @Column(name = "type_conge")
    private String typeConge;

    @Column(name = "note")
    private String note;

    private String statut; // "EN_ATTENTE", "ACCEPTEE", "REFUSEE"

    public DemandeConge() {}

    public DemandeConge(Utilisateur utilisateur, Date dateDebut, Date dateFin, String typeConge,String note, String statut) {
        this.utilisateur = utilisateur;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.typeConge = typeConge;
        this.note=note;
        this.statut = statut;
    }

    // getters et setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Utilisateur getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Utilisateur utilisateur) { this.utilisateur = utilisateur; }

    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }

    public Date getDateFin() { return dateFin; }
    public void setDateFin(Date dateFin) { this.dateFin = dateFin; }

    public String getTypeConge() { return typeConge; }
    public void setTypeConge(String typeConge) { this.typeConge = typeConge; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getNote() {return note;}
    public void setNote(String note) {this.note = note;}
}
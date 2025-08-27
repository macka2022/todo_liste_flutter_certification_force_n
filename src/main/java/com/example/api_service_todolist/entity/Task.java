package com.example.api_service_todolist.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String titre ;
    private String contenu ;
    private LocalDate dateHeure;
    private Priorite priorite;
    enum Priorite {
        ELEVEE, MOYENNE, BASSE
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Utilisateur utilisateur;


    public long getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public LocalDate getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(LocalDate dateHeure) {
        this.dateHeure = dateHeure;
    }

    public Priorite getPriorite() {
        return priorite;
    }

    public void setPriorite(Priorite priorite) {
        this.priorite = priorite;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
}

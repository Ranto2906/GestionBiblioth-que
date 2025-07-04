package com.example.biblio.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "auteur")
public class Auteur {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_auteur")
    private Long idAuteur;
    
    @Column(name = "nom", nullable = false, length = 50)
    private String nom;
    
    @Column(name = "prenom", nullable = false, length = 50)
    private String prenom;
    
    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    
    @Column(name = "date_deces")
    private LocalDate dateDeces;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Relations
    @OneToMany(mappedBy = "auteur", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LivreAuteur> livres;
    
    // Constructeurs
    public Auteur() {
        this.createdAt = LocalDateTime.now();
    }
    
    public Auteur(String nom, String prenom) {
        this();
        this.nom = nom;
        this.prenom = prenom;
    }
    
    // Getters et Setters
    public Long getIdAuteur() {
        return idAuteur;
    }
    
    public void setIdAuteur(Long idAuteur) {
        this.idAuteur = idAuteur;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getPrenom() {
        return prenom;
    }
    
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
    
    public LocalDate getDateNaissance() {
        return dateNaissance;
    }
    
    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }
    
    public LocalDate getDateDeces() {
        return dateDeces;
    }
    
    public void setDateDeces(LocalDate dateDeces) {
        this.dateDeces = dateDeces;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public List<LivreAuteur> getLivres() {
        return livres;
    }
    
    public void setLivres(List<LivreAuteur> livres) {
        this.livres = livres;
    }
    
    public String getNomComplet() {
        return prenom + " " + nom;
    }
    
    @Override
    public String toString() {
        return "Auteur{" +
                "idAuteur=" + idAuteur +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", dateNaissance=" + dateNaissance +
                ", dateDeces=" + dateDeces +
                '}';
    }
} 
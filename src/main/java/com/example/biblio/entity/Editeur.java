package com.example.biblio.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "editeur")
public class Editeur {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_editeur")
    private Long idEditeur;
    
    @Column(name = "nom_editeur", nullable = false, unique = true, length = 100)
    private String nomEditeur;
    
    @Column(name = "pays", nullable = false, length = 50)
    private String pays;
    
    @Column(name = "ville", length = 50)
    private String ville;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Relations
    @OneToMany(mappedBy = "editeur")
    private List<Livre> livres;
    
    // Constructeurs
    public Editeur() {
        this.createdAt = LocalDateTime.now();
    }
    
    public Editeur(String nomEditeur, String pays) {
        this();
        this.nomEditeur = nomEditeur;
        this.pays = pays;
    }
    
    // Getters et Setters
    public Long getIdEditeur() {
        return idEditeur;
    }
    
    public void setIdEditeur(Long idEditeur) {
        this.idEditeur = idEditeur;
    }
    
    public String getNomEditeur() {
        return nomEditeur;
    }
    
    public void setNomEditeur(String nomEditeur) {
        this.nomEditeur = nomEditeur;
    }
    
    public String getPays() {
        return pays;
    }
    
    public void setPays(String pays) {
        this.pays = pays;
    }
    
    public String getVille() {
        return ville;
    }
    
    public void setVille(String ville) {
        this.ville = ville;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public List<Livre> getLivres() {
        return livres;
    }
    
    public void setLivres(List<Livre> livres) {
        this.livres = livres;
    }
    
    @Override
    public String toString() {
        return "Editeur{" +
                "idEditeur=" + idEditeur +
                ", nomEditeur='" + nomEditeur + '\'' +
                ", pays='" + pays + '\'' +
                ", ville='" + ville + '\'' +
                ", actif=" + actif +
                '}';
    }
} 
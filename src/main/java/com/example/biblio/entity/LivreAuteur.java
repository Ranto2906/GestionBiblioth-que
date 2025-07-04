package com.example.biblio.entity;

import com.example.biblio.entity.enums.LivreAuteurRole;
import jakarta.persistence.*;

@Entity
@Table(name = "livre_auteur")
@IdClass(LivreAuteurId.class)
public class LivreAuteur {
    
    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_auteur", nullable = false)
    private Auteur auteur;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "role_auteur")
    private LivreAuteurRole roleAuteur = LivreAuteurRole.AUTEUR_PRINCIPAL;
    
    @Column(name = "ordre_auteur")
    private Integer ordreAuteur = 1;
    
    // Constructeurs
    public LivreAuteur() {}
    
    public LivreAuteur(Livre livre, Auteur auteur) {
        this.livre = livre;
        this.auteur = auteur;
    }
    
    public LivreAuteur(Livre livre, Auteur auteur, LivreAuteurRole roleAuteur) {
        this(livre, auteur);
        this.roleAuteur = roleAuteur;
    }
    
    // Getters et Setters
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public Auteur getAuteur() {
        return auteur;
    }
    
    public void setAuteur(Auteur auteur) {
        this.auteur = auteur;
    }
    
    public LivreAuteurRole getRoleAuteur() {
        return roleAuteur;
    }
    
    public void setRoleAuteur(LivreAuteurRole roleAuteur) {
        this.roleAuteur = roleAuteur;
    }
    
    public Integer getOrdreAuteur() {
        return ordreAuteur;
    }
    
    public void setOrdreAuteur(Integer ordreAuteur) {
        this.ordreAuteur = ordreAuteur;
    }
    
    @Override
    public String toString() {
        return "LivreAuteur{" +
                "livre=" + (livre != null ? livre.getTitre() : "null") +
                ", auteur=" + (auteur != null ? auteur.getNomComplet() : "null") +
                ", roleAuteur=" + roleAuteur +
                ", ordreAuteur=" + ordreAuteur +
                '}';
    }
} 
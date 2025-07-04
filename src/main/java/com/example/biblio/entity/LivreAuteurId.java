package com.example.biblio.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class LivreAuteurId implements Serializable {
    
    private Long livre;
    private Long auteur;
    
    public LivreAuteurId() {}
    
    public LivreAuteurId(Long livre, Long auteur) {
        this.livre = livre;
        this.auteur = auteur;
    }
    
    public Long getLivre() {
        return livre;
    }
    
    public void setLivre(Long livre) {
        this.livre = livre;
    }
    
    public Long getAuteur() {
        return auteur;
    }
    
    public void setAuteur(Long auteur) {
        this.auteur = auteur;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        LivreAuteurId that = (LivreAuteurId) o;
        return Objects.equals(livre, that.livre) && Objects.equals(auteur, that.auteur);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(livre, auteur);
    }
    
    @Override
    public String toString() {
        return "LivreAuteurId{" +
                "livre=" + livre +
                ", auteur=" + auteur +
                '}';
    }
} 
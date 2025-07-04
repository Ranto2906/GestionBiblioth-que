package com.example.biblio.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "emplacement")
public class Emplacement {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_emplacement")
    private Long idEmplacement;
    
    @Column(name = "code_emplacement", nullable = false, unique = true, length = 20)
    private String codeEmplacement;
    
    @Column(name = "description", nullable = false, length = 100)
    private String description;
    
    @Column(name = "section", nullable = false, length = 50)
    private String section;
    
    @Column(name = "rayon", length = 20)
    private String rayon;
    
    @Column(name = "etagere", length = 20)
    private String etagere;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    // Relations
    @OneToMany(mappedBy = "emplacement")
    private List<Livre> livres;
    
    // Constructeurs
    public Emplacement() {}
    
    public Emplacement(String codeEmplacement, String description, String section) {
        this.codeEmplacement = codeEmplacement;
        this.description = description;
        this.section = section;
    }
    
    // Getters et Setters
    public Long getIdEmplacement() {
        return idEmplacement;
    }
    
    public void setIdEmplacement(Long idEmplacement) {
        this.idEmplacement = idEmplacement;
    }
    
    public String getCodeEmplacement() {
        return codeEmplacement;
    }
    
    public void setCodeEmplacement(String codeEmplacement) {
        this.codeEmplacement = codeEmplacement;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getSection() {
        return section;
    }
    
    public void setSection(String section) {
        this.section = section;
    }
    
    public String getRayon() {
        return rayon;
    }
    
    public void setRayon(String rayon) {
        this.rayon = rayon;
    }
    
    public String getEtagere() {
        return etagere;
    }
    
    public void setEtagere(String etagere) {
        this.etagere = etagere;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public List<Livre> getLivres() {
        return livres;
    }
    
    public void setLivres(List<Livre> livres) {
        this.livres = livres;
    }
    
    @Override
    public String toString() {
        return "Emplacement{" +
                "idEmplacement=" + idEmplacement +
                ", codeEmplacement='" + codeEmplacement + '\'' +
                ", description='" + description + '\'' +
                ", section='" + section + '\'' +
                ", rayon='" + rayon + '\'' +
                ", etagere='" + etagere + '\'' +
                ", actif=" + actif +
                '}';
    }
} 
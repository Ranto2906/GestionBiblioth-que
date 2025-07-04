package com.example.biblio.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "langue")
public class Langue {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_langue")
    private Long idLangue;
    
    @Column(name = "code_langue", nullable = false, unique = true, length = 3)
    private String codeLangue;
    
    @Column(name = "nom_langue", nullable = false, length = 50)
    private String nomLangue;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    // Relations
    @OneToMany(mappedBy = "langue")
    private List<Livre> livres;
    
    // Constructeurs
    public Langue() {}
    
    public Langue(String codeLangue, String nomLangue) {
        this.codeLangue = codeLangue;
        this.nomLangue = nomLangue;
    }
    
    // Getters et Setters
    public Long getIdLangue() {
        return idLangue;
    }
    
    public void setIdLangue(Long idLangue) {
        this.idLangue = idLangue;
    }
    
    public String getCodeLangue() {
        return codeLangue;
    }
    
    public void setCodeLangue(String codeLangue) {
        this.codeLangue = codeLangue;
    }
    
    public String getNomLangue() {
        return nomLangue;
    }
    
    public void setNomLangue(String nomLangue) {
        this.nomLangue = nomLangue;
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
        return "Langue{" +
                "idLangue=" + idLangue +
                ", codeLangue='" + codeLangue + '\'' +
                ", nomLangue='" + nomLangue + '\'' +
                ", actif=" + actif +
                '}';
    }
} 
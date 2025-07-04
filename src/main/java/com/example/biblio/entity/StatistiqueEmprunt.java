package com.example.biblio.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "statistique_emprunt")
public class StatistiqueEmprunt {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_statistique")
    private Long idStatistique;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @Column(name = "nombre_emprunts")
    private Integer nombreEmprunts = 0;
    
    @Column(name = "nombre_retours")
    private Integer nombreRetours = 0;
    
    @Column(name = "nombre_retards")
    private Integer nombreRetards = 0;
    
    @Column(name = "periode_debut")
    private LocalDateTime periodeDebut;
    
    @Column(name = "periode_fin")
    private LocalDateTime periodeFin;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructeurs
    public StatistiqueEmprunt() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public StatistiqueEmprunt(Livre livre) {
        this();
        this.livre = livre;
    }
    
    // Getters et Setters
    public Long getIdStatistique() {
        return idStatistique;
    }
    
    public void setIdStatistique(Long idStatistique) {
        this.idStatistique = idStatistique;
    }
    
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public Integer getNombreEmprunts() {
        return nombreEmprunts;
    }
    
    public void setNombreEmprunts(Integer nombreEmprunts) {
        this.nombreEmprunts = nombreEmprunts;
    }
    
    public Integer getNombreRetours() {
        return nombreRetours;
    }
    
    public void setNombreRetours(Integer nombreRetours) {
        this.nombreRetours = nombreRetours;
    }
    
    public Integer getNombreRetards() {
        return nombreRetards;
    }
    
    public void setNombreRetards(Integer nombreRetards) {
        this.nombreRetards = nombreRetards;
    }
    
    public LocalDateTime getPeriodeDebut() {
        return periodeDebut;
    }
    
    public void setPeriodeDebut(LocalDateTime periodeDebut) {
        this.periodeDebut = periodeDebut;
    }
    
    public LocalDateTime getPeriodeFin() {
        return periodeFin;
    }
    
    public void setPeriodeFin(LocalDateTime periodeFin) {
        this.periodeFin = periodeFin;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "StatistiqueEmprunt{" +
                "idStatistique=" + idStatistique +
                ", nombreEmprunts=" + nombreEmprunts +
                ", nombreRetours=" + nombreRetours +
                ", nombreRetards=" + nombreRetards +
                '}';
    }
} 
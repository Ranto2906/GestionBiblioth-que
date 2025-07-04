package com.example.biblio.entity;

import com.example.biblio.entity.enums.ProlongationStatut;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "prolongation_pret")
public class ProlongationPret {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_prolongation")
    private Long idProlongation;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;
    
    @Column(name = "date_demande")
    private LocalDate dateDemande;
    
    @Column(name = "nouvelle_date_retour", nullable = false)
    private LocalDate nouvelleDateRetour;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut", nullable = false)
    private ProlongationStatut statut;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_bibliothecaire")
    private Utilisateur bibliothecaire;
    
    @Column(name = "motif_refus")
    private String motifRefus;
    
    @Column(name = "automatique")
    private Boolean automatique = false;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Constructeurs
    public ProlongationPret() {
        this.createdAt = LocalDateTime.now();
        this.dateDemande = LocalDate.now();
    }
    
    public ProlongationPret(Pret pret, LocalDate nouvelleDateRetour, ProlongationStatut statut) {
        this();
        this.pret = pret;
        this.nouvelleDateRetour = nouvelleDateRetour;
        this.statut = statut;
    }
    
    // Getters et Setters
    public Long getIdProlongation() {
        return idProlongation;
    }
    
    public void setIdProlongation(Long idProlongation) {
        this.idProlongation = idProlongation;
    }
    
    public Pret getPret() {
        return pret;
    }
    
    public void setPret(Pret pret) {
        this.pret = pret;
    }
    
    public LocalDate getDateDemande() {
        return dateDemande;
    }
    
    public void setDateDemande(LocalDate dateDemande) {
        this.dateDemande = dateDemande;
    }
    
    public LocalDate getNouvelleDateRetour() {
        return nouvelleDateRetour;
    }
    
    public void setNouvelleDateRetour(LocalDate nouvelleDateRetour) {
        this.nouvelleDateRetour = nouvelleDateRetour;
    }
    
    public ProlongationStatut getStatut() {
        return statut;
    }
    
    public void setStatut(ProlongationStatut statut) {
        this.statut = statut;
    }
    
    public Utilisateur getBibliothecaire() {
        return bibliothecaire;
    }
    
    public void setBibliothecaire(Utilisateur bibliothecaire) {
        this.bibliothecaire = bibliothecaire;
    }
    
    public String getMotifRefus() {
        return motifRefus;
    }
    
    public void setMotifRefus(String motifRefus) {
        this.motifRefus = motifRefus;
    }
    
    public Boolean getAutomatique() {
        return automatique;
    }
    
    public void setAutomatique(Boolean automatique) {
        this.automatique = automatique;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "ProlongationPret{" +
                "idProlongation=" + idProlongation +
                ", statut=" + statut +
                ", automatique=" + automatique +
                '}';
    }
} 
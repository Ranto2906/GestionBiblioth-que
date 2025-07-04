package com.example.biblio.entity;

import com.example.biblio.entity.enums.PenaliteStatut;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "penalite")
public class Penalite {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_penalite")
    private Long idPenalite;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_type_penalite", nullable = false)
    private TypePenalite typePenalite;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_pret")
    private Pret pret;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_bibliothecaire")
    private Utilisateur bibliothecaire;
    
    @Column(name = "montant_calcule", precision = 10, scale = 2)
    private BigDecimal montantCalcule = BigDecimal.ZERO;
    
    @Column(name = "montant_final", nullable = false, precision = 10, scale = 2)
    private BigDecimal montantFinal;
    
    @Column(name = "date_debut_suspension")
    private LocalDate dateDebutSuspension;
    
    @Column(name = "date_fin_suspension")
    private LocalDate dateFinSuspension;
    
    @Column(name = "date_creation")
    private LocalDateTime dateCreation;
    
    @Column(name = "date_paiement")
    private LocalDate datePaiement;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut")
    private PenaliteStatut statut = PenaliteStatut.IMPAYEE;
    
    @Column(name = "notes")
    private String notes;
    
    // Constructeurs
    public Penalite() {
        this.dateCreation = LocalDateTime.now();
    }
    
    public Penalite(TypePenalite typePenalite, Adherent adherent, BigDecimal montantFinal) {
        this();
        this.typePenalite = typePenalite;
        this.adherent = adherent;
        this.montantFinal = montantFinal;
    }
    
    // Getters et Setters
    public Long getIdPenalite() {
        return idPenalite;
    }
    
    public void setIdPenalite(Long idPenalite) {
        this.idPenalite = idPenalite;
    }
    
    public TypePenalite getTypePenalite() {
        return typePenalite;
    }
    
    public void setTypePenalite(TypePenalite typePenalite) {
        this.typePenalite = typePenalite;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public Pret getPret() {
        return pret;
    }
    
    public void setPret(Pret pret) {
        this.pret = pret;
    }
    
    public Utilisateur getBibliothecaire() {
        return bibliothecaire;
    }
    
    public void setBibliothecaire(Utilisateur bibliothecaire) {
        this.bibliothecaire = bibliothecaire;
    }
    
    public BigDecimal getMontantCalcule() {
        return montantCalcule;
    }
    
    public void setMontantCalcule(BigDecimal montantCalcule) {
        this.montantCalcule = montantCalcule;
    }
    
    public BigDecimal getMontantFinal() {
        return montantFinal;
    }
    
    public void setMontantFinal(BigDecimal montantFinal) {
        this.montantFinal = montantFinal;
    }
    
    public LocalDate getDateDebutSuspension() {
        return dateDebutSuspension;
    }
    
    public void setDateDebutSuspension(LocalDate dateDebutSuspension) {
        this.dateDebutSuspension = dateDebutSuspension;
    }
    
    public LocalDate getDateFinSuspension() {
        return dateFinSuspension;
    }
    
    public void setDateFinSuspension(LocalDate dateFinSuspension) {
        this.dateFinSuspension = dateFinSuspension;
    }
    
    public LocalDateTime getDateCreation() {
        return dateCreation;
    }
    
    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
    
    public LocalDate getDatePaiement() {
        return datePaiement;
    }
    
    public void setDatePaiement(LocalDate datePaiement) {
        this.datePaiement = datePaiement;
    }
    
    public PenaliteStatut getStatut() {
        return statut;
    }
    
    public void setStatut(PenaliteStatut statut) {
        this.statut = statut;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    @Override
    public String toString() {
        return "Penalite{" +
                "idPenalite=" + idPenalite +
                ", montantFinal=" + montantFinal +
                ", statut=" + statut +
                '}';
    }
} 
package com.example.biblio.entity;

import com.example.biblio.entity.enums.PretStatut;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "pret")
public class Pret {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pret")
    private Long idPret;
    
    @Column(name = "numero_pret", nullable = false, unique = true, length = 20)
    private String numeroPret;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire exemplaire;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_bibliothecaire", nullable = false)
    private Utilisateur bibliothecaire;
    
    @Column(name = "date_pret")
    private LocalDate datePret;
    
    @Column(name = "date_retour_prevue", nullable = false)
    private LocalDate dateRetourPrevue;
    
    @Column(name = "date_retour_effective")
    private LocalDate dateRetourEffective;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut")
    private PretStatut statut = PretStatut.EN_COURS;
    
    @Column(name = "notes_pret")
    private String notesPret;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Relations
    @OneToMany(mappedBy = "pret", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ProlongationPret> prolongations;
    
    @OneToMany(mappedBy = "pret")
    private List<Penalite> penalites;
    
    // Constructeurs
    public Pret() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.datePret = LocalDate.now();
    }
    
    public Pret(String numeroPret, Adherent adherent, Exemplaire exemplaire, Utilisateur bibliothecaire) {
        this();
        this.numeroPret = numeroPret;
        this.adherent = adherent;
        this.exemplaire = exemplaire;
        this.bibliothecaire = bibliothecaire;
    }
    
    // Getters et Setters
    public Long getIdPret() {
        return idPret;
    }
    
    public void setIdPret(Long idPret) {
        this.idPret = idPret;
    }
    
    public String getNumeroPret() {
        return numeroPret;
    }
    
    public void setNumeroPret(String numeroPret) {
        this.numeroPret = numeroPret;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public Exemplaire getExemplaire() {
        return exemplaire;
    }
    
    public void setExemplaire(Exemplaire exemplaire) {
        this.exemplaire = exemplaire;
    }
    
    public Utilisateur getBibliothecaire() {
        return bibliothecaire;
    }
    
    public void setBibliothecaire(Utilisateur bibliothecaire) {
        this.bibliothecaire = bibliothecaire;
    }
    
    public LocalDate getDatePret() {
        return datePret;
    }
    
    public void setDatePret(LocalDate datePret) {
        this.datePret = datePret;
    }
    
    public LocalDate getDateRetourPrevue() {
        return dateRetourPrevue;
    }
    
    public void setDateRetourPrevue(LocalDate dateRetourPrevue) {
        this.dateRetourPrevue = dateRetourPrevue;
    }
    
    public LocalDate getDateRetourEffective() {
        return dateRetourEffective;
    }
    
    public void setDateRetourEffective(LocalDate dateRetourEffective) {
        this.dateRetourEffective = dateRetourEffective;
    }
    
    public PretStatut getStatut() {
        return statut;
    }
    
    public void setStatut(PretStatut statut) {
        this.statut = statut;
    }
    
    public String getNotesPret() {
        return notesPret;
    }
    
    public void setNotesPret(String notesPret) {
        this.notesPret = notesPret;
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
    
    public List<ProlongationPret> getProlongations() {
        return prolongations;
    }
    
    public void setProlongations(List<ProlongationPret> prolongations) {
        this.prolongations = prolongations;
    }
    
    public List<Penalite> getPenalites() {
        return penalites;
    }
    
    public void setPenalites(List<Penalite> penalites) {
        this.penalites = penalites;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Pret{" +
                "idPret=" + idPret +
                ", numeroPret='" + numeroPret + '\'' +
                ", statut=" + statut +
                '}';
    }
} 
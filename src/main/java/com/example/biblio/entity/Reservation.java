package com.example.biblio.entity;

import com.example.biblio.entity.enums.ReservationStatut;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
public class Reservation {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reservation")
    private Long idReservation;
    
    @Column(name = "numero_reservation", nullable = false, unique = true, length = 20)
    private String numeroReservation;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @Column(name = "date_reservation")
    private LocalDateTime dateReservation;
    
    @Column(name = "date_expiration", nullable = false)
    private LocalDate dateExpiration;
    
    @Column(name = "priorite")
    private Integer priorite = 1;
    
    @Column(name = "position_file", nullable = false)
    private Integer positionFile;
    
    @Column(name = "date_notification")
    private LocalDateTime dateNotification;
    
    @Column(name = "date_retrait_limite")
    private LocalDateTime dateRetraitLimite;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut")
    private ReservationStatut statut = ReservationStatut.EN_ATTENTE;
    
    @Column(name = "notes")
    private String notes;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructeurs
    public Reservation() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.dateReservation = LocalDateTime.now();
    }
    
    public Reservation(String numeroReservation, Adherent adherent, Livre livre, LocalDate dateExpiration) {
        this();
        this.numeroReservation = numeroReservation;
        this.adherent = adherent;
        this.livre = livre;
        this.dateExpiration = dateExpiration;
    }
    
    // Getters et Setters
    public Long getIdReservation() {
        return idReservation;
    }
    
    public void setIdReservation(Long idReservation) {
        this.idReservation = idReservation;
    }
    
    public String getNumeroReservation() {
        return numeroReservation;
    }
    
    public void setNumeroReservation(String numeroReservation) {
        this.numeroReservation = numeroReservation;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public LocalDateTime getDateReservation() {
        return dateReservation;
    }
    
    public void setDateReservation(LocalDateTime dateReservation) {
        this.dateReservation = dateReservation;
    }
    
    public LocalDate getDateExpiration() {
        return dateExpiration;
    }
    
    public void setDateExpiration(LocalDate dateExpiration) {
        this.dateExpiration = dateExpiration;
    }
    
    public Integer getPriorite() {
        return priorite;
    }
    
    public void setPriorite(Integer priorite) {
        this.priorite = priorite;
    }
    
    public Integer getPositionFile() {
        return positionFile;
    }
    
    public void setPositionFile(Integer positionFile) {
        this.positionFile = positionFile;
    }
    
    public LocalDateTime getDateNotification() {
        return dateNotification;
    }
    
    public void setDateNotification(LocalDateTime dateNotification) {
        this.dateNotification = dateNotification;
    }
    
    public LocalDateTime getDateRetraitLimite() {
        return dateRetraitLimite;
    }
    
    public void setDateRetraitLimite(LocalDateTime dateRetraitLimite) {
        this.dateRetraitLimite = dateRetraitLimite;
    }
    
    public ReservationStatut getStatut() {
        return statut;
    }
    
    public void setStatut(ReservationStatut statut) {
        this.statut = statut;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
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
        return "Reservation{" +
                "idReservation=" + idReservation +
                ", numeroReservation='" + numeroReservation + '\'' +
                ", statut=" + statut +
                '}';
    }
} 
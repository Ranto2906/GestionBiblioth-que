package com.example.biblio.entity;

import com.example.biblio.entity.enums.AdherentStatut;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "adherent")
public class Adherent {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_adherent")
    private Long idAdherent;
    
    @Column(name = "nom", nullable = false, length = 50)
    private String nom;
    
    @Column(name = "prenom", nullable = false, length = 50)
    private String prenom;
    
    @Column(name = "email", nullable = false, unique = true, length = 100)
    private String email;
    
    @Column(name = "password", nullable = false, length = 255)
    private String password;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_type_utilisateur", nullable = false)
    private TypeUtilisateur typeUtilisateur;
    
    @Column(name = "date_inscription")
    private LocalDate dateInscription;
    
    @Column(name = "date_expiration_adhesion", nullable = false)
    private LocalDate dateExpirationAdhesion;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut")
    private AdherentStatut statut = AdherentStatut.ACTIF;
    
    @Column(name = "preferences_notification", columnDefinition = "json")
    private String preferencesNotification;
    
    @Column(name = "date_fin_suspension")
    private LocalDate dateFinSuspension;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Relations
    @OneToMany(mappedBy = "adherent")
    private List<Pret> prets;
    
    @OneToMany(mappedBy = "adherent")
    private List<Reservation> reservations;
    
    @OneToMany(mappedBy = "adherent")
    private List<Penalite> penalites;
    
    @OneToMany(mappedBy = "adherent")
    private List<Notification> notifications;
    
    @OneToOne(mappedBy = "adherent")
    private Utilisateur utilisateur;
    
    // Constructeurs
    public Adherent() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.dateInscription = LocalDate.now();
    }
    
    public Adherent(String nom, String prenom, String email, String password, TypeUtilisateur typeUtilisateur) {
        this();
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.password = password;
        this.typeUtilisateur = typeUtilisateur;
    }
    
    // Getters et Setters
    public Long getIdAdherent() {
        return idAdherent;
    }
    
    public void setIdAdherent(Long idAdherent) {
        this.idAdherent = idAdherent;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getPrenom() {
        return prenom;
    }
    
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public TypeUtilisateur getTypeUtilisateur() {
        return typeUtilisateur;
    }
    
    public void setTypeUtilisateur(TypeUtilisateur typeUtilisateur) {
        this.typeUtilisateur = typeUtilisateur;
    }
    
    public LocalDate getDateInscription() {
        return dateInscription;
    }
    
    public void setDateInscription(LocalDate dateInscription) {
        this.dateInscription = dateInscription;
    }
    
    public LocalDate getDateExpirationAdhesion() {
        return dateExpirationAdhesion;
    }
    
    public void setDateExpirationAdhesion(LocalDate dateExpirationAdhesion) {
        this.dateExpirationAdhesion = dateExpirationAdhesion;
    }
    
    public AdherentStatut getStatut() {
        return statut;
    }
    
    public void setStatut(AdherentStatut statut) {
        this.statut = statut;
    }
    
    public String getPreferencesNotification() {
        return preferencesNotification;
    }
    
    public void setPreferencesNotification(String preferencesNotification) {
        this.preferencesNotification = preferencesNotification;
    }
    
    public LocalDate getDateFinSuspension() {
        return dateFinSuspension;
    }
    
    public void setDateFinSuspension(LocalDate dateFinSuspension) {
        this.dateFinSuspension = dateFinSuspension;
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
    
    public List<Pret> getPrets() {
        return prets;
    }
    
    public void setPrets(List<Pret> prets) {
        this.prets = prets;
    }
    
    public List<Reservation> getReservations() {
        return reservations;
    }
    
    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }
    
    public List<Penalite> getPenalites() {
        return penalites;
    }
    
    public void setPenalites(List<Penalite> penalites) {
        this.penalites = penalites;
    }
    
    public List<Notification> getNotifications() {
        return notifications;
    }
    
    public void setNotifications(List<Notification> notifications) {
        this.notifications = notifications;
    }
    
    public Utilisateur getUtilisateur() {
        return utilisateur;
    }
    
    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
    
    public String getNomComplet() {
        return prenom + " " + nom;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Adherent{" +
                "idAdherent=" + idAdherent +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                ", statut=" + statut +
                '}';
    }
} 
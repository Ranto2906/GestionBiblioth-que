package com.example.biblio.entity;

import com.example.biblio.entity.enums.NotificationType;
import com.example.biblio.entity.enums.NotificationStatut;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notification")
public class Notification {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_notification")
    private Long idNotification;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent adherent;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "type_notification", nullable = false)
    private NotificationType typeNotification;
    
    @Column(name = "titre", nullable = false, length = 100)
    private String titre;
    
    @Column(name = "contenu", nullable = false)
    private String contenu;
    
    @Column(name = "date_creation")
    private LocalDateTime dateCreation;
    
    @Column(name = "date_envoi")
    private LocalDateTime dateEnvoi;
    
    @Column(name = "date_lecture")
    private LocalDateTime dateLecture;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "statut")
    private NotificationStatut statut = NotificationStatut.EN_ATTENTE;
    
    @Column(name = "canal_envoi", length = 20)
    private String canalEnvoi = "email";
    
    @Column(name = "id_objet_lie")
    private Integer idObjetLie;
    
    @Column(name = "type_objet_lie", length = 20)
    private String typeObjetLie;
    
    // Constructeurs
    public Notification() {
        this.dateCreation = LocalDateTime.now();
    }
    
    public Notification(Adherent adherent, NotificationType typeNotification, String titre, String contenu) {
        this();
        this.adherent = adherent;
        this.typeNotification = typeNotification;
        this.titre = titre;
        this.contenu = contenu;
    }
    
    // Getters et Setters
    public Long getIdNotification() {
        return idNotification;
    }
    
    public void setIdNotification(Long idNotification) {
        this.idNotification = idNotification;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public NotificationType getTypeNotification() {
        return typeNotification;
    }
    
    public void setTypeNotification(NotificationType typeNotification) {
        this.typeNotification = typeNotification;
    }
    
    public String getTitre() {
        return titre;
    }
    
    public void setTitre(String titre) {
        this.titre = titre;
    }
    
    public String getContenu() {
        return contenu;
    }
    
    public void setContenu(String contenu) {
        this.contenu = contenu;
    }
    
    public LocalDateTime getDateCreation() {
        return dateCreation;
    }
    
    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
    
    public LocalDateTime getDateEnvoi() {
        return dateEnvoi;
    }
    
    public void setDateEnvoi(LocalDateTime dateEnvoi) {
        this.dateEnvoi = dateEnvoi;
    }
    
    public LocalDateTime getDateLecture() {
        return dateLecture;
    }
    
    public void setDateLecture(LocalDateTime dateLecture) {
        this.dateLecture = dateLecture;
    }
    
    public NotificationStatut getStatut() {
        return statut;
    }
    
    public void setStatut(NotificationStatut statut) {
        this.statut = statut;
    }
    
    public String getCanalEnvoi() {
        return canalEnvoi;
    }
    
    public void setCanalEnvoi(String canalEnvoi) {
        this.canalEnvoi = canalEnvoi;
    }
    
    public Integer getIdObjetLie() {
        return idObjetLie;
    }
    
    public void setIdObjetLie(Integer idObjetLie) {
        this.idObjetLie = idObjetLie;
    }
    
    public String getTypeObjetLie() {
        return typeObjetLie;
    }
    
    public void setTypeObjetLie(String typeObjetLie) {
        this.typeObjetLie = typeObjetLie;
    }
    
    @Override
    public String toString() {
        return "Notification{" +
                "idNotification=" + idNotification +
                ", typeNotification=" + typeNotification +
                ", titre='" + titre + '\'' +
                ", statut=" + statut +
                '}';
    }
} 
package com.example.biblio.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "type_utilisateur")
public class TypeUtilisateur {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_type_utilisateur")
    private Long idTypeUtilisateur;
    
    @Column(name = "code_type", nullable = false, unique = true, length = 20)
    private String codeType;
    
    @Column(name = "nom_type", nullable = false, length = 50)
    private String nomType;
    
    @Column(name = "duree_emprunt_jours", nullable = false)
    private Integer dureeEmpruntJours = 15;
    
    @Column(name = "nombre_emprunts_max", nullable = false)
    private Integer nombreEmpruntsMax = 5;
    
    @Column(name = "nombre_renouvellements_max", nullable = false)
    private Integer nombreRenouvellementsMax = 2;
    
    @Column(name = "priorite_reservation")
    private Integer prioriteReservation = 1;
    
    @Column(name = "peut_reserver")
    private Boolean peutReserver = true;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    // Relations
    @OneToMany(mappedBy = "typeUtilisateur")
    private List<Adherent> adherents;
    
    // Constructeurs
    public TypeUtilisateur() {
        this.createdAt = LocalDateTime.now();
    }
    
    public TypeUtilisateur(String codeType, String nomType) {
        this();
        this.codeType = codeType;
        this.nomType = nomType;
    }
    
    // Getters et Setters
    public Long getIdTypeUtilisateur() {
        return idTypeUtilisateur;
    }
    
    public void setIdTypeUtilisateur(Long idTypeUtilisateur) {
        this.idTypeUtilisateur = idTypeUtilisateur;
    }
    
    public String getCodeType() {
        return codeType;
    }
    
    public void setCodeType(String codeType) {
        this.codeType = codeType;
    }
    
    public String getNomType() {
        return nomType;
    }
    
    public void setNomType(String nomType) {
        this.nomType = nomType;
    }
    
    public Integer getDureeEmpruntJours() {
        return dureeEmpruntJours;
    }
    
    public void setDureeEmpruntJours(Integer dureeEmpruntJours) {
        this.dureeEmpruntJours = dureeEmpruntJours;
    }
    
    public Integer getNombreEmpruntsMax() {
        return nombreEmpruntsMax;
    }
    
    public void setNombreEmpruntsMax(Integer nombreEmpruntsMax) {
        this.nombreEmpruntsMax = nombreEmpruntsMax;
    }
    
    public Integer getNombreRenouvellementsMax() {
        return nombreRenouvellementsMax;
    }
    
    public void setNombreRenouvellementsMax(Integer nombreRenouvellementsMax) {
        this.nombreRenouvellementsMax = nombreRenouvellementsMax;
    }
    
    public Integer getPrioriteReservation() {
        return prioriteReservation;
    }
    
    public void setPrioriteReservation(Integer prioriteReservation) {
        this.prioriteReservation = prioriteReservation;
    }
    
    public Boolean getPeutReserver() {
        return peutReserver;
    }
    
    public void setPeutReserver(Boolean peutReserver) {
        this.peutReserver = peutReserver;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public List<Adherent> getAdherents() {
        return adherents;
    }
    
    public void setAdherents(List<Adherent> adherents) {
        this.adherents = adherents;
    }
    
    @Override
    public String toString() {
        return "TypeUtilisateur{" +
                "idTypeUtilisateur=" + idTypeUtilisateur +
                ", codeType='" + codeType + '\'' +
                ", nomType='" + nomType + '\'' +
                ", dureeEmpruntJours=" + dureeEmpruntJours +
                ", nombreEmpruntsMax=" + nombreEmpruntsMax +
                ", actif=" + actif +
                '}';
    }
} 
package com.example.biblio.entity;

import com.example.biblio.entity.enums.UtilisateurRole;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateur")
public class Utilisateur {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_utilisateur")
    private Long idUtilisateur;
    
    @Column(name = "username", nullable = false, unique = true, length = 50)
    private String username;
    
    @Column(name = "password", nullable = false, length = 255)
    private String password;
    
    @Column(name = "email", nullable = false, unique = true, length = 100)
    private String email;
    
    @Column(name = "nom", nullable = false, length = 50)
    private String nom;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private UtilisateurRole role;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_type_utilisateur")
    private TypeUtilisateur typeUtilisateur;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_adherent")
    private Adherent adherent;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    @Column(name = "derniere_connexion")
    private LocalDateTime derniereConnexion;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructeurs
    public Utilisateur() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
    
    public Utilisateur(String username, String password, String email, String nom, UtilisateurRole role) {
        this();
        this.username = username;
        this.password = password;
        this.email = email;
        this.nom = nom;
        this.role = role;
    }
    
    // Getters et Setters
    public Long getIdUtilisateur() {
        return idUtilisateur;
    }
    
    public void setIdUtilisateur(Long idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public UtilisateurRole getRole() {
        return role;
    }
    
    public void setRole(UtilisateurRole role) {
        this.role = role;
    }
    
    public TypeUtilisateur getTypeUtilisateur() {
        return typeUtilisateur;
    }
    
    public void setTypeUtilisateur(TypeUtilisateur typeUtilisateur) {
        this.typeUtilisateur = typeUtilisateur;
    }
    
    public Adherent getAdherent() {
        return adherent;
    }
    
    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public LocalDateTime getDerniereConnexion() {
        return derniereConnexion;
    }
    
    public void setDerniereConnexion(LocalDateTime derniereConnexion) {
        this.derniereConnexion = derniereConnexion;
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
        return "Utilisateur{" +
                "idUtilisateur=" + idUtilisateur +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", nom='" + nom + '\'' +
                ", role=" + role +
                ", actif=" + actif +
                '}';
    }
} 
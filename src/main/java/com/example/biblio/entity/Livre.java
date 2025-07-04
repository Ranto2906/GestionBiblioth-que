package com.example.biblio.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "livre")
public class Livre {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_livre")
    private Long idLivre;
    
    @Column(name = "titre", nullable = false, length = 200)
    private String titre;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_editeur", nullable = false)
    private Editeur editeur;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_langue", nullable = false)
    private Langue langue;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_genre", nullable = false)
    private Genre genre;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_emplacement", nullable = false)
    private Emplacement emplacement;
    
    @Column(name = "annee_publication", nullable = false)
    private Integer anneePublication;
    
    @Column(name = "nombre_pages")
    private Integer nombrePages;
    
    @Column(name = "prix_remplacement", precision = 10, scale = 2)
    private BigDecimal prixRemplacement = new BigDecimal("20.00");
    
    @Column(name = "date_acquisition")
    private LocalDate dateAcquisition;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Relations
    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LivreAuteur> auteurs;
    
    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Exemplaire> exemplaires;
    
    @OneToMany(mappedBy = "livre")
    private List<Reservation> reservations;
    
    @OneToMany(mappedBy = "livre")
    private List<StatistiqueEmprunt> statistiques;
    
    // Constructeurs
    public Livre() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.dateAcquisition = LocalDate.now();
    }
    
    public Livre(String titre, Editeur editeur, Langue langue, Genre genre, 
                 Emplacement emplacement, Integer anneePublication) {
        this();
        this.titre = titre;
        this.editeur = editeur;
        this.langue = langue;
        this.genre = genre;
        this.emplacement = emplacement;
        this.anneePublication = anneePublication;
    }
    
    // Getters et Setters
    public Long getIdLivre() {
        return idLivre;
    }
    
    public void setIdLivre(Long idLivre) {
        this.idLivre = idLivre;
    }
    
    public String getTitre() {
        return titre;
    }
    
    public void setTitre(String titre) {
        this.titre = titre;
    }
    
    public Editeur getEditeur() {
        return editeur;
    }
    
    public void setEditeur(Editeur editeur) {
        this.editeur = editeur;
    }
    
    public Langue getLangue() {
        return langue;
    }
    
    public void setLangue(Langue langue) {
        this.langue = langue;
    }
    
    public Genre getGenre() {
        return genre;
    }
    
    public void setGenre(Genre genre) {
        this.genre = genre;
    }
    
    public Emplacement getEmplacement() {
        return emplacement;
    }
    
    public void setEmplacement(Emplacement emplacement) {
        this.emplacement = emplacement;
    }
    
    public Integer getAnneePublication() {
        return anneePublication;
    }
    
    public void setAnneePublication(Integer anneePublication) {
        this.anneePublication = anneePublication;
    }
    
    public Integer getNombrePages() {
        return nombrePages;
    }
    
    public void setNombrePages(Integer nombrePages) {
        this.nombrePages = nombrePages;
    }
    
    public BigDecimal getPrixRemplacement() {
        return prixRemplacement;
    }
    
    public void setPrixRemplacement(BigDecimal prixRemplacement) {
        this.prixRemplacement = prixRemplacement;
    }
    
    public LocalDate getDateAcquisition() {
        return dateAcquisition;
    }
    
    public void setDateAcquisition(LocalDate dateAcquisition) {
        this.dateAcquisition = dateAcquisition;
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
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public List<LivreAuteur> getAuteurs() {
        return auteurs;
    }
    
    public void setAuteurs(List<LivreAuteur> auteurs) {
        this.auteurs = auteurs;
    }
    
    public List<Exemplaire> getExemplaires() {
        return exemplaires;
    }
    
    public void setExemplaires(List<Exemplaire> exemplaires) {
        this.exemplaires = exemplaires;
    }
    
    public List<Reservation> getReservations() {
        return reservations;
    }
    
    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }
    
    public List<StatistiqueEmprunt> getStatistiques() {
        return statistiques;
    }
    
    public void setStatistiques(List<StatistiqueEmprunt> statistiques) {
        this.statistiques = statistiques;
    }
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Livre{" +
                "idLivre=" + idLivre +
                ", titre='" + titre + '\'' +
                ", anneePublication=" + anneePublication +
                ", nombrePages=" + nombrePages +
                ", actif=" + actif +
                '}';
    }
} 
package com.example.biblio.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "genre")
public class Genre {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_genre")
    private Long idGenre;
    
    @Column(name = "nom_genre", nullable = false, unique = true, length = 50)
    private String nomGenre;
    
    @Column(name = "description")
    private String description;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "genre_parent")
    private Genre genreParent;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    // Relations
    @OneToMany(mappedBy = "genre")
    private List<Livre> livres;
    
    @OneToMany(mappedBy = "genreParent")
    private List<Genre> sousGenres;
    
    // Constructeurs
    public Genre() {}
    
    public Genre(String nomGenre) {
        this.nomGenre = nomGenre;
    }
    
    // Getters et Setters
    public Long getIdGenre() {
        return idGenre;
    }
    
    public void setIdGenre(Long idGenre) {
        this.idGenre = idGenre;
    }
    
    public String getNomGenre() {
        return nomGenre;
    }
    
    public void setNomGenre(String nomGenre) {
        this.nomGenre = nomGenre;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Genre getGenreParent() {
        return genreParent;
    }
    
    public void setGenreParent(Genre genreParent) {
        this.genreParent = genreParent;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public List<Livre> getLivres() {
        return livres;
    }
    
    public void setLivres(List<Livre> livres) {
        this.livres = livres;
    }
    
    public List<Genre> getSousGenres() {
        return sousGenres;
    }
    
    public void setSousGenres(List<Genre> sousGenres) {
        this.sousGenres = sousGenres;
    }
    
    @Override
    public String toString() {
        return "Genre{" +
                "idGenre=" + idGenre +
                ", nomGenre='" + nomGenre + '\'' +
                ", description='" + description + '\'' +
                ", actif=" + actif +
                '}';
    }
} 
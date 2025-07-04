package com.example.biblio.entity;

import com.example.biblio.entity.enums.ExemplaireEtat;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_exemplaire")
    private Long idExemplaire;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @Column(name = "code_barre", nullable = false, unique = true, length = 50)
    private String codeBarre;
    
    @Column(name = "numero_exemplaire", nullable = false)
    private Integer numeroExemplaire;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "etat")
    private ExemplaireEtat etat = ExemplaireEtat.BON;
    
    @Column(name = "disponible")
    private Boolean disponible = true;
    
    @Column(name = "date_acquisition")
    private LocalDate dateAcquisition;
    
    @Column(name = "provenance", length = 50)
    private String provenance = "achat";
    
    @Column(name = "prix_achat", precision = 10, scale = 2)
    private BigDecimal prixAchat;
    
    @Column(name = "notes_etat")
    private String notesEtat;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Relations
    @OneToMany(mappedBy = "exemplaire")
    private List<Pret> prets;
    
    // Constructeurs
    public Exemplaire() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.dateAcquisition = LocalDate.now();
    }
    
    public Exemplaire(Livre livre, String codeBarre, Integer numeroExemplaire) {
        this();
        this.livre = livre;
        this.codeBarre = codeBarre;
        this.numeroExemplaire = numeroExemplaire;
    }
    
    // Getters et Setters
    public Long getIdExemplaire() {
        return idExemplaire;
    }
    
    public void setIdExemplaire(Long idExemplaire) {
        this.idExemplaire = idExemplaire;
    }
    
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public String getCodeBarre() {
        return codeBarre;
    }
    
    public void setCodeBarre(String codeBarre) {
        this.codeBarre = codeBarre;
    }
    
    public Integer getNumeroExemplaire() {
        return numeroExemplaire;
    }
    
    public void setNumeroExemplaire(Integer numeroExemplaire) {
        this.numeroExemplaire = numeroExemplaire;
    }
    
    public ExemplaireEtat getEtat() {
        return etat;
    }
    
    public void setEtat(ExemplaireEtat etat) {
        this.etat = etat;
    }
    
    public Boolean getDisponible() {
        return disponible;
    }
    
    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }
    
    public LocalDate getDateAcquisition() {
        return dateAcquisition;
    }
    
    public void setDateAcquisition(LocalDate dateAcquisition) {
        this.dateAcquisition = dateAcquisition;
    }
    
    public String getProvenance() {
        return provenance;
    }
    
    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }
    
    public BigDecimal getPrixAchat() {
        return prixAchat;
    }
    
    public void setPrixAchat(BigDecimal prixAchat) {
        this.prixAchat = prixAchat;
    }
    
    public String getNotesEtat() {
        return notesEtat;
    }
    
    public void setNotesEtat(String notesEtat) {
        this.notesEtat = notesEtat;
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
    
    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Exemplaire{" +
                "idExemplaire=" + idExemplaire +
                ", codeBarre='" + codeBarre + '\'' +
                ", numeroExemplaire=" + numeroExemplaire +
                ", etat=" + etat +
                ", disponible=" + disponible +
                ", provenance='" + provenance + '\'' +
                '}';
    }
} 
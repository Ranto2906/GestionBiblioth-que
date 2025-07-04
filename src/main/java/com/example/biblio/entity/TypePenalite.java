package com.example.biblio.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.List;

@Entity
@Table(name = "type_penalite")
public class TypePenalite {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_type_penalite")
    private Long idTypePenalite;
    
    @Column(name = "code_type", nullable = false, unique = true, length = 50)
    private String codeType;
    
    @Column(name = "libelle", nullable = false, length = 100)
    private String libelle;
    
    @Column(name = "montant_base", precision = 10, scale = 2)
    private BigDecimal montantBase = BigDecimal.ZERO;
    
    @Column(name = "duree_suspension_jours")
    private Integer dureeSuspensionJours = 0;
    
    @Column(name = "est_cumulable")
    private Boolean estCumulable = false;
    
    @Column(name = "actif")
    private Boolean actif = true;
    
    @Column(name = "description")
    private String description;
    
    // Relations
    @OneToMany(mappedBy = "typePenalite")
    private List<Penalite> penalites;
    
    // Constructeurs
    public TypePenalite() {}
    
    public TypePenalite(String codeType, String libelle) {
        this.codeType = codeType;
        this.libelle = libelle;
    }
    
    public TypePenalite(String codeType, String libelle, BigDecimal montantBase) {
        this(codeType, libelle);
        this.montantBase = montantBase;
    }
    
    // Getters et Setters
    public Long getIdTypePenalite() {
        return idTypePenalite;
    }
    
    public void setIdTypePenalite(Long idTypePenalite) {
        this.idTypePenalite = idTypePenalite;
    }
    
    public String getCodeType() {
        return codeType;
    }
    
    public void setCodeType(String codeType) {
        this.codeType = codeType;
    }
    
    public String getLibelle() {
        return libelle;
    }
    
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
    
    public BigDecimal getMontantBase() {
        return montantBase;
    }
    
    public void setMontantBase(BigDecimal montantBase) {
        this.montantBase = montantBase;
    }
    
    public Integer getDureeSuspensionJours() {
        return dureeSuspensionJours;
    }
    
    public void setDureeSuspensionJours(Integer dureeSuspensionJours) {
        this.dureeSuspensionJours = dureeSuspensionJours;
    }
    
    public Boolean getEstCumulable() {
        return estCumulable;
    }
    
    public void setEstCumulable(Boolean estCumulable) {
        this.estCumulable = estCumulable;
    }
    
    public Boolean getActif() {
        return actif;
    }
    
    public void setActif(Boolean actif) {
        this.actif = actif;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public List<Penalite> getPenalites() {
        return penalites;
    }
    
    public void setPenalites(List<Penalite> penalites) {
        this.penalites = penalites;
    }
    
    @Override
    public String toString() {
        return "TypePenalite{" +
                "idTypePenalite=" + idTypePenalite +
                ", codeType='" + codeType + '\'' +
                ", libelle='" + libelle + '\'' +
                ", montantBase=" + montantBase +
                '}';
    }
} 
package com.bibliotheque.app.models.suivi;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import com.bibliotheque.app.models.bibliographie.Exemplaire;
import com.bibliotheque.app.models.utilisateur.Personnel;
import com.bibliotheque.app.models.pret.Pret;
import com.bibliotheque.app.models.pret.Reservation;

@Entity
@Table(name = "statut_exemplaire")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StatutExemplaire {
    
    public enum Statut {
        DISPONIBLE(1, "Disponible"),
        EMPRUNTE(0, "Emprunté");
        
        private final int code;
        private final String libelle;
        
        Statut(int code, String libelle) {
            this.code = code;
            this.libelle = libelle;
        }
        
        public int getCode() { return code; }
        public String getLibelle() { return libelle; }
        
        public static Statut fromCode(int code) {
            for (Statut s : values()) {
                if (s.code == code) return s;
            }
            return DISPONIBLE;
        }
    }
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_changement")
    private LocalDateTime dateChangement;
    
    private String notes;

    @ManyToOne
    @JoinColumn(name = "exemplaire_id")
    private Exemplaire exemplaire;

    @Column(name = "statut")
    private Integer statut;

    @ManyToOne
    @JoinColumn(name = "admin_id")
    private Personnel admin;

    @ManyToOne
    @JoinColumn(name = "pret_id")
    private Pret pret;

    @ManyToOne
    @JoinColumn(name = "reservation_id")
    private Reservation reservation;
    
    public Statut getStatutEnum() {
        return Statut.fromCode(this.statut != null ? this.statut : 1);
    }
    
    public void setStatutEnum(Statut statut) {
        this.statut = statut.getCode();
    }
} 
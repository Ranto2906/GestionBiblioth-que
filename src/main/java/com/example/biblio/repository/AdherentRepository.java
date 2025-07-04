package com.example.biblio.repository;

import com.example.biblio.entity.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AdherentRepository extends JpaRepository<Adherent, Long> {
    
    /**
     * Trouve un adhérent par son email
     */
    Optional<Adherent> findByEmail(String email);
    

    
    /**
     * Trouve tous les adhérents par statut
     */
    List<Adherent> findByStatut(com.example.biblio.entity.enums.AdherentStatut statut);
    
        // List<Utilisateur> findByTypeUtilisateur(com.example.biblio.entity.TypeUtilisateur typeUtilisateur);

    /**
     * Vérifie si un email existe déjà
     */
    boolean existsByEmail(String email);
    
    /**
     * Recherche d'adhérents par nom ou prénom (recherche partielle)
     */
    @Query("SELECT a FROM Adherent a WHERE LOWER(a.nom) LIKE LOWER(CONCAT('%', :recherche, '%')) OR LOWER(a.prenom) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<Adherent> findByNomOrPrenomContainingIgnoreCase(@Param("recherche") String recherche);
} 
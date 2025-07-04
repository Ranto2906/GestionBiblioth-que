package com.example.biblio.repository;

import com.example.biblio.entity.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    
    /**
     * Trouve un utilisateur par son nom d'utilisateur
     */
    Optional<Utilisateur> findByUsername(String username);
    
    /**
     * Trouve un utilisateur par son nom d'utilisateur et mot de passe
     */
    Optional<Utilisateur> findByUsernameAndPassword(String username, String password);
    
    /**
     * Trouve un utilisateur par son email
     */
    Optional<Utilisateur> findByEmail(String email);
    
    /**
     * Trouve tous les utilisateurs actifs
     */
    List<Utilisateur> findByActifTrue();
    
    /**
     * Trouve tous les utilisateurs par rôle
     */
    List<Utilisateur> findByRole(com.example.biblio.entity.enums.UtilisateurRole role);
    
    /**
     * Vérifie si un nom d'utilisateur existe déjà
     */
    boolean existsByUsername(String username);
    
    /**
     * Vérifie si un email existe déjà
     */
    boolean existsByEmail(String email);
    
        /**
     * Recherche d'utilisateurs par nom (recherche partielle)
     */
    @Query("SELECT u FROM Utilisateur u WHERE LOWER(u.nom) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<Utilisateur> findByNomContainingIgnoreCase(@Param("recherche") String recherche);
    
    /**
     * Trouve tous les utilisateurs par type d'utilisateur
     */
    List<Utilisateur> findByTypeUtilisateur(com.example.biblio.entity.TypeUtilisateur typeUtilisateur);
    
 
} 
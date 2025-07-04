package com.example.biblio.repository;

import com.example.biblio.entity.TypeUtilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TypeUtilisateurRepository extends JpaRepository<TypeUtilisateur, Long> {
    
    /**
     * Trouve un type d'utilisateur par son code
     */
    Optional<TypeUtilisateur> findByCodeType(String codeType);
    
    /**
     * Trouve tous les types d'utilisateur actifs
     */
    List<TypeUtilisateur> findByActifTrue();
    
    /**
     * Vérifie si un code de type existe déjà
     */
    boolean existsByCodeType(String codeType);
    
    /**
     * Trouve un type d'utilisateur par son nom
     */
    Optional<TypeUtilisateur> findByNomType(String nomType);
} 
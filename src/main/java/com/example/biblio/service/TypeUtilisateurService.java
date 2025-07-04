package com.example.biblio.service;

import com.example.biblio.entity.TypeUtilisateur;
import com.example.biblio.repository.TypeUtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TypeUtilisateurService {
    
    @Autowired
    private TypeUtilisateurRepository typeUtilisateurRepository;
    
    /**
     * Trouve un type d'utilisateur par son code
     */
    public Optional<TypeUtilisateur> findByCodeType(String codeType) {
        return typeUtilisateurRepository.findByCodeType(codeType);
    }
    
    /**
     * Trouve un type d'utilisateur par son ID
     */
    public Optional<TypeUtilisateur> findById(Long id) {
        return typeUtilisateurRepository.findById(id);
    }
    
    /**
     * Sauvegarde un type d'utilisateur
     */
    public TypeUtilisateur save(TypeUtilisateur typeUtilisateur) {
        return typeUtilisateurRepository.save(typeUtilisateur);
    }
    
    /**
     * Trouve tous les types d'utilisateur actifs
     */
    public List<TypeUtilisateur> findAllActive() {
        return typeUtilisateurRepository.findByActifTrue();
    }
    
    /**
     * Trouve tous les types d'utilisateur
     */
    public List<TypeUtilisateur> findAll() {
        return typeUtilisateurRepository.findAll();
    }
    
    /**
     * Vérifie si un code de type existe déjà
     */
    public boolean codeTypeExists(String codeType) {
        return typeUtilisateurRepository.existsByCodeType(codeType);
    }
    
    /**
     * Trouve un type d'utilisateur par son nom
     */
    public Optional<TypeUtilisateur> findByNomType(String nomType) {
        return typeUtilisateurRepository.findByNomType(nomType);
    }
    
    /**
     * Désactive un type d'utilisateur
     */
    public void deactivateTypeUtilisateur(Long id) {
        typeUtilisateurRepository.findById(id).ifPresent(type -> {
            type.setActif(false);
            typeUtilisateurRepository.save(type);
        });
    }
    
    /**
     * Active un type d'utilisateur
     */
    public void activateTypeUtilisateur(Long id) {
        typeUtilisateurRepository.findById(id).ifPresent(type -> {
            type.setActif(true);
            typeUtilisateurRepository.save(type);
        });
    }
} 
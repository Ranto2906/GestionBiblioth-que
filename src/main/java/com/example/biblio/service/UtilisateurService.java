package com.example.biblio.service;

import com.example.biblio.entity.Utilisateur;
import com.example.biblio.entity.enums.UtilisateurRole;
import com.example.biblio.repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UtilisateurService {
    
    @Autowired
    private UtilisateurRepository utilisateurRepository;
    
    /**
     * Authentifie un utilisateur avec nom d'utilisateur et mot de passe
     */
    public Optional<Utilisateur> authenticate(String username, String password) {
        return utilisateurRepository.findByUsernameAndPassword(username, password)
                .filter(utilisateur -> utilisateur.getActif());
    }
    
    /**
     * Trouve un utilisateur par son nom d'utilisateur
     */
    public Optional<Utilisateur> findByUsername(String username) {
        return utilisateurRepository.findByUsername(username);
    }
    
    /**
     * Trouve un utilisateur par son email
     */
    public Optional<Utilisateur> findByEmail(String email) {
        return utilisateurRepository.findByEmail(email);
    }
    
    /**
     * Trouve un utilisateur par son ID
     */
    public Optional<Utilisateur> findById(Long id) {
        return utilisateurRepository.findById(id);
    }
    
    /**
     * Sauvegarde un utilisateur
     */
    public Utilisateur save(Utilisateur utilisateur) {
        return utilisateurRepository.save(utilisateur);
    }
    
    /**
     * Trouve tous les utilisateurs actifs
     */
    public List<Utilisateur> findAllActive() {
        return utilisateurRepository.findByActifTrue();
    }
    
    /**
     * Trouve tous les utilisateurs par rôle
     */
    public List<Utilisateur> findByRole(UtilisateurRole role) {
        return utilisateurRepository.findByRole(role);
    }
    
    /**
     * Vérifie si un nom d'utilisateur existe déjà
     */
    public boolean usernameExists(String username) {
        return utilisateurRepository.existsByUsername(username);
    }
    
    /**
     * Vérifie si un email existe déjà
     */
    public boolean emailExists(String email) {
        return utilisateurRepository.existsByEmail(email);
    }
    
    /**
     * Recherche d'utilisateurs par nom
     */
    public List<Utilisateur> searchByNom(String recherche) {
        return utilisateurRepository.findByNomContainingIgnoreCase(recherche);
    }
    
    /**
     * Trouve tous les utilisateurs par type d'utilisateur
     */
    public List<Utilisateur> findByTypeUtilisateur(com.example.biblio.entity.TypeUtilisateur typeUtilisateur) {
        return utilisateurRepository.findByTypeUtilisateur(typeUtilisateur);
    }
    
    /**
     * Désactive un utilisateur
     */
    public void deactivateUtilisateur(Long id) {
        utilisateurRepository.findById(id).ifPresent(utilisateur -> {
            utilisateur.setActif(false);
            utilisateurRepository.save(utilisateur);
        });
    }
    
    /**
     * Active un utilisateur
     */
    public void activateUtilisateur(Long id) {
        utilisateurRepository.findById(id).ifPresent(utilisateur -> {
            utilisateur.setActif(true);
            utilisateurRepository.save(utilisateur);
        });
    }
    
    /**
     * Change le rôle d'un utilisateur
     */
    public void changeRole(Long id, UtilisateurRole role) {
        utilisateurRepository.findById(id).ifPresent(utilisateur -> {
            utilisateur.setRole(role);
            utilisateurRepository.save(utilisateur);
        });
    }
} 
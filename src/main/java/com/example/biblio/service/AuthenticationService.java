package com.example.biblio.service;

import com.example.biblio.entity.Adherent;
import com.example.biblio.entity.Utilisateur;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthenticationService {
    
    @Autowired
    private AdherentService adherentService;
    
    @Autowired
    private UtilisateurService utilisateurService;
    
    /**
     * Authentifie un adhérent avec email et mot de passe
     * L'authentification se fait via l'entité Utilisateur liée à l'Adherent
     */
    public Optional<Adherent> authenticateAdherent(String email, String password) {
        // Trouve d'abord l'adhérent par email
        Optional<Adherent> adherentOpt = adherentService.findActiveByEmail(email);
        
        if (adherentOpt.isPresent()) {
            Adherent adherent = adherentOpt.get();
            
            // Vérifie si l'adhérent a un compte utilisateur associé
            if (adherent.getUtilisateur() != null) {
                Utilisateur utilisateur = adherent.getUtilisateur();
                
                // Vérifie les credentials
                if (utilisateur.getUsername().equals(email) && 
                    utilisateur.getPassword().equals(password) && 
                    utilisateur.getActif()) {
                    return Optional.of(adherent);
                }
            }
        }
        
        return Optional.empty();
    }
    
    /**
     * Authentifie un utilisateur avec nom d'utilisateur et mot de passe
     */
    public Optional<Utilisateur> authenticateUtilisateur(String username, String password) {
        return utilisateurService.authenticate(username, password);
    }
} 
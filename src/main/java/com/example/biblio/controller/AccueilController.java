package com.example.biblio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccueilController {
    
    /**
     * Page d'accueil
     */
    @GetMapping("/")
    public String accueil() {
        return "index";
    }
    
    /**
     * Page de connexion adhérent (GET)
     */
    @GetMapping("/login-adherent")
    public String loginAdherent() {
        return "login-adherent";
    }
    
    /**
     * Page de connexion utilisateur (GET)
     */
    @GetMapping("/login-utilisateur")
    public String loginUtilisateur() {
        return "login-utilisateur";
    }
} 
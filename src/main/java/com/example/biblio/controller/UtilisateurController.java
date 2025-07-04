package com.example.biblio.controller;

import com.example.biblio.entity.Utilisateur;
import com.example.biblio.service.UtilisateurService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/utilisateur")
public class UtilisateurController {
    
    @Autowired
    private UtilisateurService utilisateurService;
    
    /**
     * Traitement de la connexion utilisateur (POST)
     */
    @PostMapping("/login")
    public String login(@RequestParam String username, 
                       @RequestParam String password,
                       HttpSession session,
                       Model model,
                       RedirectAttributes redirectAttributes) {
        
        try {
            // Authentification
            Optional<Utilisateur> utilisateurOpt = utilisateurService.authenticate(username, password);
            
            if (utilisateurOpt.isPresent()) {
                Utilisateur utilisateur = utilisateurOpt.get();
                
                // Stockage en session
                session.setAttribute("utilisateur", utilisateur);
                session.setAttribute("userType", "utilisateur");
                session.setAttribute("userId", utilisateur.getIdUtilisateur());
                session.setAttribute("userName", utilisateur.getNom());
                session.setAttribute("userRole", utilisateur.getRole());
                
                // Redirection vers le dashboard utilisateur
                return "redirect:/utilisateur/dashboard";
                
            } else {
                // Échec de l'authentification
                model.addAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
                return "login-utilisateur";
            }
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la connexion: " + e.getMessage());
            return "login-utilisateur";
        }
    }
    
    /**
     * Dashboard utilisateur
     */
    @RequestMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Vérification de la session
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        model.addAttribute("utilisateur", utilisateur);
        return "utilisateur/dashboard";
    }
    
    /**
     * Déconnexion utilisateur
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "Vous avez été déconnecté avec succès");
        return "redirect:/";
    }
    
    /**
     * Profil utilisateur
     */
    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        // Récupération des données à jour
        Optional<Utilisateur> utilisateurOpt = utilisateurService.findById(utilisateur.getIdUtilisateur());
        if (utilisateurOpt.isPresent()) {
            model.addAttribute("utilisateur", utilisateurOpt.get());
        }
        
        return "utilisateur/profile";
    }
    
    /**
     * Gestion des adhérents (pour les administrateurs)
     */
    @RequestMapping("/adherents")
    public String gestionAdherents(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        // Vérification des droits d'administration
        if (utilisateur.getRole() != com.example.biblio.entity.enums.UtilisateurRole.ADMIN) {
            model.addAttribute("error", "Accès non autorisé");
            return "utilisateur/dashboard";
        }
        
        return "utilisateur/gestion-adherents";
    }
} 
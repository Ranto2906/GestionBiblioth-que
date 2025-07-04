package com.example.biblio.controller;

import com.example.biblio.entity.Adherent;
import com.example.biblio.service.AdherentService;
import com.example.biblio.service.AuthenticationService;
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
@RequestMapping("/adherent")
public class AdherentController {
    
    @Autowired
    private AdherentService adherentService;
    
    @Autowired
    private AuthenticationService authenticationService;
    
    /**
     * Traitement de la connexion adhérent (POST)
     */
    @PostMapping("/login")
    public String login(@RequestParam String email, 
                       @RequestParam String password,
                       HttpSession session,
                       Model model,
                       RedirectAttributes redirectAttributes) {
        
        try {
            // Authentification
            Optional<Adherent> adherentOpt = authenticationService.authenticateAdherent(email, password);
            
            if (adherentOpt.isPresent()) {
                Adherent adherent = adherentOpt.get();
                
                // Stockage en session
                session.setAttribute("adherent", adherent);
                session.setAttribute("userType", "adherent");
                session.setAttribute("userId", adherent.getIdAdherent());
                session.setAttribute("userName", adherent.getNom() + " " + adherent.getPrenom());
                
                // Redirection vers le dashboard adhérent
                return "redirect:/adherent/dashboard";
                
            } else {
                // Échec de l'authentification
                model.addAttribute("error", "Email ou mot de passe incorrect");
                return "login-adherent";
            }
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la connexion: " + e.getMessage());
            return "login-adherent";
        }
    }
    
    /**
     * Dashboard adhérent
     */
    @RequestMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Vérification de la session
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        
        model.addAttribute("adherent", adherent);
        return "adherent/dashboard";
    }
    
    /**
     * Déconnexion adhérent
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "Vous avez été déconnecté avec succès");
        return "redirect:/";
    }
    
    /**
     * Profil adhérent
     */
    @RequestMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Adherent adherent = (Adherent) session.getAttribute("adherent");
        if (adherent == null) {
            return "redirect:/login-adherent";
        }
        
        // Récupération des données à jour
        Optional<Adherent> adherentOpt = adherentService.findById(adherent.getIdAdherent());
        if (adherentOpt.isPresent()) {
            model.addAttribute("adherent", adherentOpt.get());
        }
        
        return "adherent/profile";
    }
} 
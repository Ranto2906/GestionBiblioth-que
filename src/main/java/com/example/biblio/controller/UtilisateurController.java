package com.example.biblio.controller;

import com.example.biblio.entity.Utilisateur;
import com.example.biblio.service.UtilisateurService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/utilisateur")
public class UtilisateurController {
    
    @Autowired
    private UtilisateurService utilisateurService;
    
    /**
     * Affichage de la page de connexion utilisateur (GET)
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "login-utilisateur";
    }
    
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
                session.setAttribute("userRole", utilisateur.getRole().name());
                
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
    
    /**
     * Gestion des emprunts
     */
    @RequestMapping("/emprunts")
    public String gestionEmprunts(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        // TODO: Récupérer tous les emprunts
        // List<Pret> emprunts = pretService.findAll();
        // model.addAttribute("emprunts", emprunts);
        
        return "utilisateur/gestion-emprunts";
    }
    
    /**
     * Gestion des réservations
     */
    @RequestMapping("/reservations")
    public String gestionReservations(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        // TODO: Récupérer toutes les réservations
        // List<Reservation> reservations = reservationService.findAll();
        // model.addAttribute("reservations", reservations);
        
        return "utilisateur/gestion-reservations";
    }
    
    /**
     * Catalogue des livres
     */
    @RequestMapping("/catalogue")
    public String catalogue(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        // TODO: Récupérer le catalogue des livres
        // List<Livre> livres = livreService.findAll();
        // model.addAttribute("livres", livres);
        
        return "utilisateur/catalogue";
    }
    
    /**
     * Nouvel emprunt
     */
    @RequestMapping("/emprunt/nouveau")
    public String nouvelEmprunt(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        return "utilisateur/nouvel-emprunt";
    }
    
    /**
     * Retour de livre
     */
    @RequestMapping("/retour")
    public String retourLivre(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        return "utilisateur/retour-livre";
    }
    
    /**
     * Nouvel adhérent
     */
    @RequestMapping("/adherent/nouveau")
    public String nouvelAdherent(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        return "utilisateur/nouvel-adherent";
    }
    
    /**
     * Recherche
     */
    @RequestMapping("/recherche")
    public String recherche(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login-utilisateur";
        }
        
        return "utilisateur/recherche";
    }
} 
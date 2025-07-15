package com.bibliotheque.app.controllers.bibliographie;

import com.bibliotheque.app.models.bibliographie.Livre;
import com.bibliotheque.app.models.bibliographie.Exemplaire;
import com.bibliotheque.app.services.bibliographie.LivreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

@RestController
@RequestMapping("/api/livres")
@CrossOrigin(origins = "*")
public class LivreApiController {

    @Autowired
    private LivreService livreService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getLivreDetails(@PathVariable Long id) {
        try {
            Livre livre = livreService.findById(id);
            if (livre == null) {
                return ResponseEntity.notFound().build();
            }

            List<Exemplaire> exemplaires = livre.getExemplaires();
            long nombreTotal = exemplaires.size();
            long nombreDisponible = exemplaires.stream()
                    .filter(ex -> !ex.getStatutExemplaires().isEmpty() && 
                            ex.getStatutExemplaires().get(ex.getStatutExemplaires().size() - 1)
                            .getStatutEnum().getLibelle().equalsIgnoreCase("disponible"))
                    .count();

            Map<String, Object> response = new HashMap<>();
            response.put("id", livre.getId());
            response.put("titre", livre.getTitre());
            response.put("isbn", livre.getIsbn());
            response.put("anneePublication", livre.getAnneePublication());
            response.put("nombrePages", livre.getNombrePages());
            response.put("limitAge", livre.getLimitAge());
            response.put("resume", livre.getResume());
            
            // Informations sur l'auteur
            if (livre.getAuteur() != null) {
                Map<String, Object> auteur = new HashMap<>();
                auteur.put("id", livre.getAuteur().getId());
                auteur.put("nom", livre.getAuteur().getNom());
                auteur.put("prenom", livre.getAuteur().getPrenom());
                response.put("auteur", auteur);
            }

            // Informations sur l'éditeur
            if (livre.getEditeur() != null) {
                Map<String, Object> editeur = new HashMap<>();
                editeur.put("id", livre.getEditeur().getId());
                editeur.put("nom", livre.getEditeur().getNom());
                response.put("editeur", editeur);
            }

            // Informations sur les catégories
            response.put("categories", livre.getCategories().stream()
                    .map(cat -> {
                        Map<String, Object> catMap = new HashMap<>();
                        catMap.put("id", cat.getId());
                        catMap.put("nom", cat.getNom());
                        return catMap;
                    })
                    .toList());

            // Statistiques des exemplaires
            Map<String, Object> exemplairesStats = new HashMap<>();
            exemplairesStats.put("nombreTotal", nombreTotal);
            exemplairesStats.put("nombreDisponible", nombreDisponible);
            
            // Liste détaillée des exemplaires
            exemplairesStats.put("liste", exemplaires.stream()
                    .map(ex -> {
                        Map<String, Object> exMap = new HashMap<>();
                        exMap.put("id", ex.getId());
                        exMap.put("reference", ex.getReference());
                        String statut = "Non défini";
                        if (!ex.getStatutExemplaires().isEmpty()) {
                            statut = ex.getStatutExemplaires()
                                    .get(ex.getStatutExemplaires().size() - 1)
                                    .getStatutEnum().getLibelle();
                        }
                        exMap.put("statut", statut);
                        return exMap;
                    })
                    .toList());
            
            response.put("exemplaires", exemplairesStats);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "Erreur lors de la récupération des détails du livre: " + e.getMessage()));
        }
    }
} 
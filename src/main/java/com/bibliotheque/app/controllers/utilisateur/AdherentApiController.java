package com.bibliotheque.app.controllers.utilisateur;

import com.bibliotheque.app.models.utilisateur.Adherent;
import com.bibliotheque.app.models.gestion.Abonnement;
import com.bibliotheque.app.models.suivi.Penalite;
import com.bibliotheque.app.services.utilisateur.AdherentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Comparator;

@RestController
@RequestMapping("/api/adherents")
@CrossOrigin(origins = "*")
public class AdherentApiController {

    @Autowired
    private AdherentService adherentService;

    @GetMapping("/{numeroAdherent}")
    public ResponseEntity<?> getAdherentDetails(@PathVariable String numeroAdherent) {
        try {
            Adherent adherent = adherentService.findByNumeroAdherent(numeroAdherent);
            if (adherent == null) {
                return ResponseEntity.notFound().build();
            }

            Map<String, Object> response = new HashMap<>();
            
            // Informations de base de l'adhérent
            response.put("id", adherent.getId());
            response.put("numeroAdherent", adherent.getNumeroAdherent());
            response.put("nom", adherent.getNom());
            response.put("prenom", adherent.getPrenom());
            response.put("email", adherent.getEmail());
            response.put("telephone", adherent.getTelephone());
            response.put("dateInscription", adherent.getDateInscription());

            // Informations sur le profil et les quotas
            if (adherent.getProfil() != null && adherent.getProfil().getConfigurationQuotas() != null 
                && !adherent.getProfil().getConfigurationQuotas().isEmpty()) {
                var configQuota = adherent.getProfil().getConfigurationQuotas().stream()
                    .max(Comparator.comparing(cq -> cq.getDateConfiguration()))
                    .get();
                
                Map<String, Object> quotas = new HashMap<>();
                quotas.put("quotaTotalPret", configQuota.getQuotaPret());
                quotas.put("quotaTotalReservation", configQuota.getQuotaReservation());
                quotas.put("dureeMaxPret", configQuota.getDureeMaxPret());
                
                // Calcul des quotas restants
                long nombrePretsEnCours = adherent.getPrets().stream()
                    .filter(pret -> pret.getDateRetourEffectuer() == null)
                    .count();
                
                // Pour les réservations, on vérifie s'il existe une validation avec validationStatus = true
                long nombreReservationsEnCours = adherent.getReservations().stream()
                    .filter(res -> res.getDateExpiration().isAfter(LocalDate.now().atStartOfDay()))
                    .count();
                
                quotas.put("quotaRestantPret", configQuota.getQuotaPret() - nombrePretsEnCours);
                quotas.put("quotaRestantReservation", configQuota.getQuotaReservation() - nombreReservationsEnCours);
                
                response.put("quotas", quotas);
            }

            // Informations sur l'abonnement en cours
            if (adherent.getAbonnements() != null && !adherent.getAbonnements().isEmpty()) {
                Abonnement abonnementEnCours = adherent.getAbonnements().stream()
                    .filter(ab -> ab.getDateFin().isAfter(LocalDate.now()))
                    .max(Comparator.comparing(Abonnement::getDateFin))
                    .orElse(null);

                if (abonnementEnCours != null) {
                    Map<String, Object> abonnement = new HashMap<>();
                    abonnement.put("dateDebut", abonnementEnCours.getDateDebut());
                    abonnement.put("dateFin", abonnementEnCours.getDateFin());
                    abonnement.put("montantPaye", abonnementEnCours.getMontantPaye());
                    
                    if (abonnementEnCours.getTypeAbonnement() != null) {
                        Map<String, Object> typeAbonnement = new HashMap<>();
                        typeAbonnement.put("code", abonnementEnCours.getTypeAbonnement().getCode());
                        typeAbonnement.put("libelle", abonnementEnCours.getTypeAbonnement().getLibelle());
                        typeAbonnement.put("dureeMois", abonnementEnCours.getTypeAbonnement().getDureeMois());
                        typeAbonnement.put("montant", abonnementEnCours.getTypeAbonnement().getMontant());
                        typeAbonnement.put("conditions", abonnementEnCours.getTypeAbonnement().getConditions());
                        abonnement.put("type", typeAbonnement);
                    }
                    
                    response.put("abonnement", abonnement);
                }
            }

            // Informations sur les sanctions
            if (adherent.getPenalites() != null) {
                Map<String, Object> sanctions = new HashMap<>();
                
                // Nombre total de sanctions
                sanctions.put("nombreTotal", adherent.getPenalites().size());
                
                // Sanctions en cours (non expirées et non annulées)
                List<Penalite> sanctionsEnCours = adherent.getPenalites().stream()
                    .filter(p -> p.getDateAnnulation() == null && 
                           (p.getDateFin() == null || p.getDateFin().isAfter(LocalDate.now())))
                    .toList();
                
                sanctions.put("nombreEnCours", sanctionsEnCours.size());
                
                // Détails des sanctions en cours
                sanctions.put("sanctionsEnCours", sanctionsEnCours.stream()
                    .map(p -> {
                        Map<String, Object> sanction = new HashMap<>();
                        sanction.put("dateApplication", p.getDateApplication());
                        sanction.put("dateFin", p.getDateFin());
                        sanction.put("notes", p.getNotes());
                        
                        if (p.getTypePenalite() != null) {
                            Map<String, Object> typePenalite = new HashMap<>();
                            typePenalite.put("code", p.getTypePenalite().getCode());
                            typePenalite.put("description", p.getTypePenalite().getDescription());
                            typePenalite.put("dureeJours", p.getTypePenalite().getDureeJours());
                            typePenalite.put("retardJours", p.getTypePenalite().getRetardJours());
                            sanction.put("type", typePenalite);
                        }
                        
                        return sanction;
                    })
                    .toList());
                
                response.put("sanctions", sanctions);
            }

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "Erreur lors de la récupération des détails de l'adhérent: " + e.getMessage()));
        }
    }
} 
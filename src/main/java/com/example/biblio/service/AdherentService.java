package com.example.biblio.service;

import com.example.biblio.entity.Adherent;
import com.example.biblio.entity.enums.AdherentStatut;
import com.example.biblio.repository.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdherentService {
    
    @Autowired
    private AdherentRepository adherentRepository;
    
    /**
     * Trouve un adhérent actif par son email
     */
    public Optional<Adherent> findActiveByEmail(String email) {
        return adherentRepository.findByEmail(email)
                .filter(adherent -> adherent.getStatut() == AdherentStatut.ACTIF);
    }
    
    /**
     * Trouve un adhérent par son email
     */
    public Optional<Adherent> findByEmail(String email) {
        return adherentRepository.findByEmail(email);
    }
    
    /**
     * Trouve un adhérent par son ID
     */
    public Optional<Adherent> findById(Long id) {
        return adherentRepository.findById(id);
    }
    
    /**
     * Sauvegarde un adhérent
     */
    public Adherent save(Adherent adherent) {
        return adherentRepository.save(adherent);
    }
    
    /**
     * Trouve tous les adhérents actifs
     */
    public List<Adherent> findAllActive() {
        return adherentRepository.findByStatut(AdherentStatut.ACTIF);
    }
    
    /**
     * Trouve tous les adhérents par statut
     */
    public List<Adherent> findByStatut(AdherentStatut statut) {
        return adherentRepository.findByStatut(statut);
    }
    
    /**
     * Vérifie si un email existe déjà
     */
    public boolean emailExists(String email) {
        return adherentRepository.existsByEmail(email);
    }
    

    
    /**
     * Recherche d'adhérents par nom ou prénom
     */
    public List<Adherent> searchByNomOrPrenom(String recherche) {
        return adherentRepository.findByNomOrPrenomContainingIgnoreCase(recherche);
    }
    
    /**
     * Désactive un adhérent
     */
    public void deactivateAdherent(Long id) {
        adherentRepository.findById(id).ifPresent(adherent -> {
            adherent.setStatut(AdherentStatut.SUSPENDU);
            adherentRepository.save(adherent);
        });
    }
    
    /**
     * Active un adhérent
     */
    public void activateAdherent(Long id) {
        adherentRepository.findById(id).ifPresent(adherent -> {
            adherent.setStatut(AdherentStatut.ACTIF);
            adherentRepository.save(adherent);
        });
    }
    
    /**
     * Change le statut d'un adhérent
     */
    public void changeStatut(Long id, AdherentStatut statut) {
        adherentRepository.findById(id).ifPresent(adherent -> {
            adherent.setStatut(statut);
            adherentRepository.save(adherent);
        });
    }
} 
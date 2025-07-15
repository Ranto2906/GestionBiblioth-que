package com.bibliotheque.app.services.utilisateur;

import com.bibliotheque.app.models.utilisateur.Adherent;
import com.bibliotheque.app.repositories.utilisateur.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdherentService {
    @Autowired
    private AdherentRepository adherentRepository;

    public List<Adherent> findAll() { return adherentRepository.findAll(); }
    public Adherent findById(Long id) { return adherentRepository.findById(id).orElse(null); }
    public Adherent findByNumeroAdherent(String numeroAdherent) { return adherentRepository.findByNumeroAdherent(numeroAdherent).orElse(null); }
    public Adherent save(Adherent adherent) { return adherentRepository.save(adherent); }
    public void deleteById(Long id) { adherentRepository.deleteById(id); }
} 
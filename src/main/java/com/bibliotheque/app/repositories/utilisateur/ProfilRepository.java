package com.bibliotheque.app.repositories.utilisateur;

import com.bibliotheque.app.models.utilisateur.Profil;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfilRepository extends JpaRepository<Profil, Long> {} 
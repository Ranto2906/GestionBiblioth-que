-- Active: 1751649895095@@127.0.0.1@5432@gestion_bibliotheque@public
-- Script PostgreSQL amélioré pour la bibliothèque de livres
-- Basé sur l'analyse métier complète

-- 1. Création des types ENUM (améliorés)
CREATE TYPE abonnement_niveau AS ENUM ('gratuit', 'basique', 'premium');
CREATE TYPE privilege_categorie AS ENUM ('emprunt', 'reservation', 'penalite', 'acces');
CREATE TYPE adherent_statut AS ENUM ('actif', 'suspendu', 'expire', 'radie', 'en_attente');
CREATE TYPE utilisateur_role AS ENUM ('admin', 'bibliothecaire', 'responsable', 'adherent');
CREATE TYPE livre_auteur_role AS ENUM ('auteur_principal', 'co_auteur', 'traducteur', 'illustrateur', 'editeur_scientifique');
CREATE TYPE exemplaire_etat AS ENUM ('neuf', 'bon', 'moyen', 'abime', 'en_reparation', 'retire', 'perdu');
CREATE TYPE pret_statut AS ENUM ('en_cours', 'rendu', 'en_retard', 'perdu');
CREATE TYPE prolongation_statut AS ENUM ('acceptee', 'refusee', 'en_attente');
CREATE TYPE adherent_abonnement_statut AS ENUM ('actif', 'expire', 'suspendu');
CREATE TYPE reservation_statut AS ENUM ('en_attente', 'notifie', 'satisfaite', 'annulee', 'expiree');
CREATE TYPE penalite_statut AS ENUM ('impayee', 'payee', 'annulee', 'remise');
CREATE TYPE penalite_type AS ENUM ('retard', 'degradation', 'perte', 'autre');
CREATE TYPE notification_type AS ENUM ('reservation_disponible', 'retour_imminent', 'retard', 'penalite', 'nouveaute');
CREATE TYPE notification_statut AS ENUM ('en_attente', 'envoye', 'lu', 'echec');

-- 2. Tables de référence et paramétrage

CREATE TABLE langue (
  id_langue SERIAL PRIMARY KEY,
  code_langue VARCHAR(3) NOT NULL UNIQUE,
  nom_langue VARCHAR(50) NOT NULL,
  actif BOOLEAN DEFAULT TRUE
);

CREATE TABLE genre (
  id_genre SERIAL PRIMARY KEY,
  nom_genre VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  genre_parent INTEGER REFERENCES genre(id_genre),
  actif BOOLEAN DEFAULT TRUE
);

CREATE TABLE editeur (
  id_editeur SERIAL PRIMARY KEY,
  nom_editeur VARCHAR(100) NOT NULL UNIQUE,
  pays VARCHAR(50) NOT NULL,
  ville VARCHAR(50),
  actif BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE emplacement (
  id_emplacement SERIAL PRIMARY KEY,
  code_emplacement VARCHAR(20) NOT NULL UNIQUE,
  description VARCHAR(100) NOT NULL,
  section VARCHAR(50) NOT NULL,
  rayon VARCHAR(20),
  etagere VARCHAR(20),
  actif BOOLEAN DEFAULT TRUE
);

-- 3. Paramétrage système (NOUVEAU - point clé de l'analyse)
CREATE TABLE parametre_systeme (
  id_parametre SERIAL PRIMARY KEY,
  code_parametre VARCHAR(50) NOT NULL UNIQUE,
  nom_parametre VARCHAR(100) NOT NULL,
  valeur_parametre VARCHAR(500) NOT NULL,
  type_parametre VARCHAR(20) NOT NULL, -- integer, decimal, string, boolean, date
  description TEXT,
  modifiable BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Gestion des utilisateurs (améliorée)
CREATE TABLE type_utilisateur (
  id_type_utilisateur SERIAL PRIMARY KEY,
  code_type VARCHAR(20) NOT NULL UNIQUE,
  nom_type VARCHAR(50) NOT NULL,
  duree_emprunt_jours INTEGER NOT NULL DEFAULT 15,
  nombre_emprunts_max INTEGER NOT NULL DEFAULT 5,
  nombre_renouvellements_max INTEGER NOT NULL DEFAULT 2,
  priorite_reservation INTEGER DEFAULT 1,
  peut_reserver BOOLEAN DEFAULT TRUE,
  actif BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE adherent (
  id_adherent SERIAL PRIMARY KEY,
  numero_adherent VARCHAR(20) NOT NULL UNIQUE,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telephone VARCHAR(15) NOT NULL,
  adresse VARCHAR(200) NOT NULL,
  ville VARCHAR(50) NOT NULL,
  code_postal VARCHAR(10) NOT NULL,
  date_naissance DATE,
  id_type_utilisateur INTEGER NOT NULL,
  date_inscription DATE DEFAULT CURRENT_DATE,
  date_expiration_adhesion DATE NOT NULL,
  statut adherent_statut DEFAULT 'actif',
  photo_profil VARCHAR(255),
  preferences_notification JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_type_utilisateur) REFERENCES type_utilisateur(id_type_utilisateur)
);

CREATE TABLE utilisateur (
  id_utilisateur SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  role utilisateur_role NOT NULL,
  id_adherent INTEGER,
  actif BOOLEAN DEFAULT TRUE,
  derniere_connexion TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent)
);

-- 5. Gestion des livres (distinction livre/exemplaire renforcée)
CREATE TABLE auteur (
  id_auteur SERIAL PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  nationalite VARCHAR(50),
  date_naissance DATE,
  date_deces DATE,
  biographie TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livre (
  id_livre SERIAL PRIMARY KEY,
  isbn VARCHAR(13) UNIQUE,
  titre VARCHAR(200) NOT NULL,
  sous_titre VARCHAR(200),
  id_editeur INTEGER NOT NULL,
  id_langue INTEGER NOT NULL,
  id_genre INTEGER NOT NULL,
  id_emplacement INTEGER NOT NULL,
  annee_publication INTEGER NOT NULL,
  nombre_pages INTEGER,
  resume TEXT,
  table_matieres TEXT,
  mots_cles TEXT[],
  prix_remplacement DECIMAL(10,2) DEFAULT 20.00,
  date_acquisition DATE DEFAULT CURRENT_DATE,
  image_couverture VARCHAR(255),
  actif BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_editeur) REFERENCES editeur(id_editeur),
  FOREIGN KEY (id_langue) REFERENCES langue(id_langue),
  FOREIGN KEY (id_genre) REFERENCES genre(id_genre),
  FOREIGN KEY (id_emplacement) REFERENCES emplacement(id_emplacement)
);

CREATE TABLE livre_auteur (
  id_livre INTEGER NOT NULL,
  id_auteur INTEGER NOT NULL,
  role_auteur livre_auteur_role DEFAULT 'auteur_principal',
  ordre_auteur INTEGER DEFAULT 1,
  PRIMARY KEY (id_livre, id_auteur),
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre) ON DELETE CASCADE,
  FOREIGN KEY (id_auteur) REFERENCES auteur(id_auteur)
);

CREATE TABLE exemplaire (
  id_exemplaire SERIAL PRIMARY KEY,
  id_livre INTEGER NOT NULL,
  code_barre VARCHAR(50) NOT NULL UNIQUE,
  numero_exemplaire INTEGER NOT NULL,
  etat exemplaire_etat DEFAULT 'bon',
  disponible BOOLEAN DEFAULT TRUE,
  date_acquisition DATE DEFAULT CURRENT_DATE,
  provenance VARCHAR(50) DEFAULT 'achat', -- achat, don, echange
  prix_achat DECIMAL(10,2),
  notes_etat TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre) ON DELETE CASCADE
);

-- 6. Gestion des prêts (processus complet)
CREATE TABLE pret (
  id_pret SERIAL PRIMARY KEY,
  numero_pret VARCHAR(20) NOT NULL UNIQUE,
  id_adherent INTEGER NOT NULL,
  id_exemplaire INTEGER NOT NULL,
  id_bibliothecaire INTEGER NOT NULL,
  date_pret DATE DEFAULT CURRENT_DATE,
  date_retour_prevue DATE NOT NULL,
  date_retour_effective DATE,
  statut pret_statut DEFAULT 'en_cours',
  notes_pret TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent),
  FOREIGN KEY (id_exemplaire) REFERENCES exemplaire(id_exemplaire),
  FOREIGN KEY (id_bibliothecaire) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE prolongation_pret (
  id_prolongation SERIAL PRIMARY KEY,
  id_pret INTEGER NOT NULL,
  date_demande DATE DEFAULT CURRENT_DATE,
  nouvelle_date_retour DATE NOT NULL,
  statut prolongation_statut NOT NULL,
  id_bibliothecaire INTEGER,
  motif_refus TEXT,
  automatique BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_pret) REFERENCES pret(id_pret) ON DELETE CASCADE,
  FOREIGN KEY (id_bibliothecaire) REFERENCES utilisateur(id_utilisateur)
);

-- 7. Système de réservation (amélioré)
CREATE TABLE reservation (
  id_reservation SERIAL PRIMARY KEY,
  numero_reservation VARCHAR(20) NOT NULL UNIQUE,
  id_adherent INTEGER NOT NULL,
  id_livre INTEGER NOT NULL,
  date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_expiration DATE NOT NULL,
  priorite INTEGER DEFAULT 1,
  position_file INTEGER NOT NULL,
  date_notification TIMESTAMP,
  date_retrait_limite TIMESTAMP,
  statut reservation_statut DEFAULT 'en_attente',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent),
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre)
);

-- 8. Système de pénalités (complet)
CREATE TABLE penalite (
  id_penalite SERIAL PRIMARY KEY,
  numero_penalite VARCHAR(20) NOT NULL UNIQUE,
  id_adherent INTEGER NOT NULL,
  id_pret INTEGER,
  type_penalite penalite_type NOT NULL,
  montant_base DECIMAL(10,2) NOT NULL,
  reduction_appliquee DECIMAL(5,2) DEFAULT 0.00,
  montant_final DECIMAL(10,2) NOT NULL,
  motif VARCHAR(200) NOT NULL,
  date_creation DATE DEFAULT CURRENT_DATE,
  date_paiement DATE,
  statut penalite_statut DEFAULT 'impayee',
  mode_paiement VARCHAR(50),
  id_bibliothecaire INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent),
  FOREIGN KEY (id_pret) REFERENCES pret(id_pret),
  FOREIGN KEY (id_bibliothecaire) REFERENCES utilisateur(id_utilisateur)
);

-- 9. Système de notifications (NOUVEAU)
CREATE TABLE notification (
  id_notification SERIAL PRIMARY KEY,
  id_adherent INTEGER NOT NULL,
  type_notification notification_type NOT NULL,
  titre VARCHAR(100) NOT NULL,
  contenu TEXT NOT NULL,
  date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_envoi TIMESTAMP,
  date_lecture TIMESTAMP,
  statut notification_statut DEFAULT 'en_attente',
  canal_envoi VARCHAR(20) DEFAULT 'email', -- email, sms, push
  id_objet_lie INTEGER, -- ID du prêt, réservation, etc.
  type_objet_lie VARCHAR(20), -- pret, reservation, penalite
  FOREIGN KEY (id_adherent) REFERENCES adherent(id_adherent)
);

-- 10. Statistiques et rapports (NOUVEAU)
CREATE TABLE statistique_emprunt (
  id_statistique SERIAL PRIMARY KEY,
  id_livre INTEGER NOT NULL,
  periode_debut DATE NOT NULL,
  periode_fin DATE NOT NULL,
  nombre_emprunts INTEGER NOT NULL DEFAULT 0,
  nombre_reservations INTEGER NOT NULL DEFAULT 0,
  duree_moyenne_emprunt DECIMAL(5,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre)
);

-- 11. Historique des modifications (NOUVEAU)
CREATE TABLE historique_modification (
  id_historique SERIAL PRIMARY KEY,
  table_concernee VARCHAR(50) NOT NULL,
  id_enregistrement INTEGER NOT NULL,
  action VARCHAR(20) NOT NULL, -- INSERT, UPDATE, DELETE
  anciennes_valeurs JSON,
  nouvelles_valeurs JSON,
  id_utilisateur INTEGER NOT NULL,
  date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- 12. Log des activités (amélioré)
CREATE TABLE log_activite (
  id_log SERIAL PRIMARY KEY,
  id_utilisateur INTEGER NOT NULL,
  action VARCHAR(100) NOT NULL,
  table_concernee VARCHAR(50) NOT NULL,
  details JSON,
  adresse_ip VARCHAR(45),
  user_agent TEXT,
  date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- 13. Gestion des collections (NOUVEAU)
CREATE TABLE collection (
  id_collection SERIAL PRIMARY KEY,
  nom_collection VARCHAR(100) NOT NULL,
  description TEXT,
  id_bibliothecaire INTEGER NOT NULL,
  date_creation DATE DEFAULT CURRENT_DATE,
  actif BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (id_bibliothecaire) REFERENCES utilisateur(id_utilisateur)
);

CREATE TABLE collection_livre (
  id_collection INTEGER NOT NULL,
  id_livre INTEGER NOT NULL,
  date_ajout DATE DEFAULT CURRENT_DATE,
  PRIMARY KEY (id_collection, id_livre),
  FOREIGN KEY (id_collection) REFERENCES collection(id_collection) ON DELETE CASCADE,
  FOREIGN KEY (id_livre) REFERENCES livre(id_livre) ON DELETE CASCADE
);

-- 14. Gestion des fermetures exceptionnelles (NOUVEAU)
CREATE TABLE fermeture_exceptionnelle (
  id_fermeture SERIAL PRIMARY KEY,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  motif VARCHAR(200) NOT NULL,
  prolongation_automatique BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 15. Index pour les performances
CREATE INDEX idx_livre_isbn ON livre(isbn);
CREATE INDEX idx_livre_titre ON livre(titre);
CREATE INDEX idx_livre_auteur ON livre_auteur(id_auteur);
CREATE INDEX idx_exemplaire_code_barre ON exemplaire(code_barre);
CREATE INDEX idx_exemplaire_disponible ON exemplaire(disponible) WHERE disponible = true;
CREATE INDEX idx_pret_adherent ON pret(id_adherent);
CREATE INDEX idx_pret_statut ON pret(statut);
CREATE INDEX idx_pret_date_retour ON pret(date_retour_prevue);
CREATE INDEX idx_reservation_statut ON reservation(statut);
CREATE INDEX idx_reservation_adherent ON reservation(id_adherent);
CREATE INDEX idx_penalite_statut ON penalite(statut);
CREATE INDEX idx_notification_adherent ON notification(id_adherent);
CREATE INDEX idx_notification_statut ON notification(statut);

-- 16. Triggers pour la cohérence des données
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_adherent_timestamp
    BEFORE UPDATE ON adherent
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_livre_timestamp
    BEFORE UPDATE ON livre
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_exemplaire_timestamp
    BEFORE UPDATE ON exemplaire
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_pret_timestamp
    BEFORE UPDATE ON pret
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

-- 17. Fonction pour calculer automatiquement la disponibilité
CREATE OR REPLACE FUNCTION update_exemplaire_disponibilite()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.statut = 'en_cours' THEN
        UPDATE exemplaire 
        SET disponible = FALSE 
        WHERE id_exemplaire = NEW.id_exemplaire;
    ELSIF TG_OP = 'UPDATE' AND OLD.statut = 'en_cours' AND NEW.statut = 'rendu' THEN
        UPDATE exemplaire 
        SET disponible = TRUE 
        WHERE id_exemplaire = NEW.id_exemplaire;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_exemplaire_disponibilite
    AFTER INSERT OR UPDATE ON pret
    FOR EACH ROW
    EXECUTE FUNCTION update_exemplaire_disponibilite();

-- 18. Insertion des données de paramétrage par défaut
INSERT INTO parametre_systeme (code_parametre, nom_parametre, valeur_parametre, type_parametre, description) VALUES
('DUREE_EMPRUNT_DEFAUT', 'Durée d''emprunt par défaut', '15', 'integer', 'Durée en jours'),
('NOMBRE_EMPRUNTS_MAX_DEFAUT', 'Nombre maximum d''emprunts par défaut', '5', 'integer', 'Nombre maximum de livres empruntés simultanément'),
('PENALITE_RETARD_JOUR', 'Pénalité par jour de retard', '0.50', 'decimal', 'Montant en euros'),
('DELAI_RESERVATION_HEURES', 'Délai de retrait d''une réservation', '48', 'integer', 'Délai en heures'),
('RENOUVELLEMENT_MAX', 'Nombre maximum de renouvellements', '2', 'integer', 'Nombre de renouvellements autorisés'),
('NOTIFICATION_RETOUR_JOURS', 'Notification avant retour', '3', 'integer', 'Nombre de jours avant la date de retour'),
('PROLONGATION_AUTO_VACANCES', 'Prolongation automatique pendant les vacances', 'true', 'boolean', 'Prolongation automatique activée');

-- 19. Données de base
INSERT INTO type_utilisateur (code_type, nom_type, duree_emprunt_jours, nombre_emprunts_max, nombre_renouvellements_max) VALUES
('ETUDIANT', 'Étudiant', 15, 5, 2),
('ENSEIGNANT', 'Enseignant', 30, 10, 3),
('EXTERNE', 'Externe', 7, 2, 1),
('VIP', 'VIP/Chercheur', 30, 15, 5);

INSERT INTO langue (code_langue, nom_langue) VALUES
('FR', 'Français'),
('EN', 'Anglais'),
('ES', 'Espagnol'),
('DE', 'Allemand'),
('IT', 'Italien');

INSERT INTO adherent (nom, prenom, email, id_type_utilisateur, date_inscription, date_expiration_adhesion, statut, preferences_notification, actif, created_at, updated_at) 
VALUES 
-- Étudiants
('Dupont', 'Marie', 'marie.dupont@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-01-15', '2025-01-15', 'ACTIF', '{"email": true, "sms": false}', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Martin', 'Pierre', 'pierre.martin@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-02-20', '2025-02-20', 'ACTIF', '{"email": true, "sms": true}', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bernard', 'Sophie', 'sophie.bernard@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-03-10', '2025-03-10', 'ACTIF', '{"email": false, "sms": true}', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Petit', 'Lucas', 'lucas.petit@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-01-05', '2025-01-05', 'SUSPENDU', '{"email": true, "sms": false}', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),


INSERT INTO genre (nom_genre, description) VALUES
('Fiction', 'Romans, nouvelles, littérature'),
('Sciences', 'Ouvrages scientifiques et techniques'),
('Histoire', 'Histoire et géographie'),
('Jeunesse', 'Littérature pour enfants et adolescents'),
('Essais', 'Essais et ouvrages de réflexion'),
('Biographie', 'Biographies et autobiographies'),
('Arts', 'Beaux-arts, musique, cinéma'),
('Cuisine', 'Livres de cuisine et gastronomie'),
('Sport', 'Ouvrages sur le sport et la santé'),
('Informatique', 'Ouvrages techniques informatiques');
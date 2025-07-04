-- Script PostgreSQL pour le système de bibliothèque
-- Création des types ENUM

CREATE TYPE abonnement_niveau AS ENUM ('gratuit', 'basique', 'premium');
CREATE TYPE privilege_categorie AS ENUM ('emprunt', 'reservation', 'penalite', 'acces');
CREATE TYPE adherent_statut AS ENUM ('actif', 'suspendu', 'expire', 'radie', 'en_attente');
CREATE TYPE utilisateur_role AS ENUM ('admin', 'bibliothecaire', 'responsable', 'adherent');
CREATE TYPE livre_auteur_role AS ENUM ('auteur_principal', 'co_auteur', 'traducteur', 'illustrateur', 'editeur_scientifique');
CREATE TYPE exemplaire_etat AS ENUM ('neuf', 'bon', 'moyen', 'abime', 'en_reparation', 'retire', 'perdu');
CREATE TYPE pret_statut AS ENUM ('en_cours', 'rendu', 'en_retard', 'perdu');
CREATE TYPE prolongation_statut AS ENUM ('acceptee', 'refusee', 'en_attente');
CREATE TYPE reservation_statut AS ENUM ('en_attente', 'notifie', 'satisfaite', 'annulee', 'expiree');
CREATE TYPE penalite_statut AS ENUM ('impayee', 'payee', 'annulee', 'remise');
CREATE TYPE penalite_type AS ENUM ('retard', 'degradation', 'perte', 'autre');
CREATE TYPE notification_type AS ENUM ('reservation_disponible', 'retour_imminent', 'retard', 'penalite', 'nouveaute');
CREATE TYPE notification_statut AS ENUM ('en_attente', 'envoye', 'lu', 'echec');

-- Tables de référence
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

CREATE TABLE parametre_systeme (
  id_parametre SERIAL PRIMARY KEY,
  code_parametre VARCHAR(50) NOT NULL UNIQUE,
  nom_parametre VARCHAR(100) NOT NULL,
  valeur_parametre VARCHAR(500) NOT NULL,
  type_parametre VARCHAR(20) NOT NULL,
  description TEXT,
  modifiable BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gestion des utilisateurs
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
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  id_type_utilisateur INTEGER NOT NULL REFERENCES type_utilisateur(id_type_utilisateur),
  date_inscription DATE DEFAULT CURRENT_DATE,
  date_expiration_adhesion DATE NOT NULL,
  statut adherent_statut DEFAULT 'actif',
  preferences_notification JSON,
  date_fin_suspension DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE utilisateur (
  id_utilisateur SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  nom VARCHAR(50) NOT NULL,
  role utilisateur_role NOT NULL,
  id_adherent INTEGER REFERENCES adherent(id_adherent),
  actif BOOLEAN DEFAULT TRUE,
  derniere_connexion TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gestion des livres
CREATE TABLE auteur (
  id_auteur SERIAL PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  date_naissance DATE,
  date_deces DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livre (
  id_livre SERIAL PRIMARY KEY,
  titre VARCHAR(200) NOT NULL,
  id_editeur INTEGER NOT NULL REFERENCES editeur(id_editeur),
  id_langue INTEGER NOT NULL REFERENCES langue(id_langue),
  id_genre INTEGER NOT NULL REFERENCES genre(id_genre),
  id_emplacement INTEGER NOT NULL REFERENCES emplacement(id_emplacement),
  annee_publication INTEGER NOT NULL,
  nombre_pages INTEGER,
  prix_remplacement DECIMAL(10,2) DEFAULT 20.00,
  date_acquisition DATE DEFAULT CURRENT_DATE,
  actif BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE livre_auteur (
  id_livre INTEGER NOT NULL REFERENCES livre(id_livre) ON DELETE CASCADE,
  id_auteur INTEGER NOT NULL REFERENCES auteur(id_auteur),
  role_auteur livre_auteur_role DEFAULT 'auteur_principal',
  ordre_auteur INTEGER DEFAULT 1,
  PRIMARY KEY (id_livre, id_auteur)
);

CREATE TABLE exemplaire (
  id_exemplaire SERIAL PRIMARY KEY,
  id_livre INTEGER NOT NULL REFERENCES livre(id_livre) ON DELETE CASCADE,
  code_barre VARCHAR(50) NOT NULL UNIQUE,
  numero_exemplaire INTEGER NOT NULL,
  etat exemplaire_etat DEFAULT 'bon',
  disponible BOOLEAN DEFAULT TRUE,
  date_acquisition DATE DEFAULT CURRENT_DATE,
  provenance VARCHAR(50) DEFAULT 'achat',
  prix_achat DECIMAL(10,2),
  notes_etat TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gestion des prêts
CREATE TABLE pret (
  id_pret SERIAL PRIMARY KEY,
  numero_pret VARCHAR(20) NOT NULL UNIQUE,
  id_adherent INTEGER NOT NULL REFERENCES adherent(id_adherent),
  id_exemplaire INTEGER NOT NULL REFERENCES exemplaire(id_exemplaire),
  id_bibliothecaire INTEGER NOT NULL REFERENCES utilisateur(id_utilisateur),
  date_pret DATE DEFAULT CURRENT_DATE,
  date_retour_prevue DATE NOT NULL,
  date_retour_effective DATE,
  statut pret_statut DEFAULT 'en_cours',
  notes_pret TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prolongation_pret (
  id_prolongation SERIAL PRIMARY KEY,
  id_pret INTEGER NOT NULL REFERENCES pret(id_pret) ON DELETE CASCADE,
  date_demande DATE DEFAULT CURRENT_DATE,
  nouvelle_date_retour DATE NOT NULL,
  statut prolongation_statut NOT NULL,
  id_bibliothecaire INTEGER REFERENCES utilisateur(id_utilisateur),
  motif_refus TEXT,
  automatique BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Système de réservation
CREATE TABLE reservation (
  id_reservation SERIAL PRIMARY KEY,
  numero_reservation VARCHAR(20) NOT NULL UNIQUE,
  id_adherent INTEGER NOT NULL REFERENCES adherent(id_adherent),
  id_livre INTEGER NOT NULL REFERENCES livre(id_livre),
  date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_expiration DATE NOT NULL,
  priorite INTEGER DEFAULT 1,
  position_file INTEGER NOT NULL,
  date_notification TIMESTAMP,
  date_retrait_limite TIMESTAMP,
  statut reservation_statut DEFAULT 'en_attente',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Système de pénalités (optimisé)
CREATE TABLE type_penalite (
  id_type_penalite SERIAL PRIMARY KEY,
  code_type VARCHAR(50) NOT NULL UNIQUE,
  libelle VARCHAR(100) NOT NULL,
  montant_base DECIMAL(10,2) DEFAULT 0.00,
  duree_suspension_jours INTEGER DEFAULT 0,
  est_cumulable BOOLEAN DEFAULT FALSE,
  actif BOOLEAN DEFAULT TRUE,
  description TEXT
);

CREATE TABLE penalite (
  id_penalite SERIAL PRIMARY KEY,
  id_type_penalite INTEGER NOT NULL REFERENCES type_penalite(id_type_penalite),
  id_adherent INTEGER NOT NULL REFERENCES adherent(id_adherent),
  id_pret INTEGER REFERENCES pret(id_pret),
  id_bibliothecaire INTEGER REFERENCES utilisateur(id_utilisateur),
  montant_calcule DECIMAL(10,2) DEFAULT 0.00,
  montant_final DECIMAL(10,2) NOT NULL,
  date_debut_suspension DATE,
  date_fin_suspension DATE,
  date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_paiement DATE,
  statut penalite_statut DEFAULT 'impayee',
  notes TEXT
);

-- Système de notifications
CREATE TABLE notification (
  id_notification SERIAL PRIMARY KEY,
  id_adherent INTEGER NOT NULL REFERENCES adherent(id_adherent),
  type_notification notification_type NOT NULL,
  titre VARCHAR(100) NOT NULL,
  contenu TEXT NOT NULL,
  date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  date_envoi TIMESTAMP,
  date_lecture TIMESTAMP,
  statut notification_statut DEFAULT 'en_attente',
  canal_envoi VARCHAR(20) DEFAULT 'email',
  id_objet_lie INTEGER,
  type_objet_lie VARCHAR(20)
);

-- Statistiques
CREATE TABLE statistique_emprunt (
  id_statistique SERIAL PRIMARY KEY,
  id_livre INTEGER NOT NULL REFERENCES livre(id_livre),
  periode_debut DATE NOT NULL,
  periode_fin DATE NOT NULL,
  nombre_emprunts INTEGER NOT NULL DEFAULT 0,
  nombre_reservations INTEGER NOT NULL DEFAULT 0,
  duree_moyenne_emprunt DECIMAL(5,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Historique
CREATE TABLE historique_modification (
  id_historique SERIAL PRIMARY KEY,
  table_concernee VARCHAR(50) NOT NULL,
  id_enregistrement INTEGER NOT NULL,
  action VARCHAR(20) NOT NULL,
  anciennes_valeurs JSON,
  nouvelles_valeurs JSON,
  id_utilisateur INTEGER NOT NULL REFERENCES utilisateur(id_utilisateur),
  date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Logs
CREATE TABLE log_activite (
  id_log SERIAL PRIMARY KEY,
  id_utilisateur INTEGER NOT NULL REFERENCES utilisateur(id_utilisateur),
  action VARCHAR(100) NOT NULL,
  table_concernee VARCHAR(50) NOT NULL,
  details JSON,
  adresse_ip VARCHAR(45),
  user_agent TEXT,
  date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Collections
CREATE TABLE collection (
  id_collection SERIAL PRIMARY KEY,
  nom_collection VARCHAR(100) NOT NULL,
  description TEXT,
  id_bibliothecaire INTEGER NOT NULL REFERENCES utilisateur(id_utilisateur),
  date_creation DATE DEFAULT CURRENT_DATE,
  actif BOOLEAN DEFAULT TRUE
);

CREATE TABLE collection_livre (
  id_collection INTEGER NOT NULL REFERENCES collection(id_collection) ON DELETE CASCADE,
  id_livre INTEGER NOT NULL REFERENCES livre(id_livre) ON DELETE CASCADE,
  date_ajout DATE DEFAULT CURRENT_DATE,
  PRIMARY KEY (id_collection, id_livre)
);

-- Fermetures exceptionnelles
CREATE TABLE fermeture_exceptionnelle (
  id_fermeture SERIAL PRIMARY KEY,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  motif VARCHAR(200) NOT NULL,
  prolongation_automatique BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index pour améliorer les performances
CREATE INDEX idx_livre_titre ON livre(titre);
CREATE INDEX idx_exemplaire_disponible ON exemplaire(disponible) WHERE disponible = true;
CREATE INDEX idx_pret_statut ON pret(statut);
CREATE INDEX idx_pret_date_retour ON pret(date_retour_prevue);
CREATE INDEX idx_reservation_statut ON reservation(statut);
CREATE INDEX idx_penalite_statut ON penalite(statut);
CREATE INDEX idx_notification_adherent ON notification(id_adherent);

-- Triggers pour la cohérence des données
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

-- Fonction pour mettre à jour la disponibilité des exemplaires
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

-- Insertion des données de base pour les types de pénalité
INSERT INTO type_penalite (code_type, libelle, montant_base, duree_suspension_jours, est_cumulable, description) VALUES
('RETARD', 'Retard de retour', 0.50, 0, TRUE, 'Pénalité financière pour chaque jour de retard'),
('SUSPENSION', 'Suspension temporaire', 0.00, 5, FALSE, 'Interdiction d''emprunt pendant X jours'),
('PERTE', 'Livre perdu ou volé', 20.00, 0, FALSE, 'Coût de remplacement du livre');

-- Insertion des paramètres système par défaut
INSERT INTO parametre_systeme (code_parametre, nom_parametre, valeur_parametre, type_parametre, description) VALUES
('DUREE_EMPRUNT_DEFAUT', 'Durée d''emprunt par défaut', '15', 'integer', 'Durée en jours'),
('PENALITE_RETARD_JOUR', 'Pénalité par jour de retard', '0.50', 'decimal', 'Montant en euros'),
('DUREE_SUSPENSION_RETARD', 'Durée suspension pour retard', '5', 'integer', 'Durée en jours');
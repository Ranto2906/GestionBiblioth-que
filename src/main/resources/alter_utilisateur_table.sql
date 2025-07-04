-- Script pour ajouter la colonne id_type_utilisateur à la table utilisateur
-- et créer la relation avec la table type_utilisateur

-- Ajouter la colonne id_type_utilisateur à la table utilisateur
ALTER TABLE utilisateur 
ADD COLUMN id_type_utilisateur INTEGER;

-- Ajouter la contrainte de clé étrangère
ALTER TABLE utilisateur 
ADD CONSTRAINT fk_utilisateur_type_utilisateur 
FOREIGN KEY (id_type_utilisateur) 
REFERENCES type_utilisateur(id_type_utilisateur);

-- Optionnel : Rendre la colonne NOT NULL après avoir ajouté des données
-- ALTER TABLE utilisateur ALTER COLUMN id_type_utilisateur SET NOT NULL;

-- Exemple d'insertion de données de test
-- Insérer d'abord des types d'utilisateur
INSERT INTO type_utilisateur (code_type, nom_type, duree_emprunt_jours, nombre_emprunts_max, nombre_renouvellements_max, priorite_reservation, peut_reserver) 
VALUES 
('ETUDIANT', 'Étudiant', 15, 5, 2, 1, true),
('PROFESSEUR', 'Professeur', 30, 10, 3, 2, true),
('PERSONNEL', 'Personnel', 21, 7, 2, 1, true),
('EXTERNE', 'Utilisateur externe', 14, 3, 1, 3, false);


-- D'abord, insérer les types d'utilisateurs nécessaires
INSERT INTO type_utilisateur (code_type, nom_type, duree_emprunt_jours, nombre_emprunts_max, nombre_renouvellements_max) 
VALUES 
('ETUDIANT', 'Etudiant', 15, 5, 2),
('ENSEIGNANT', 'Enseignant', 30, 10, 3),
('EXTERNE', 'Externe', 7, 2, 1),
('VIP', 'VIP/Chercheur', 30, 15, 5);

-- Ensuite, insérer les adhérents
INSERT INTO adherent (
    nom, 
    prenom, 
    email, 
    id_type_utilisateur, 
    date_inscription, 
    date_expiration_adhesion, 
    statut, 
    preferences_notification,
    date_fin_suspension,
    created_at,
    updated_at
) VALUES
-- Adhérent étudiant actif
(
    'Dupont', 
    'Jean', 
    'jean.dupont@email.com', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), 
    CURRENT_DATE - INTERVAL '3 months', 
    CURRENT_DATE + INTERVAL '9 months', 
    'actif',
    '{"email": true, "sms": false, "notif_retard": true}',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '3 months',
    CURRENT_TIMESTAMP
),
-- Adhérent enseignant actif
(
    'Martin', 
    'Sophie', 
    'sophie.martin@universite.fr', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ENSEIGNANT'), 
    CURRENT_DATE - INTERVAL '1 year', 
    CURRENT_DATE + INTERVAL '1 year', 
    'actif',
    '{"email": true, "sms": true, "notif_retard": true}',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '1 year',
    CURRENT_TIMESTAMP
),
-- Adhérent externe suspendu (retards répétés)
(
    'Bernard', 
    'Luc', 
    'luc.bernard@gmail.com', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), 
    CURRENT_DATE - INTERVAL '2 months', 
    CURRENT_DATE + INTERVAL '4 months', 
    'suspendu',
    '{"email": true, "sms": false, "notif_retard": false}',
    CURRENT_DATE + INTERVAL '7 days', -- Suspension de 7 jours
    CURRENT_TIMESTAMP - INTERVAL '2 months',
    CURRENT_TIMESTAMP
),
-- Adhérent VIP (chercheur)
(
    'Petit', 
    'Elodie', 
    'elodie.petit@recherche.fr', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'VIP'), 
    CURRENT_DATE - INTERVAL '6 months', 
    CURRENT_DATE + INTERVAL '2 years', 
    'actif',
    '{"email": true, "sms": true, "notif_retard": true, "notif_nouveautes": true}',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '6 months',
    CURRENT_TIMESTAMP
),
-- Adhérent étudiant avec adhésion expirée
(
    'Leroy', 
    'Thomas', 
    'thomas.leroy@email.com', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), 
    CURRENT_DATE - INTERVAL '1 year', 
    CURRENT_DATE - INTERVAL '1 month', 
    'expire',
    '{"email": false, "sms": true, "notif_retard": true}',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '1 year',
    CURRENT_TIMESTAMP
),
-- Nouvel adhérent en attente de validation
(
    'Garcia', 
    'Ana', 
    'ana.garcia@email.com', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), 
    CURRENT_DATE, 
    CURRENT_DATE + INTERVAL '1 year', 
    'en_attente',
    '{"email": true, "sms": false, "notif_retard": true}',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
),
-- Adhérent radié (cas extrême)
(
    'Dubois', 
    'Marc', 
    'marc.dubois@ancien.fr', 
    (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), 
    CURRENT_DATE - INTERVAL '3 years', 
    CURRENT_DATE - INTERVAL '2 years', 
    'radie',
    '{"email": false, "sms": false, "notif_retard": false}',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '3 years',
    CURRENT_TIMESTAMP - INTERVAL '1 year'
);

-- Mettre à jour les utilisateurs existants avec un type par défaut (optionnel)
-- UPDATE utilisateur SET id_type_utilisateur = (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT' LIMIT 1) WHERE id_type_utilisateur IS NULL; 
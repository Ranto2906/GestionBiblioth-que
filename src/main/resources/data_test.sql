-- Active: 1751649895095@@127.0.0.1@5432@gestion_bibliotheque
-- Script de donnees de test pour les tables adherent et utilisateur

-- 1. Inserer des types d'utilisateur (si pas deja fait)
INSERT INTO type_utilisateur (code_type, nom_type, duree_emprunt_jours, nombre_emprunts_max, nombre_renouvellements_max, priorite_reservation, peut_reserver, actif) 
VALUES 
('ETUDIANT', 'Etudiant', 15, 5, 2, 1, true, true),
('PROFESSEUR', 'Professeur', 30, 10, 3, 2, true, true),
('PERSONNEL', 'Personnel', 21, 7, 2, 1, true, true),
('EXTERNE', 'Utilisateur externe', 14, 3, 1, 3, false, true)
ON CONFLICT (code_type) DO NOTHING;

-- 2. Inserer des adherents
INSERT INTO adherent (nom, prenom, email, id_type_utilisateur, date_inscription, date_expiration_adhesion, statut, preferences_notification, created_at, updated_at) 
VALUES 
-- Etudiants
('Dupont', 'Marie', 'marie.dupont@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-01-15', '2025-01-15', 'ACTIF', '{"email": true, "sms": false}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Martin', 'Pierre', 'pierre.martin@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-02-20', '2025-02-20', 'ACTIF', '{"email": true, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bernard', 'Sophie', 'sophie.bernard@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-03-10', '2025-03-10', 'ACTIF', '{"email": false, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Petit', 'Lucas', 'lucas.petit@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), '2024-01-05', '2025-01-05', 'SUSPENDU', '{"email": true, "sms": false}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
-- Professeurs
('Dubois', 'Jean', 'jean.dubois@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), '2023-09-01', '2025-09-01', 'ACTIF', '{"email": true, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Moreau', 'Claire', 'claire.moreau@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), '2023-10-15', '2025-10-15', 'ACTIF', '{"email": true, "sms": false}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Leroy', 'Michel', 'michel.leroy@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), '2023-11-20', '2025-11-20', 'ACTIF', '{"email": true, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Personnel
('Roux', 'Anne', 'anne.roux@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), '2023-08-01', '2025-08-01', 'ACTIF', '{"email": true, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Simon', 'Paul', 'paul.simon@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), '2023-12-01', '2025-12-01', 'ACTIF', '{"email": true, "sms": false}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Utilisateurs externes
('Michel', 'Isabelle', 'isabelle.michel@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), '2024-04-01', '2025-04-01', 'ACTIF', '{"email": true, "sms": false}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Garcia', 'Carlos', 'carlos.garcia@email.com', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), '2024-05-15', '2025-05-15', 'ACTIF', '{"email": false, "sms": true}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 3. Inserer des utilisateurs (comptes de connexion)
INSERT INTO utilisateur (username, password, email, nom, role, id_type_utilisateur, id_adherent, actif, derniere_connexion, created_at, updated_at) 
VALUES 
-- Utilisateurs avec adherents (etudiants)
('marie.dupont', 'password123', 'marie.dupont@email.com', 'Marie Dupont', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), (SELECT id_adherent FROM adherent WHERE email = 'marie.dupont@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('pierre.martin', 'password123', 'pierre.martin@email.com', 'Pierre Martin', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), (SELECT id_adherent FROM adherent WHERE email = 'pierre.martin@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('sophie.bernard', 'password123', 'sophie.bernard@email.com', 'Sophie Bernard', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), (SELECT id_adherent FROM adherent WHERE email = 'sophie.bernard@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('lucas.petit', 'password123', 'lucas.petit@email.com', 'Lucas Petit', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT'), (SELECT id_adherent FROM adherent WHERE email = 'lucas.petit@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Utilisateurs avec adherents (professeurs)
('jean.dubois', 'password123', 'jean.dubois@email.com', 'Jean Dubois', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), (SELECT id_adherent FROM adherent WHERE email = 'jean.dubois@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('claire.moreau', 'password123', 'claire.moreau@email.com', 'Claire Moreau', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), (SELECT id_adherent FROM adherent WHERE email = 'claire.moreau@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('michel.leroy', 'password123', 'michel.leroy@email.com', 'Michel Leroy', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PROFESSEUR'), (SELECT id_adherent FROM adherent WHERE email = 'michel.leroy@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Utilisateurs avec adherents (personnel)
('anne.roux', 'password123', 'anne.roux@email.com', 'Anne Roux', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), (SELECT id_adherent FROM adherent WHERE email = 'anne.roux@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('paul.simon', 'password123', 'paul.simon@email.com', 'Paul Simon', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), (SELECT id_adherent FROM adherent WHERE email = 'paul.simon@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Utilisateurs avec adherents (externes)
('isabelle.michel', 'password123', 'isabelle.michel@email.com', 'Isabelle Michel', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), (SELECT id_adherent FROM adherent WHERE email = 'isabelle.michel@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('carlos.garcia', 'password123', 'carlos.garcia@email.com', 'Carlos Garcia', 'ADHERENT', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'EXTERNE'), (SELECT id_adherent FROM adherent WHERE email = 'carlos.garcia@email.com'), true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Utilisateurs systeme (bibliothecaires et administrateurs)
('admin', 'admin123', 'admin@bibliotheque.com', 'Administrateur', 'ADMIN', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), NULL, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('bibliothecaire1', 'biblio123', 'biblio1@bibliotheque.com', 'Bibliothecaire Principal', 'BIBLIOTHECAIRE', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), NULL, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('bibliothecaire2', 'biblio123', 'biblio2@bibliotheque.com', 'Bibliothecaire Adjoint', 'BIBLIOTHECAIRE', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), NULL, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('responsable', 'resp123', 'responsable@bibliotheque.com', 'Responsable Bibliotheque', 'RESPONSABLE', (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'PERSONNEL'), NULL, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 4. Afficher les donnees inserees (pour verification)
SELECT 'Types d''utilisateur:' as info;
SELECT * FROM type_utilisateur;

SELECT 'Adherents:' as info;
SELECT a.id_adherent, a.nom, a.prenom, a.email, t.nom_type, a.statut
FROM adherent a 
JOIN type_utilisateur t ON a.id_type_utilisateur = t.id_type_utilisateur;

SELECT 'Utilisateurs:' as info;
SELECT u.id_utilisateur, u.username, u.email, u.nom, u.role, t.nom_type, 
       CASE WHEN u.id_adherent IS NOT NULL THEN 'Oui' ELSE 'Non' END as a_un_adherent,
       u.actif
FROM utilisateur u 
LEFT JOIN type_utilisateur t ON u.id_type_utilisateur = t.id_type_utilisateur; 
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

-- Mettre à jour les utilisateurs existants avec un type par défaut (optionnel)
-- UPDATE utilisateur SET id_type_utilisateur = (SELECT id_type_utilisateur FROM type_utilisateur WHERE code_type = 'ETUDIANT' LIMIT 1) WHERE id_type_utilisateur IS NULL; 
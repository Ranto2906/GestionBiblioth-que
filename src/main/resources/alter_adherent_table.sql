-- Script pour ajouter la colonne password à la table adherent
-- Exécutez ce script dans votre base de données PostgreSQL

-- 1. Ajouter la colonne password
ALTER TABLE adherent ADD COLUMN password VARCHAR(255) NOT NULL DEFAULT 'password123';

-- 2. Mettre à jour les mots de passe pour les adhérents existants (optionnel)
-- Vous pouvez personnaliser les mots de passe selon vos besoins

-- 3. Vérifier que la colonne a été ajoutée
SELECT column_name, data_type, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'adherent' AND column_name = 'password';

-- 4. Afficher la structure de la table adherent
\d adherent; 
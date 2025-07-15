-- Création de la table utilisateur
CREATE TABLE public.utilisateur (
    id bigint PRIMARY KEY,
    address character varying(255),
    date_naissance date,
    email character varying(255),
    nom character varying(255),
    password character varying(255),
    prenom character varying(255),
    telephone character varying(255)
);

-- Création de la table profil
CREATE TABLE public.profil (
    id bigint PRIMARY KEY,
    nom character varying(255)
);

-- Création de la table adherent
CREATE TABLE public.adherent (
    id bigint PRIMARY KEY,
    date_inscription timestamp(6) without time zone,
    numero_adherent character varying(255) NOT NULL,
    profil_id bigint,
    CONSTRAINT adherent_numero_adherent_unique UNIQUE (numero_adherent),
    FOREIGN KEY (id) REFERENCES public.utilisateur(id),
    FOREIGN KEY (profil_id) REFERENCES public.profil(id)
);

-- Création de la table personnel
CREATE TABLE public.personnel (
    id bigint PRIMARY KEY,
    date_embauche timestamp(6) without time zone,
    matricule character varying(255) NOT NULL,
    status character varying(255),
    CONSTRAINT personnel_matricule_unique UNIQUE (matricule),
    FOREIGN KEY (id) REFERENCES public.utilisateur(id)
);

-- Création de la table auteur
CREATE TABLE public.auteur (
    id bigint PRIMARY KEY,
    date_deces date,
    date_naissance date,
    nationalite character varying(255),
    nom character varying(255),
    prenom character varying(255)
);

-- Création de la table editeur
CREATE TABLE public.editeur (
    id bigint PRIMARY KEY,
    annee_fondation integer,
    nom character varying(255),
    pays character varying(255)
);

-- Création de la table categorie
CREATE TABLE public.categorie (
    id bigint PRIMARY KEY,
    nom character varying(255)
);

-- Création de la table livre
CREATE TABLE public.livre (
    id bigint PRIMARY KEY,
    annee_publication integer,
    isbn character varying(255),
    limit_age integer,
    nombre_pages integer,
    resume character varying(255),
    titre character varying(255),
    auteur_id bigint,
    editeur_id bigint,
    FOREIGN KEY (auteur_id) REFERENCES public.auteur(id),
    FOREIGN KEY (editeur_id) REFERENCES public.editeur(id)
);

-- Création de la table livre_categorie
CREATE TABLE public.livre_categorie (
    livre_id bigint NOT NULL,
    categorie_id bigint NOT NULL,
    PRIMARY KEY (livre_id, categorie_id),
    FOREIGN KEY (livre_id) REFERENCES public.livre(id),
    FOREIGN KEY (categorie_id) REFERENCES public.categorie(id)
);

-- Création de la table exemplaire
CREATE TABLE public.exemplaire (
    id bigint PRIMARY KEY,
    date_acquisition date,
    reference character varying(255) NOT NULL,
    livre_id bigint,
    CONSTRAINT exemplaire_reference_unique UNIQUE (reference),
    FOREIGN KEY (livre_id) REFERENCES public.livre(id)
);

-- Création de la table type_abonnement
CREATE TABLE public.type_abonnement (
    id bigint PRIMARY KEY,
    code character varying(255) NOT NULL,
    conditions character varying(255),
    duree_mois integer,
    libelle character varying(255),
    montant double precision,
    CONSTRAINT type_abonnement_code_unique UNIQUE (code)
);

-- Création de la table abonnement
CREATE TABLE public.abonnement (
    id bigint PRIMARY KEY,
    date_debut date,
    date_fin date,
    date_paiement date,
    montant_paye double precision,
    adherent_id bigint,
    type_abonnement_id bigint,
    FOREIGN KEY (adherent_id) REFERENCES public.adherent(id),
    FOREIGN KEY (type_abonnement_id) REFERENCES public.type_abonnement(id)
);

-- Création de la table configuration_quota
CREATE TABLE public.configuration_quota (
    id bigint PRIMARY KEY,
    date_configuration timestamp(6) without time zone,
    duree_max_pret integer,
    libelle character varying(255),
    quota_pret integer,
    quota_reservation integer,
    profil_id bigint,
    FOREIGN KEY (profil_id) REFERENCES public.profil(id)
);

-- Création de la table pret
CREATE TABLE public.pret (
    id bigint PRIMARY KEY,
    date_pret timestamp(6) without time zone NOT NULL,
    date_retour_effectuer timestamp(6) without time zone,
    date_retour_prevu timestamp(6) without time zone NOT NULL,
    notes character varying(255),
    type_pret character varying(255) NOT NULL,
    adherent_id bigint NOT NULL,
    exemplaire_id bigint NOT NULL,
    CONSTRAINT pret_type_pret_check CHECK (type_pret IN ('domicile', 'sur place')),
    FOREIGN KEY (adherent_id) REFERENCES public.adherent(id),
    FOREIGN KEY (exemplaire_id) REFERENCES public.exemplaire(id)
);

-- Création de la table prolongement_pret
CREATE TABLE public.prolongement_pret (
    id bigint PRIMARY KEY,
    date_prolongement timestamp(6) without time zone NOT NULL,
    date_retour_prevu timestamp(6) without time zone NOT NULL,
    admin_id bigint,
    pret_id bigint NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES public.personnel(id),
    FOREIGN KEY (pret_id) REFERENCES public.pret(id)
);

-- Création de la table reservation
CREATE TABLE public.reservation (
    id bigint PRIMARY KEY,
    date_expiration timestamp(6) without time zone NOT NULL,
    date_reservation timestamp(6) without time zone NOT NULL,
    date_souhaiter timestamp(6) without time zone NOT NULL,
    adherent_id bigint NOT NULL,
    exemplaire_id bigint NOT NULL,
    FOREIGN KEY (adherent_id) REFERENCES public.adherent(id),
    FOREIGN KEY (exemplaire_id) REFERENCES public.exemplaire(id)
);

-- Création de la table notification
CREATE TABLE public.notification (
    id bigint PRIMARY KEY,
    date_creation timestamp(6) without time zone,
    est_lu boolean NOT NULL,
    message character varying(255),
    pret_id bigint,
    reservation_id bigint,
    utilisateur_id bigint,
    FOREIGN KEY (pret_id) REFERENCES public.pret(id),
    FOREIGN KEY (reservation_id) REFERENCES public.reservation(id),
    FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id)
);

-- Création de la table type_penalite
CREATE TABLE public.type_penalite (
    id bigint PRIMARY KEY,
    code character varying(255) NOT NULL,
    description character varying(255),
    duree_jours integer,
    retard_jours integer,
    CONSTRAINT type_penalite_code_unique UNIQUE (code)
);

-- Création de la table penalite
CREATE TABLE public.penalite (
    id bigint PRIMARY KEY,
    date_annulation timestamp(6) without time zone,
    date_application date,
    date_fin date,
    notes character varying(255),
    adherent_id bigint,
    admin_id bigint,
    type_penalite_id bigint,
    FOREIGN KEY (adherent_id) REFERENCES public.adherent(id),
    FOREIGN KEY (admin_id) REFERENCES public.personnel(id),
    FOREIGN KEY (type_penalite_id) REFERENCES public.type_penalite(id)
);

-- Création de la table feries
CREATE TABLE public.feries (
    id bigint PRIMARY KEY,
    date_creation timestamp(6) without time zone,
    jour smallint,
    mois smallint,
    description character varying(255),
    duree_jours integer,
    nom_evenement character varying(255)
);

-- Création de la table suivi_feries
CREATE TABLE public.suivi_feries (
    id bigint PRIMARY KEY,
    annee integer,
    date_valide timestamp(6) without time zone,
    description character varying(255),
    ferie_id bigint,
    FOREIGN KEY (ferie_id) REFERENCES public.feries(id)
);

-- Création de la table reparation
CREATE TABLE public.reparation (
    id bigint PRIMARY KEY,
    cout double precision,
    date_debut date,
    date_fin_prevue date,
    date_fin_reelle date,
    description character varying(255),
    technicien character varying(255),
    exemplaire_id bigint,
    FOREIGN KEY (exemplaire_id) REFERENCES public.exemplaire(id)
);

-- Création de la table statut_exemplaire
CREATE TABLE public.statut_exemplaire (
    id bigint PRIMARY KEY,
    date_changement timestamp(6) without time zone,
    notes character varying(255),
    statut integer,
    admin_id bigint,
    exemplaire_id bigint,
    pret_id bigint,
    reservation_id bigint,
    FOREIGN KEY (admin_id) REFERENCES public.personnel(id),
    FOREIGN KEY (exemplaire_id) REFERENCES public.exemplaire(id),
    FOREIGN KEY (pret_id) REFERENCES public.pret(id),
    FOREIGN KEY (reservation_id) REFERENCES public.reservation(id)
);

-- Création de la table validation
CREATE TABLE public.validation (
    id bigint PRIMARY KEY,
    date timestamp(6) without time zone NOT NULL,
    validation_status boolean NOT NULL,
    admin_id bigint NOT NULL,
    pret_id bigint,
    prolongement_id bigint,
    reservation_id bigint,
    FOREIGN KEY (admin_id) REFERENCES public.personnel(id),
    FOREIGN KEY (pret_id) REFERENCES public.pret(id),
    FOREIGN KEY (prolongement_id) REFERENCES public.prolongement_pret(id),
    FOREIGN KEY (reservation_id) REFERENCES public.reservation(id)
);

-- Création de la vue exemplaire_statut_aujourdhui
CREATE VIEW public.exemplaire_statut_aujourdhui AS
SELECT e.id AS exemplaire_id,
       e.reference,
       l.titre AS livre,
       CASE
           WHEN EXISTS (
               SELECT 1
               FROM public.pret p
               WHERE p.exemplaire_id = e.id AND p.date_retour_effectuer IS NULL
           ) THEN 'EMPRUNTE'
           ELSE 'DISPONIBLE'
       END AS statut_aujourdhui
FROM public.exemplaire e
LEFT JOIN public.livre l ON e.livre_id = l.id;
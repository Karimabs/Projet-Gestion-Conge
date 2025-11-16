CREATE DATABASE IF NOT EXISTS conge_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE conge_db;

CREATE TABLE utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    mot_de_passe VARCHAR(255),
    role VARCHAR(20)
);

CREATE TABLE demande_conge (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT,
    date_debut DATE,
    date_fin DATE,
    type_conge VARCHAR(50),
    statut VARCHAR(20),
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE CASCADE
);

INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, role)
VALUES ('Admin', 'Root', 'admin@example.com', '$2a$12$jT2FBk5E432XTr.NrvymQ.0MZQcISAd./V9WkttNjWMtBOIWGSZjm', 'ADMIN');

//email:admin@example.com
//mot_de_passe:admin123
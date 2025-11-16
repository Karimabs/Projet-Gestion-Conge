# Projet de Gestion de Congés (Java EE)
Ce projet est une application web de gestion de congés réalisée avec Java EE, Servlets, JSP, Hibernate et MySQL.
## 1. Prérequis
* Java JDK (Version 11, 17, ou plus)
* Apache Tomcat (Version 10.x ou plus, pour jakarta.servlet)
* MySQL Server (Version 8.x)
* MySQL Workbench (ou un client SQL similaire)
* Apache Maven
## 2. Instructions d'installation

### Étape 1 : Cloner le projet
 Clonez ce dépôt sur votre machine locale : (terminal)
 git clone https://github.com/Karimabs/Projet-Gestion-Conge.git
 cd Projet-Gestion-Conge 
### Étape 2 Créer la Base de Données: 
Vous devez créer la base de données et les tables avant de lancer l'application.

Ouvrez MySQL Workbench et connectez-vous à votre serveur MySQL.

Ouvrez le fichier database.sql (inclus à la racine de ce projet).

Exécutez l'intégralité du script.

### Étape 3 : Configurer la Connexion Hibernate
Le projet a besoin de votre mot de passe MySQL pour se connecter.
Ouvrez le fichier : src/main/resources/hibernate.cfg.xml.
Modifiez les lignes username et password pour correspondre à votre configuration MySQL locale 
### Étape 4 : Lancer l'Application

## Identifiants de Connexion
Un compte Administrateur est créé par défaut par le script database.sql.

Email : admin@example.com
Mot de passe : admin123

## Auteurs
Ce projet a été réalisé par :
- Imane Baradi
- Karima bousmara

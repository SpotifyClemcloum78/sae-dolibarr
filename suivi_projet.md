﻿
# Journal de bord

-   `Projet Dolibarr`
-  Chef de projet : Clément Savoye 
-  Collaborateur : Arthur Cimpoies
-   Mercredi 16 Octobre

## Séance n° 1
-   Mercredi 16 Octobre de 9h30 à 12h30
 ### Travail effectué :
-   **Compréhension du sujet** : Discussion approfondie sur les attentes du projet SAE Dolibarr.
    -   Examen des fonctionnalités à implémenter (gestion des "Tiers" : liste de clients/fournisseurs).
    -   Clarification de la notion de **POC** 
   
-   **Organisation future** :
    -   Répartition des tâches pour les prochaines séances.
    -   Créer un drive où l'ont partagera nos avancé avec l'équipe.
    -   Identification des principaux dossiers et fichiers : `docs/`, `sources/`, `tests/`, `data/`, `readme.md`, `suivi_projet.md`.


## Séance n° 2
-   Mercredi 16 Octobre de 13h30 à 16h30
### Travail effectué :

-   **Mise en place du Drive ** : Pour ajouté les personne concernés dans le drive de façon a partager nos avancés.
-   **Structure du projet** : Création des dossiers de base (`docs/`, `sources/`, `tests/`, `data/`) et du fichier `readme.md`.
-   **Début de l'implémentation** : Début du travail sur la gestion des "Tiers", notamment la définition des attributs nécessaires (nom, adresse, téléphone, email.).

### À faire pour la prochaine séance :

-   Terminer la structure de la base de données pour les "Tiers".
-   Générer des données fictives pour tester la fonctionnalité à l'aide de fichier `.csv`.
-   Rédiger le fichier `suivi_projet.md` avec les détails des premières séances situé dans le drive.

### Difficultés rencontrées :

-   **Problèmes techniques** : Difficulté à générer certains fichiers au format CSV du à des exigences techniques dont nous n'avons pas discuté en équipe (formats d'email et de téléphone), à résoudre la prochaine séance.

## Séance n° 3

-   Jeudi 17 Octobre de 15h00 à 17h30
### Travail effectué :

- **Mise en place du dépôt Git** : Création d’un dépôt Git après relecture du sujet. Clément a créé le dépôt nommé `sae-dolibarr` et a ajouté Arthur comme collaborateur. Les dossiers initiaux du projet ont été importés dans ce dépôt (docs, sources, tests, data).
-   **Réunion technique** : Discussion sur les formats des champs à utiliser pour les numéros de téléphone et les emails dans la gestion des "Tiers".
-   **Installation des prérequis** : Installation des prérequis, dont Dolibarr et MariaDB. Cependant, l’installation était assez floue, ce qui a nécessité une documentation et des tentatives d'installation pour mieux comprendre .
- 
### À faire pour la prochaine séance :

-   Finaliser la configuration de Dolibarr avec la connexion à la base de données MariaDB.
-   Continuer à travailler sur la génération de données fictives pour les "Tiers" afin de tester les fonctionnalités.
-   Documenter le processus d'installation des prérequis pour référence future.

## Séance n° 4

- **Jeudi 24 Octobre de 16h00 à 18h30**

### Travail effectué :
- **Mise en place de l'environnement** : Création d'une machine virtuelle Ubuntu et téléchargement de Dolibarr.
- **Installation de Dolibarr** :
  - Décompression des fichiers et configuration d'Apache pour pointer vers le bon répertoire.
  - Vérification du bon fonctionnement du serveur Apache.
  - Lancement de l'installation de Dolibarr, création de la base de données, et configuration du compte superadmin.
- **Validation** : Accès réussi à la page d'accueil de Dolibarr.

### À faire pour la prochaine séance :
- Finaliser la configuration des modules.
- Importer des données via le menu "Outils".
- Explorer les fonctionnalités de Dolibarr.

### Difficultés rencontrées :
- Résolution d'une erreur 404 initiale liée à la structure des répertoires.

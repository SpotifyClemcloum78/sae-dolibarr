# Dolibarr

## 1. Introduction

Toutes les entreprises modernes ont besoin d’un système ERP/CRM pour gérer le flux d'informations critiques telles que les clients, fournisseurs, devis, factures, commandes et autres données liées à la gestion.  
Dans ce projet, l’objectif était de migrer d’une solution externalisée à une solution hébergée en interne, en utilisant **Dolibarr**. Cette migration comprend :

-   Une installation automatisée.
-   L’importation automatisée des données au format CSV.
-   Une solution Dockerisée pour s’affranchir des dépendances au système d'exploitation.
-   Une stratégie de sauvegarde pour garantir la récupération des données en cas d’incident.



## 2. Architecture du Projet

#### Conteneurs Docker utilisés :

1.  **MariaDB** : Base de données relationnelle pour stocker les informations de Dolibarr.
2.  **Dolibarr** : Logiciel ERP/CRM installé dans un conteneur distinct.

#### Structure des fichiers du projet :

-   **`Dockerfile`** : Définit l’image Docker personnalisée pour MariaDB.
-   **`run_dolibarr.sh`** : Script Bash pour automatiser le déploiement de MariaDB et Dolibarr.
-   **`donnees_tiers.csv`** : Fichier contenant les données utilisateur à importer dans Dolibarr.
-   **`dolibarr.import.sh`** : Script Bash pour automatiser l’importation des données CSV dans la base de données.
-   **`dolibarr.export.sh`** : Script Bash pour exporter les données de la base MariaDB dans un fichier CSV.
-   **`stop_dolibarr.sh`** : Script Bash pour arrêter les conteneurs Docker.

## 3. Ressenti de Projet

Ce projet a été une expérience enrichissante, nous permettant de mettre en pratique diverses compétences techniques tout en rencontrant des défis intéressants. Voici quelques réflexions sur ce que nous avons appris :

1.  **Défis Techniques :** L'intégration de Dolibarr dans un environnement Docker a été un défi, surtout en automatisant la gestion des bases de données et des fichiers CSV. Configurer les conteneurs MariaDB et Dolibarr pour qu'ils fonctionnent ensemble a nécessité plusieurs ajustements, notamment pour garantir que les données soient importées et exportées correctement via les scripts Bash.
    
2.  **Importation et Exportation des Données :** Automatiser l'importation et l'exportation des données utilisateur a soulevé des défis, principalement avec l'encodage des fichiers CSV et la gestion des erreurs d'importation. Cela nous a appris l'importance de valider soigneusement les données avant de les intégrer dans Dolibarr.
    
3.  **Optimisation des Scripts :** Bien que les scripts d'automatisation fonctionnent, nous avons constaté qu'il serait possible de les simplifier et de les rendre plus robustes en améliorant la gestion des erreurs.
    

## 4. Conclusion

Ce projet nous a permis d'appliquer nos compétences en développement et en gestion de bases de données, tout en nous familiarisant avec l'automatisation de l'import/export des données. L'intégration de Dolibarr dans un environnement Docker, ainsi que l'automatisation des tâches liées aux données, nous a offert une expérience précieuse dans la gestion des ERP/CRM et l'automatisation.





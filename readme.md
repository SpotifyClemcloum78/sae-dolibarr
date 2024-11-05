
# Rapport de Projet : Installation et Configuration d'un ERP/CRM Dolibarr

## Contexte du Projet
L’objectif est de déployer et configurer une instance de Dolibarr ERP/CRM pour un usage interne au sein d'une PME, en utilisant des conteneurs Docker pour isoler l’application et la base de données MariaDB. Ce projet inclut également la mise en place d’une stratégie de sauvegarde.

## 1. Préparation de l’Environnement

### 1.1 Installation de la Machine Virtuelle
**Action :** Installer une machine virtuelle sous Ubuntu.
- **Étapes :**
  - Télécharger l’ISO d’Ubuntu.
  - Installer l’OS sur une VM locale ou un serveur.

**Informations :** Ubuntu est compatible avec Docker et largement utilisé pour les serveurs.

### 1.2 Installation de Docker
**Action :** Installer Docker pour gérer les conteneurs Dolibarr et MariaDB.
- **Étapes :**
  - Mise à jour de l’OS :
    ```bash
    sudo apt update
    ```
  - Installation de Docker :
    ```bash
    sudo apt install docker.io
    ```
  - Vérification de l’installation :
    ```bash
    docker --version
    ```

**Informations :** Docker est nécessaire pour créer et gérer des conteneurs pour Dolibarr et MariaDB.

## 2. Déploiement de Dolibarr et MariaDB avec Docker

### 2.1 Démarrage de MariaDB
**Action :** Lancer un conteneur MariaDB avec les paramètres de configuration.
- **Commandes :**
  ```bash
  docker run -d --name dolibarr-db \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -e MYSQL_DATABASE=dolibarr \
    -e MYSQL_USER=dolibarruser \
    -e MYSQL_PASSWORD=dolibarrpass \
    -v /home/user/sae-dolibarr/data:/var/lib/mysql \
    mariadb:latest  
  ```
**Informations :** Ce conteneur inclut la configuration de la base `dolibarr`, un utilisateur avec accès (`dolibarruser`) et un mot de passe sécurisé. Le répertoire `/home/user/sae-dolibarr/data` stocke les données de la base.

### 2.2 Démarrage de Dolibarr

**Action :** Créer le conteneur Dolibarr avec les configurations nécessaires.

- **Commandes :**

```bash
docker run -d --name dolibarr-app \
  --link dolibarr-db:db \
  -p 8080:80 \
  dolibarr/dolibarr
```
  **Informations :**   Le conteneur est accessible à l’adresse [http://localhost:8080](http://localhost:8080), et il se connecte au conteneur MariaDB via le lien `--link dolibarr-db:db`
## 3. Génération et Importation de Données Fictives

### 3.1 Génération des Fichiers CSV
**Action :** Générer des données fictives pour peupler l’ERP Dolibarr.

**Étapes :**
1. **Déterminer les entités à simuler :** 
   - Nom
   - Adresse
   - Téléphone
   - Email

2. **Créer des fichiers CSV :** 
   - En utilisant une IA pour générer un fichier de test nommé `donnees_tiers.csv`:
     

3. **Sauvegarder les fichiers :** 
   - Enregistrer chaque fichier CSV dans un répertoire spécifique, par exemple dans `/home/user/sae-dolibarr`.

### 3.2 Importation des Données dans Dolibarr
**Action :** Importer les fichiers CSV dans Dolibarr.

**Étapes :**
1. **Se connecter à Dolibarr :** 
   - Accéder à l'interface web de Dolibarr via [http://localhost:8080](http://localhost:8080).

2. **Accéder à la section d’importation :** 
   - Naviguer vers le module correspondant (Clients, Fournisseurs, etc.).
   - Chercher l'option d'importation de données.

3. **Télécharger les fichiers CSV :** 
   - Sélectionner le fichier CSV à importer.
   - Suivre les instructions à l'écran pour compléter l'importation.

**Informations :** Cette étape permettra de remplir l’application avec des données d'exemple, facilitant ainsi les tests et la démonstration de l'ERP Dolibarr.

## 4. Sauvegarde et Restauration des Données

### 4.1 Sauvegarde des Données

**Action :** Sauvegarder la base de données dans le dossier local pour garantir la continuité des informations.

- **Commandes :**
```bash
docker exec dolibarr-db /usr/bin/mysqldump -u dolibarruser --password=dolibarrpass dolibarr > /home/user/sae-dolibarr/data/dolibarr_backup.sql 
```

**Informations :** Cette commande exécute un mysqldump à l’intérieur du conteneur dolibarr-db, pour exporter la base de données Dolibarr et la sauvegarder dans le dossier /home/user/sae-dolibarr/data.

## 4.2 Restauration des Données

**Action :** Restauration de la base de données à partir de la sauvegarde en cas de besoin.


- **Commandes :**
```bash
cat /home/user/sae-dolibarr/data/dolibarr_backup.sql | docker exec -i dolibarr-db /usr/bin/mysql -u dolibarruser --password=dolibarrpass dolibarr
```

**Informations :** Cette commande lit le fichier de sauvegarde dolibarr_backup.sql et restaure les données dans le conteneur dolibarr-db.


## Conclusion

Ce projet a permis de mettre en place une instance de Dolibarr opérationnelle dans un environnement Docker, avec des données fictives pour simuler une utilisation réelle. La stratégie de sauvegarde garantit la sécurité des données et la continuité de service.

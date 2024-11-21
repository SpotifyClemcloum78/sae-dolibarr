#!/bin/bash

# Vérifier si Docker est installé
if ! command -v docker &> /dev/null
then
    echo "Docker n'est pas installé. Veuillez installer Docker."
    exit 1
fi

# Variables pour la configuration de MariaDB et Dolibarr
MYSQL_ROOT_PASSWORD="root"
MYSQL_DATABASE="dolibarr"
DOLIBARR_DB_HOST="mariadb"
DOLIBARR_DB_USER="root"
DOLIBARR_DB_PASSWORD="root"
DOLIBARR_DB_NAME="dolibarr"
DOLIBARR_URL_ROOT="http://0.0.0.0"
PHP_INI_DATE_TIMEZONE="Europe/Paris"

# Démarrer le conteneur MariaDB
echo "Lancement du conteneur MariaDB..."
docker run -d \
  --name mariadb \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  mariadb:latest

# Attendre que MariaDB soit prêt
echo "Attente de l'initialisation de MariaDB..."
sleep 15  # Attendre quelques secondes pour que MariaDB démarre

# Installer MySQL dans le conteneur MariaDB
echo "Installation de MySQL dans le conteneur MariaDB..."
docker exec mariadb bash -c "apt-get update && apt-get install -y mysql-client"

# Vérifier si MySQL est correctement installé
if ! docker exec mariadb mysql --version &>/dev/null; then
    echo "MySQL n'a pas pu être installé ou n'est pas accessible."
    exit 1
fi

# Démarrer le conteneur Dolibarr
echo "Lancement du conteneur Dolibarr..."
docker run -d \
  --name dolibarr \
  --link mariadb \
  -e DOLI_DB_HOST=$DOLIBARR_DB_HOST \
  -e DOLI_DB_USER=$DOLIBARR_DB_USER \
  -e DOLI_DB_PASSWORD=$DOLIBARR_DB_PASSWORD \
  -e DOLI_DB_NAME=$DOLIBARR_DB_NAME \
  -e DOLI_URL_ROOT=$DOLIBARR_URL_ROOT \
  -e PHP_INI_DATE_TIMEZONE=$PHP_INI_DATE_TIMEZONE \
  -p 80:80 \
  tuxgasy/dolibarr

# Vérifier si les conteneurs ont démarré correctement
if [ $? -eq 0 ]; then
    echo "Les conteneurs ont été lancés avec succès."
else
    echo "Une erreur s'est produite lors du démarrage des conteneurs."
    exit 1
fi


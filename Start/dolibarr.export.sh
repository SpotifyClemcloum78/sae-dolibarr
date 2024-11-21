#!/bin/bash

# Configuration
DATA_DIR=/home/user/sae-dolibarr/data  # Répertoire de destination sur l'hôte
CONTAINER_DB="mariadb"
DB_NAME="dolibarr"
DB_USER="root"
DB_PASSWORD="root"
CSV_FILE="$DATA_DIR/export.csv"  # Chemin vers le fichier CSV d'export sur l'hôte

# Vérifier si le répertoire /var/lib/mysql-files/ existe dans le conteneur
echo "Vérification de l'existence du répertoire /var/lib/mysql-files/ dans le conteneur..."
docker exec $CONTAINER_DB bash -c "if [ ! -d /var/lib/mysql-files ]; then mkdir -p /var/lib/mysql-files/ && chmod 777 /var/lib/mysql-files/; else echo '/var/lib/mysql-files/ existe déjà'; fi"

# Supprimer le fichier export.csv si il existe déjà dans le conteneur
echo "Suppression du fichier export.csv existant dans le conteneur..."
docker exec $CONTAINER_DB rm -f /var/lib/mysql-files/export.csv

# Préparer la requête SQL pour exporter les données
SQL_QUERY="SELECT u.login, u.lastname, u.address, u.office_phone, u.email
           INTO OUTFILE '/var/lib/mysql-files/export.csv'
           FIELDS TERMINATED BY ',' 
           ENCLOSED BY '\"'
           LINES TERMINATED BY '\n'
           FROM llx_user u;"

# Exécuter la commande dans le conteneur MariaDB
echo "Exportation des données vers le fichier CSV..."
docker exec -i $CONTAINER_DB mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME -e "$SQL_QUERY"

# Vérifier si le fichier a été généré dans le conteneur
echo "Vérification de l'existence du fichier CSV dans le conteneur..."
docker exec $CONTAINER_DB ls /var/lib/mysql-files/

# Si le fichier existe, les permissions sont ajusté pour permettre son accès
echo "Ajustement des permissions du fichier CSV exporté..."
docker exec $CONTAINER_DB chmod 777 /var/lib/mysql-files/export.csv

# Copier le fichier exporté du conteneur vers le répertoire local
echo "Copie du fichier CSV exporté..."
docker cp $CONTAINER_DB:/var/lib/mysql-files/export.csv $CSV_FILE

# Vérifier si l'exportation a réussi
if [ $? -eq 0 ]; then
    echo "Exportation réussie ! Le fichier est disponible dans $CSV_FILE."
else
    echo "Erreur lors de l'exportation."
    exit 1
fi


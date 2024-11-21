#!/bin/bash

# Variables
DATA_DIR="/home/user/sae-dolibarr/data"
CSV_TO_IMPORT="$DATA_DIR/import.csv"
CONTAINER_DB="dolibarr-db"
DB_NAME="dolibarr"
DB_USER="dolibarruser"
DB_PASSWORD="dolibarrpass"

# Vérification de l'existence du fichier CSV
if [ ! -f "$CSV_TO_IMPORT" ]; then
    echo "Erreur : Le fichier à importer ($CSV_TO_IMPORT) est introuvable."
    exit 1
fi

echo "Importation des données depuis $CSV_TO_IMPORT..."

# Copier le fichier CSV dans le conteneur MariaDB
docker cp "$CSV_TO_IMPORT" "$CONTAINER_DB:/var/lib/mysql-files/import.csv"

echo "Vérification du fichier dans le conteneur..."
docker exec "$CONTAINER_DB" ls /var/lib/mysql-files/

# Vérifier si le fichier existe dans le conteneur
if [ $? -ne 0 ]; then
    echo "Erreur : Le fichier CSV n'a pas été copié dans le conteneur."
    exit 1
fi

# Ajuster les permissions sur le fichier pour s'assurer qu'il est lisible
echo "Ajustement des permissions sur le fichier import.csv..."
docker exec "$CONTAINER_DB" chmod 777 /var/lib/mysql-files/import.csv

# Importation dans la table cible (llx_user)
echo "Importation dans la table 'llx_user'..."
docker exec -i "$CONTAINER_DB" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" << EOF
LOAD DATA INFILE '/var/lib/mysql-files/import.csv'
INTO TABLE llx_user
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(login, lastname, address, office_phone, email);
EOF

# Vérifier si l'importation a réussi
if [ $? -eq 0 ]; then
    echo "Importation terminée avec succès."
else
    echo "Erreur lors de l'importation."
    exit 1
fi


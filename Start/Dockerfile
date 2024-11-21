# Utiliser l'image officielle MariaDB
FROM mariadb:latest

# Installer le client MySQL (si vous en avez besoin)
RUN apt-get update && \
    apt-get install -y mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Expose le port par défaut de MariaDB
EXPOSE 3306


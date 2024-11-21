docker ps -aq | xargs -r docker rm -f

if [ $? -eq 0 ]; then
    echo "Tous les conteneurs Docker ont été supprimés avec succès."
else
    echo "Une erreur s'est produite lors de la suppression des conteneurs."
    exit 1
fi

docker network rm dolibarr-network

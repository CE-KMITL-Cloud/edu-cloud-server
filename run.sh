# Auto setup script for preparing server
# by Raweeroj

#!/bin/sh

echo "Run Kong API Gatway..."
pwd
cd ./kong-gw/
docker compose up -d docker-compose.yml

echo "Run Service ..."
pwd
cd ..
pwd
docker compose up -d 

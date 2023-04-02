# Auto setup script for preparing server
# by Raweeroj

#!/bin/sh

echo "Run Kong API Gatway..."
cd kong-gw/
docker compose up -d docker-compose.yml

echo "Run Service ..."
cd ..
docker compose up -d 

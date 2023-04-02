# Auto setup script for preparing server
# by Raweeroj

#!/bin/sh

echo "Run Kong API Gatway..."
docker compose up -d -f kong-gw/docker-compose.yml

echo "Run Service ..."
docker compose up -d 

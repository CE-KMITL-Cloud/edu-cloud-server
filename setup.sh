# Auto setup script for preparing server
# by Raweeroj

#!/bin/sh

echo "Clone repository..."
git clone https://github.com/CE-KMITL-Cloud/edu-cloud-server.git
cd /edu-cloud-server/monitoring-system

echo "Install Node-exporter"
sudo ./install.sh

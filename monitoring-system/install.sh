# Auto install Node-exportor for export Linux metrics
# by Raweeroj

#!/bin/sh

version="1.4.0-rc.0"
url_path="/metrics"
port=9100

echo "Get Node-exportor..."
wget https://github.com/prometheus/node_exporter/releases/download/v$version/node_exporter-$version.linux-amd64.tar.gz
tar xvf node_exporter-$version.linux-amd64.tar.gz

echo "Installing..."
cd node_exporter-$version.linux-amd64
sudo cp node_exporter /usr/local/bin

echo "Cleaning directory..."
cd ..
rm -rf ./node_exporter-$version.linux-amd64
rm node_exporter-$version.linux-amd64.tar.gz
sudo rm /etc/systemd/system/node_exporter.service
sudo systemctl stop node_exporter

echo "Create user..."
sudo useradd --no-create-home --shell /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo "Creating Service..."
sudo echo "[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/node_exporter \
    --collector.cpu \
    --collector.diskstats \
    --collector.filesystem \
    --collector.loadavg \
    --collector.meminfo \
    --collector.filefd \
    --collector.netdev \
    --collector.stat \
    --collector.netstat \
    --collector.systemd \
    --collector.uname \
    --collector.vmstat \
    --collector.time \
    --collector.mdadm \
    --collector.zfs \
    --collector.tcpstat \
    --collector.bonding \
    --collector.hwmon \
    --collector.arp \
    --web.listen-address=:$port \
    --web.telemetry-path=$url_path

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/node_exporter.service

echo "Start service..."
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
systemctl daemon-reload

echo "Allow firewall..."
sudo ufw allow $port
sudo ufw reload

echo "Complete!!"
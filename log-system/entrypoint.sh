#!/bin/sh

# Start Logstash pipeline 
echo "Starting NGINX ..."
/usr/sbin/nginx 

# Start Logstash pipeline 
echo "Starting Syslog-ng ..."
/usr/sbin/syslog-ng -F --no-caps
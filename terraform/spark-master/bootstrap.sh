#!/bin/bash

#Exit immediately if a command exits with a non-zero status
set -e

echo "Setting hostname in /etc/hosts..."

sudo sh -c "echo \"$(hostname -I) $(hostname)\" >> /etc/hosts"

echo "Starting Spark master..."
cd /opt/spark/default
sbin/start-master.sh

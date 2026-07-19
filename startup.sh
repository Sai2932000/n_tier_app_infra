#!/bin/bash

exec > /var/log/startup-script.log 2>&1

apt-get update -y
apt-get install -y nginx

echo "Hello from $(hostname)" > /var/www/html/index.html

systemctl enable nginx
systemctl start nginx
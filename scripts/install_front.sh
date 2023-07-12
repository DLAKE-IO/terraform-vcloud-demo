#!/bin/bash

# We want to make the script run post tools customization (e.g setting host name and IP address).
# See https://kb.vmware.com/s/article/1026614
if [ x$1 == x"postcustomization" ]; then

# Do not execute the script if the outside world is not reachable
ping -c 1 8.8.8.8 > /dev/null

if [ $? -ne 0 ]; then
    echo "8.8.8.8 is not reachable"
    exit 0
fi

# Update the system
sudo apt-get update

# Install nginx
sudo apt-get install -y nginx

# Start nginx
sudo systemctl start nginx

# Enable nginx to start on boot
sudo systemctl enable nginx

# Create a default vhost configuration
echo "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }
}" | sudo tee /etc/nginx/sites-available/default

# Create an hello-world index.html
echo "<html>
<head>
<title>Hello World from $(hostname)</title>
</head>
<body>
<h1>Hello, World from $(hostname)!</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Restart nginx to apply changes
sudo systemctl restart nginx

fi

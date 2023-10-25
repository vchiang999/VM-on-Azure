#!/bin/bash

sudo apt update && sudo apt install lamp-server^ && sudo apt install unzip

#Create info.php page
sudo sh -c 'echo "<?php phpinfo(); ?>" > /var/www/html/info.php'

echo "Download and unzip Welcome website"
wget https://github.com/vchiang999/VM-on-Azure/raw/main/LAMP-Stack/SimpleWebsite.zip
unzip SimpleWebsite.zip

echo "Moving files to correct location"
sudo mv ./SimpleWebsite/* /var/www/html/

echo "Your Web Server is up and running. You can now connect!"
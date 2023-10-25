#!/bin/bash

sudo apt update && sudo apt install lamp-server^ && sudo apt install unzip

echo "Displaying Apache Version"
apache2 -v
echo ""
echo ""

echo "Displaying MySQL version"
mysql -V
echo ""
echo ""

echo "Displaying PHP version"
php -v
echo ""
echo ""

echo "creating php info file"
sudo sh -c 'echo "<?php phpinfo(); ?>" > /var/www/html/info.php'
echo "Done"
echo ""
echo ""

echo "Download and unzip Welcome website"
wget https://github.com/vchiang999/VM-on-Azure/raw/main/LAMP-Stack/SimpleWebsite.zip
unzip SimpleWebsite.zip
echo ""
echo ""

echo "Moving files to correct location"
sudo mv ./SimpleWebsite/* /var/www/html/
echo ""
echo ""

echo "Web Server is up and running. You can now connect!"
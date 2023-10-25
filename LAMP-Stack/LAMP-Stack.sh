#!/bin/bash

sudo apt update && sudo apt install lamp-server^

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

echo "create php file"
sudo sh -c 'echo "<?php phpinfo(); ?>" > /var/www/html/info.php'
echo "Done"
echo ""
echo ""
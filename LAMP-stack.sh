#!/bin/bash

sudo apt update && sudo apt install lamp-server^

echo "Displaying Apache Version"
apache2 -v

echo "Displaying MySQL version"
mysql -V

echo "Displaying PHP version"
php -v

echo "create php file"
sudo sh -c 'echo "<?php phpinfo(); ?>" > /var/www/html/info.php'
echo "Done"